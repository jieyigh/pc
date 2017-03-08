package com.ds.task.tasklist;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.PostConstruct;
import javax.annotation.Resource;
import javax.jms.Queue;
import javax.transaction.Transactional;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.scheduling.annotation.EnableScheduling;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import com.ds.bet.service.BetInfoYesterdayService;
import com.ds.common.bet.BetLimitValue;
import com.ds.common.bet.BetType;
import com.ds.common.bet.KeyConfig;
import com.ds.common.constants.Constants;
import com.ds.common.task.UrlConfigVo;
import com.ds.common.util.JSONUtils;
import com.ds.common.util.StringUtil;
import com.ds.entity.BetOdd;
import com.ds.entity.BetPlay;
import com.ds.mq.provider.p2p.MQProviderService;
import com.ds.odds.service.BetOddService;
import com.ds.play.service.PlayService;
import com.ds.redis.api.RedisService;
import com.ds.task.betinfo.GenerateBetTableTask;
import com.ds.task.betinfo.GenerateYesterdayDataTask;

@Component
@EnableScheduling
public class TaskList implements KeyConfig, com.ds.common.mq.queue.key.KeyConfig, com.ds.redis.key.KeyConfig {

	private final Logger logger = LoggerFactory.getLogger(this.getClass());

	private final StringBuilder initBetLimitByTableId = new StringBuilder("INSERT INTO pc_bet_limit(")//
			.append("name, type, game_type, enabled, table_id, min, max, sing_play_limit, create_time) ")//
			.append("VALUES ");
	
	private final StringBuilder initBetOddsByTableId = new StringBuilder("INSERT INTO pc_bet_odds(")//
			.append("name, play, type, enabled, parent_id, table_id, create_time) ")//
			.append("VALUES ");

	@Autowired
	private BetInfoYesterdayService betInfoYesterdayService;

	@Autowired
	private PlayService playService;

	@Autowired
	private RedisService redisService;
	
	@Autowired
	private BetOddService betOddService;

	@Autowired
	private JdbcTemplate jdbcTemplate;

	@Autowired
	private MQProviderService mqService;

	@Resource(name = QUEUE_BET_DATA_YESTERDAY)
	private Queue queueBetDataYesterday;

	@Transactional
	@PostConstruct
	@Scheduled(cron = "0 0 0/1 * * ?")
	public void generateBetTableTask() {
		logger.info("触发任务generateBetTableTask,当前时间 = {}", new Date().toString());
		AbstractTask task = new GenerateBetTableTask(jdbcTemplate, this.getDistinctPlays());
		task.execute();
	}

	@Transactional
	@PostConstruct
	@Scheduled(cron = "0 30 0 * * ?")
	public void generateYesterdayDataTask() {
		logger.info("触发任务generateYesterdayDataTask,当前时间 = {}", new Date().toString());
		AbstractTask task = new GenerateYesterdayDataTask(betInfoYesterdayService, mqService, jdbcTemplate, queueBetDataYesterday, this.getDistinctPlays());
		task.execute();
	}

	/**
	 * @Scheduled(cron = "0 0 0/1 * * ?") 每小时
	 * 
	 * @Scheduled(cron = "0 0/5 * * * ?") 每5分钟
	 */
	@Transactional
	@PostConstruct
	//@Scheduled(cron = "0 0 0/1 * * ?")
	@Scheduled(cron = "0 0/5 * * * ?")
	public void generateLimitDataTask() {
		Date now = new Date();
		logger.info("触发任务generateLimitDataTask,当前时间 = {}", now.toString());
		String sql = "SELECT id FROM pc_table_config WHERE id NOT IN (SELECT DISTINCT table_id FROM pc_bet_limit)";
		List<Integer> noLimitTableIdList = this.jdbcTemplate.queryForList(sql, Integer.class);
		if (noLimitTableIdList == null || noLimitTableIdList.size() <= 0) {
			return;
		}
		for (Integer noLimitTableId : noLimitTableIdList) { // 遍历tableId
			//			UrlConfigVo urlConfigVo = tableIdUrlMap.get(noLimitTableId);
			String urlConfigStr = this.redisService.get(KEY_URL_CONFIG_TABLE_ID + noLimitTableId);
			if (StringUtil.isNull(urlConfigStr)) {
				logger.info("tableId = {}的限额数据还没生成, 请耐心等待到下一个整点时间", noLimitTableId);
				continue;
			}
			UrlConfigVo urlConfigVo = JSONUtils.json2Bean(urlConfigStr, UrlConfigVo.class);
			List<BetPlay> betPlayList = this.playService.getPlaysByGameType(urlConfigVo.getGameType());
			if (betPlayList == null || betPlayList.size() <= 0) {
				continue;
			}
			StringBuilder valueBuffer = new StringBuilder();
			List<Object> paramList = new ArrayList<>();
			BetPlay betPlay = null;
			for (int i = 0; i < betPlayList.size(); i++) {
				betPlay = betPlayList.get(i);
				valueBuffer.append("(?,?,?,?,?,?,?,?,?)");
				paramList.add(BetType.getNameByType(betPlay.getType()));
				paramList.add(betPlay.getType());
				paramList.add(urlConfigVo.getGameType());
				paramList.add(Constants.NormalState.启用.getKey());
				paramList.add(noLimitTableId);
				paramList.add(BetLimitValue.MIN.getLimit());
				paramList.add(BetLimitValue.MAX.getLimit());
				// {key=单点, {key=min|max, value=限额值}}
				processSingPlayLimit(paramList, betPlay);
				paramList.add(now);
				if (i != betPlayList.size() - 1) {
					valueBuffer.append(", ");
				}
			}
			this.jdbcTemplate.update(initBetLimitByTableId.toString() + valueBuffer.toString(), paramList.toArray(new Object[paramList.size()]));
		}

	}
	
	
	
	@Transactional
	@PostConstruct
	@Scheduled(cron = "0 0/5 * * * ?")
	public void generateOddsDataTask() {
		Date now = new Date();
		logger.info("触发任务generateOddsDataTask,当前时间 = {}", now.toString());
		String sql = "SELECT id FROM pc_table_config WHERE id NOT IN (SELECT DISTINCT table_id FROM pc_bet_odds WHERE parent_id IS NOT NULL AND table_id <> 0)";
		List<Integer> noOddsTableIdList = this.jdbcTemplate.queryForList(sql, Integer.class);
		if (noOddsTableIdList == null || noOddsTableIdList.size() <= 0) {
			return;
		}
		for (Integer noOddTableId : noOddsTableIdList) { // 遍历tableId
			List<BetOdd> odds = this.betOddService.findByTableId(0);
			if (odds == null || odds.size() <= 0) {
				return;
			}
			StringBuilder valueBuffer = new StringBuilder();
			List<Object> paramList = new ArrayList<>();
			BetOdd betodd = null;
			for (int i = 0; i < odds.size(); i++) {
				betodd = odds.get(i);
				valueBuffer.append("(?,?,?,?,?,?,?)");
				paramList.add(betodd.getName());
				paramList.add(betodd.getPlay());
				paramList.add(betodd.getType());
				paramList.add(Constants.NormalState.启用.getKey());
				paramList.add(betodd.getParentId());
				paramList.add(noOddTableId);
				paramList.add(now);
				if (i != odds.size() - 1) {
					valueBuffer.append(", ");
				}
			}
			this.jdbcTemplate.update(initBetOddsByTableId.toString() + valueBuffer.toString(), paramList.toArray(new Object[paramList.size()]));
		}

	}
	
	

	private void processSingPlayLimit(List<Object> paramList, BetPlay betPlay) {
		if (BetType.CAO.getType().equals(betPlay.getType())) {
			Map<Integer, Map<String, Object>> singPlayLimitMap = new HashMap<>();
			for (int sing = betPlay.getMin(); sing <= betPlay.getMax(); sing++) {
				Map<String, Object> map = singPlayLimitMap.get(sing);
				if (map == null) {
					map = new HashMap<>();
					singPlayLimitMap.put(sing, map);
				}
				map.put(BetLimitValue.MIN.getName(), BetLimitValue.MIN.getLimit());
				map.put(BetLimitValue.MAX.getName(), BetLimitValue.MAX.getLimit());
			}
			paramList.add(JSONUtils.map2Json(singPlayLimitMap));
		} else {
			paramList.add(null);
		}
	}

	private List<String> getDistinctPlays() {
		List<String> distinctPlays = this.playService.getDistinctPlay();
		if (distinctPlays == null || distinctPlays.size() <= 0) {
			throw new RuntimeException("pc_bet_play is no data");
		}
		return distinctPlays;
	}

}
