package com.ds.redis.provider.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;
import java.util.Set;

import javax.annotation.PostConstruct;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.scheduling.annotation.EnableScheduling;
import org.springframework.scheduling.annotation.Scheduled;

import com.ds.common.constants.Constants.LimitType;
import com.ds.common.constants.Constants.NormalState;
import com.ds.common.constants.Constants.RoomLevel;
import com.ds.common.task.UrlConfigVo;
import com.ds.common.util.JSONUtils;
import com.ds.entity.BetOdd;
import com.ds.entity.BetPlay;
import com.ds.entity.SiteConfig;
import com.ds.entity.TableConfig;
import com.ds.game.service.GameTypeService;
import com.ds.limit.vo.BetLimitResult;
import com.ds.redis.api.RedisService;
import com.ds.redis.key.KeyConfig;
import com.ds.redis.provider.common.UrlConfigCache;
import com.ds.redis.provider.limit.BetLimitCache;
import com.ds.redis.provider.odds.BetOddsCache;
import com.ds.redis.provider.play.PlayCache;
import com.ds.redis.provider.service.CacheService;
import com.ds.redis.provider.site.SiteConfigCache;
import com.ds.room.service.SiteConfigService;
import com.ds.room.service.TableConfigService;
import com.ds.room.vo.SiteConfigVo;
import com.ds.room.vo.TableConfigVo;

/**
 * 缓存service
 * 
 * @author jackson
 *
 */
@Configuration
@EnableScheduling
public class CacheServiceImpl implements CacheService, KeyConfig {

	private Logger logger = LoggerFactory.getLogger(this.getClass());

	@Autowired
	private BetLimitCache betLimitCache;

	@Autowired
	private BetOddsCache betOddsCache;

	@Autowired
	private SiteConfigCache siteConfigCache;

	@Autowired
	private UrlConfigCache urlConfigCache;

	@Autowired
	private RedisService redisService;

	@Autowired
	private GameTypeService gameTypeService;

	@Autowired
	private PlayCache playCache;

	@Autowired
	private TableConfigService tableConfigService;
	
	@Autowired
	private SiteConfigService siteConfigService;

	/**
	 * 缓存
	 */
	@PostConstruct
	@Scheduled(cron = "0 0/5 * * * ?")
	public void cacheBetOdd() {
		logger.info("更新缓存~");
		// 游戏种类
		List<com.ds.entity.GameType> gameTypeAll = this.gameTypeService.findAll();
		Map<String, com.ds.entity.GameType> lottoTypeMap = new HashMap<>();
		for (com.ds.entity.GameType gameType : gameTypeAll) {
			lottoTypeMap.put(gameType.getType(), gameType);
		}
		this.redisService.set(KEY_GAME_TYPE, JSONUtils.map2Json(lottoTypeMap));
		// 赔率
		Map<Integer, Map<Long, Map<String, BetOdd>>> tableIdBetOddsMap = this.betOddsCache.cacheBetOddsData();
		Set<Entry<Integer, Map<Long, Map<String, BetOdd>>>> oddEntrySet = tableIdBetOddsMap.entrySet();
		for (Entry<Integer, Map<Long, Map<String, BetOdd>>> entry : oddEntrySet) {
			this.redisService.set(KEY_PREFIX_ODDS + entry.getKey(), JSONUtils.map2Json(entry.getValue()));
		}
		// 限额
		Map<Integer, Map<String, BetLimitResult>> betLimitMap = this.betLimitCache.cacheBetLimitData();
		Set<Entry<Integer, Map<String, BetLimitResult>>> limitEntrySet = betLimitMap.entrySet();
		for (Entry<Integer, Map<String, BetLimitResult>> entry : limitEntrySet) {
			this.redisService.set(KEY_PREFIX_LIMIT + entry.getKey(), JSONUtils.map2Json(entry.getValue()));
		}
		// 玩法
		Map<String, List<BetPlay>> playMap = this.playCache.cachePlay();
		Set<Entry<String, List<BetPlay>>> playEntrySet = playMap.entrySet();
		for (Entry<String, List<BetPlay>> entry : playEntrySet) {
			this.redisService.set(KEY_PLAY + entry.getKey(), JSONUtils.bean2Json(entry.getValue()));
		}
		// 房间
		Map<Integer, List<TableConfigVo>> tablesMap = this.siteConfigCache.cacheTablesMap();
		Set<Entry<Integer, List<TableConfigVo>>> tablesEntrySet = tablesMap.entrySet();
		for (Entry<Integer, List<TableConfigVo>> entry : tablesEntrySet) {
			this.redisService.set(KEY_TABLE + entry.getKey(), JSONUtils.bean2Json(entry.getValue()));
		}
		// 房间
		Map<Integer, SiteConfigVo> roomMap = this.siteConfigCache.cacheRoomMap();
		Set<Entry<Integer, SiteConfigVo>> roomEntrySet = roomMap.entrySet();
		for (Entry<Integer, SiteConfigVo> entry : roomEntrySet) {
			this.redisService.set(KEY_ROOM + entry.getKey(), JSONUtils.bean2Json(entry.getValue()));
		}
		// urlconfig 基本配置
		List<UrlConfigVo> urlCongfigList = this.urlConfigCache.cacheUrlConfigByTableId();
		if (urlCongfigList != null && urlCongfigList.size() > 0) {
			for (UrlConfigVo urlConfigVo : urlCongfigList) {
				String value = JSONUtils.bean2Json(urlConfigVo);
				this.redisService.set(KEY_URL_CONFIG_TABLE_ID + urlConfigVo.getTableId(), value);
				
			}
		}
		
		//网站
		List<SiteConfig> sites =  siteConfigService.findAll();
		if(null != sites && !sites.isEmpty()){
			logger.info("网站缓存开始===========");
			for(SiteConfig site:sites){
				this.redisService.set(KEY_URL_CONFIG_SITE_ID + site.getSiteId(),  JSONUtils.bean2Json(site));
			}
		}
		
		//基本配置
		Map<String, Object> basicMap = new HashMap<String, Object>();

		Map<String, Object> lotoNameMap = new HashMap<String, Object>();
		Map<String, String> gameTypeMap = new HashMap<>();

		for (com.ds.entity.GameType gameType : gameTypeAll) {
			gameTypeMap.put(gameType.getType(), gameType.getName());
		}

		lotoNameMap.put("name", "游戏类型");
		lotoNameMap.put("list", gameTypeMap);
		basicMap.put("lotoName", lotoNameMap);

		Map<String, Object> statusMap = new HashMap<String, Object>();
		Map<String, String> stateMap = NormalState.toMap();
		statusMap.put("name", "状态");
		statusMap.put("list", stateMap);
		basicMap.put("status", statusMap);

		Map<String, Object> tableMap = new HashMap<String, Object>();
		Map<String, String> tMap = new HashMap<>();
		List<TableConfig> tables = this.tableConfigService.findAll();
		for (TableConfig t : tables) {
			tMap.put(t.getId() + "", t.getName());
		}
		tableMap.put("name", "房间");
		tableMap.put("list", tMap);
		basicMap.put("tableName", tableMap);

		Map<String, Object> levelMap = new HashMap<String, Object>();
		Map<String, String> lMap = RoomLevel.toMap();
		levelMap.put("name", "房间等级");
		levelMap.put("list", lMap);
		basicMap.put("roomLevel", levelMap);

		Map<String, Object> limitMap = new HashMap<String, Object>();
		Map<String, String> lmMap = LimitType.toMap();
		limitMap.put("name", "限额种类");
		limitMap.put("list", lmMap);
		basicMap.put("limitType", limitMap);

		Map<String, Object> oddsBelongToMap = new HashMap<String, Object>();
		Map<String, String> oMap = new HashMap<>();
		List<BetOdd> odds = this.betOddsCache.findByParentIdIsNull();
		for (BetOdd t : odds) {
			oMap.put(t.getId() + "", t.getName());
		}
		oddsBelongToMap.put("name", "赔率所属种类");
		oddsBelongToMap.put("list", oMap);
		basicMap.put("oddsBelongTo", oddsBelongToMap);

		this.redisService.set(KEY_BASIC, JSONUtils.map2Json(basicMap));

		// TODO:网站配置
	}
}
