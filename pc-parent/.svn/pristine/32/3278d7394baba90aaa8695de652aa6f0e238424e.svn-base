package com.ds.task.betinfo;

import java.util.List;

import javax.jms.Queue;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;

import com.ds.bet.service.BetInfoYesterdayService;
import com.ds.common.bet.KeyConfig;
import com.ds.common.util.DateUtil;
import com.ds.mq.provider.p2p.MQProviderService;
import com.ds.task.tasklist.AbstractTask;
import com.ds.task.vo.MinMaxId;

public class GenerateYesterdayDataTask implements AbstractTask, KeyConfig {

	private final Logger logger = LoggerFactory.getLogger(this.getClass());

	private final long offset = 20000l;

	private final String everyDayBetMinMaxIdSqlBuffer = "SELECT MIN(id) minId, MAX(id) maxId FROM :tableName WHERE DATE_FORMAT(create_time, '%Y-%m-%d') = ?";

	private BetInfoYesterdayService betInfoYesterdayService;

	private MQProviderService mqService;

	private JdbcTemplate jdbcTemplate;

	private Queue queueBetDataYesterday;

	private List<String> distinctPlays;

	public GenerateYesterdayDataTask(BetInfoYesterdayService betInfoYesterdayService, MQProviderService mqService, JdbcTemplate jdbcTemplate, Queue queueBetDataYesterday, List<String> distinctPlays) {
		this.betInfoYesterdayService = betInfoYesterdayService;
		this.mqService = mqService;
		this.jdbcTemplate = jdbcTemplate;
		this.queueBetDataYesterday = queueBetDataYesterday;
		this.distinctPlays = distinctPlays;
	}

	@Override
	public void execute() {
		try {
			String needLossDate = DateUtil.getDaysAgo(1, "-");
			Long count = this.betInfoYesterdayService.queryCountLossToday(needLossDate);
			if (count > 0) {
				return;
			}

			String tableName = null;
			List<MinMaxId> idList = null;
			MinMaxId minMaxId = null;
			for (String play : distinctPlays) {
				tableName = PREFIX_BET_TABLE + play;
				idList = this.jdbcTemplate.query(//
						everyDayBetMinMaxIdSqlBuffer.toString().replaceAll(":tableName", tableName), //
						new Object[] { needLossDate }, //
						new BeanPropertyRowMapper<MinMaxId>(MinMaxId.class));
				if (idList != null && idList.size() > 0) {
					minMaxId = idList.get(0);
					if (null == minMaxId.getMinId() || null == minMaxId.getMaxId()) {
						continue;
					}
					Long start = minMaxId.getMinId() - 1;
					while (start < minMaxId.getMaxId()) {
						if (minMaxId.getMaxId() - start >= offset) {
							this.mqService.send(queueBetDataYesterday, tableName + ":" + (start + 1) + ":" + (start + offset));
							start += offset;
						} else {
							this.mqService.send(queueBetDataYesterday, tableName + ":" + (start + 1) + ":" + minMaxId.getMaxId());
							break;
						}
					}
				}
			}
		} catch (Exception e) {
			logger.error("generateYesterdayDataTask 同步昨天数据任务出现异常 : ", e);
		}

	}

}
