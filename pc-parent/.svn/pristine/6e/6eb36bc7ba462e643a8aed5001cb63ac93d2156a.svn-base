package com.ds.mq.provider.config;

import javax.jms.Queue;

import org.apache.activemq.command.ActiveMQQueue;
import org.springframework.boot.autoconfigure.jms.activemq.ActiveMQProperties;
import org.springframework.boot.context.properties.EnableConfigurationProperties;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.jms.annotation.EnableJms;

import com.ds.common.mq.queue.key.KeyConfig;

@Configuration
@EnableJms
@EnableConfigurationProperties(value = ActiveMQProperties.class)
public class ActiveMqConfig implements KeyConfig {

	/**
	 * 测试队列
	 */
	@Bean(QUEUE_TEST)
	public Queue queueTest() {
		return new ActiveMQQueue(QUEUE_TEST);
	}

	/**
	 * 转账队列
	 */
	@Bean(QUEUE_PAY_OFF)
	public Queue queueTransfer() {
		return new ActiveMQQueue(QUEUE_PAY_OFF);
	}

	/**
	 * 注单记录队列
	 */
	@Bean(QUEUE_BILL_RECORD)
	public Queue queueBillRecord() {
		return new ActiveMQQueue(QUEUE_BILL_RECORD);
	}

	/**
	 * 注单反水队列
	 */
	@Bean(QUEUE_BET_DATA_YESTERDAY)
	public Queue queueBetDataYesterday() {
		return new ActiveMQQueue(QUEUE_BET_DATA_YESTERDAY);
	}

	/**
	 * 注单限额队列
	 */
	@Bean(QUEUE_BET_LIMIT)
	public Queue queueBetLimit() {
		return new ActiveMQQueue(QUEUE_BET_LIMIT);
	}

	/**
	 * 注单赔率队列
	 */
	@Bean(QUEUE_BET_ODDS)
	public Queue queueBetOdds() {
		return new ActiveMQQueue(QUEUE_BET_ODDS);
	}
}
