package com.ds.mq.provider.p2p;

import java.lang.reflect.Field;
import java.util.HashMap;
import java.util.Map;

import javax.annotation.PostConstruct;
import javax.jms.JMSException;
import javax.jms.Queue;
import javax.jms.Session;
import javax.jms.TextMessage;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.autoconfigure.EnableAutoConfiguration;
import org.springframework.jms.core.JmsMessagingTemplate;
import org.springframework.jms.core.MessageCreator;
import org.springframework.stereotype.Component;

import com.ds.common.mq.queue.key.KeyConfig;

@EnableAutoConfiguration
@Component
public class MQProviderService implements KeyConfig {

	private Logger logger = LoggerFactory.getLogger(this.getClass());

	@Autowired
	private JmsMessagingTemplate jmsTemplate;

	private Map<String, Object> queueMap = new HashMap<>();

	@PostConstruct
	public void initQueue() throws Exception {
		Field[] fields = KeyConfig.class.getDeclaredFields();
		Object key = null;
		for (int i = 0; i < fields.length; i++) {
			key = fields[i].get(null);
			logger.info("初始化队列, key = {}", key);
			queueMap.put(key + "", null);
		}
	}

	/**
	 * 发送队列消息
	 * 
	 * @param queue
	 *            队列
	 * @param msg
	 *            消息
	 * @throws Exception
	 */
	public void send(Queue queue, final String msg) throws Exception {
		this.jmsTemplate.getJmsTemplate().setSessionAcknowledgeMode(Session.SESSION_TRANSACTED);
		this.jmsTemplate.getJmsTemplate().setSessionTransacted(true);
		this.jmsTemplate.getJmsTemplate().send(queue, new MessageCreator() {
			@Override
			public javax.jms.Message createMessage(Session session) throws JMSException {
				TextMessage createTextMessage = session.createTextMessage(msg);
				return createTextMessage;
			}
		});
	}

}
