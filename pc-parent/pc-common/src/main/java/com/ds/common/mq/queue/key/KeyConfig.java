package com.ds.common.mq.queue.key;

/**
 * 队列名称
 * 
 * @author jackson
 *
 */
public interface KeyConfig {

	final String QUEUE_TEST = "queue.test";

	final String QUEUE_PAY_OFF = "queue.payoff"; // 派彩

	final String QUEUE_BILL_RECORD = "queue.bill.record"; // 拉取注单记录 

	final String QUEUE_BET_DATA_YESTERDAY = "queue.bet.data.yesterday"; // 反水注单记录

	final String QUEUE_BET_LIMIT = "queue.bet.limit"; // 限额

	final String QUEUE_BET_ODDS = "queue.bet.odds"; // 赔率

}
