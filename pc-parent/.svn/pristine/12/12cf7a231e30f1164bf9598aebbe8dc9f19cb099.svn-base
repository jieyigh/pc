package com.ds.betinfo.record.service;

import javax.annotation.PostConstruct;
import javax.annotation.Resource;
import javax.jms.Message;
import javax.transaction.Transactional;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jms.annotation.JmsListener;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;

import com.ds.betinfo.record.consumer.AbstractMqConsumer;
import com.ds.betinfo.record.consumer.SyncBetDataYesterdayConsumer;
import com.ds.betinfo.record.consumer.SyncBetRecordConsumer;
import com.ds.betinfo.record.consumer.SyncConfigData;
import com.ds.common.mq.queue.key.KeyConfig;

@Service
public class BetInfoRecordService implements KeyConfig {
	
	private Logger logger = LoggerFactory.getLogger(this.getClass());

	@Resource(name = "jdbcTemplate")
	private JdbcTemplate jdbcTemplate;

	@Resource(name = "recordJdbcTemplate")//第二数据源
	private JdbcTemplate recordJdbcTemplate;

	@Transactional
	@JmsListener(destination = QUEUE_BILL_RECORD)
	public void receiveBillRecordQueue(Message message) {
		//从pc-game到pc-game-record 报表数据源
		logger.info("队列 = {}, 消息内容 = {}", QUEUE_BILL_RECORD, message);
		AbstractMqConsumer consumer = new SyncBetRecordConsumer(jdbcTemplate, recordJdbcTemplate, message);
		consumer.execute();
	}

	@Transactional
	@JmsListener(destination = QUEUE_BET_DATA_YESTERDAY)
	public void receiveBetDataYesterday(Message message) {
		logger.info("队列 = {}, 消息内容 = {}", QUEUE_BET_DATA_YESTERDAY, message);
		AbstractMqConsumer consumer = new SyncBetDataYesterdayConsumer(jdbcTemplate, message);
		consumer.execute();
	}

	
	
	@Transactional
	@PostConstruct
	@Scheduled(cron = "0 0/5 * * * ?")
	public void syncConfig() {
		SyncConfigData consumer = new SyncConfigData(jdbcTemplate, recordJdbcTemplate);
		consumer.execute();
		consumer.executeRoom();
		consumer.executeTable();
	}
}
