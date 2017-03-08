package com.ds.payoff.service;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;
import java.util.Set;

import javax.jms.JMSException;
import javax.jms.Message;
import javax.jms.TextMessage;
import javax.transaction.Transactional;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jms.annotation.JmsListener;
import org.springframework.stereotype.Service;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.ds.bet.service.BetInfoService;
import com.ds.bet.vo.WinMoneyVo;
import com.ds.common.mq.queue.key.KeyConfig;
import com.ds.common.service.CommonService;
import com.ds.common.task.UrlConfigVo;
import com.ds.common.util.JSONUtils;
import com.ds.common.util.StringUtil;
import com.ds.entity.PayOffRecord;
import com.ds.payoff.repository.PayOffRecordRepository;
import com.ds.redis.api.RedisService;
import com.ds.transfer.constants.TransferType;
import com.ds.transfer.service.MoneyService;
import com.ds.transfer.vo.MoneyTransferVo;

@Service
public class PayOffService extends CommonService implements KeyConfig, com.ds.redis.key.KeyConfig {

	private Logger logger = LoggerFactory.getLogger(this.getClass());

	private static final String TRANSFER_MEMO = "PC28，下注期数:term";

	@Autowired
	private BetInfoService betInfoService;

	@Autowired
	private MoneyService moneyService;

	@Autowired
	private RedisService redisService;

	@Autowired
	private PayOffRecordRepository payOffRecordRepository;

	@Transactional
	@JmsListener(destination = QUEUE_PAY_OFF)
	public void receiveQueue(Message message) {
		String content = null;
		try {
			if (message instanceof TextMessage) {
				content = ((TextMessage) message).getText();
			}
			logger.info("队列 = {}, 消息内容 = {}", QUEUE_PAY_OFF, content);
			if (StringUtil.isNull(content)) {
				return;
			}
			JSONObject contentMap = JSONObject.parseObject(content);
			Long term = contentMap.getLong("term");
			JSONArray winPlays = contentMap.getJSONArray("winPlays");
			Integer luckyNum = contentMap.getInteger("num");
			String gameType = contentMap.getString("gameType");
			//this.jdbcTemplate.query(sqlBuffer.toString(), new BeanPropertyRowMapper(UrlConfigVo.class));
			// key = tableId, value = {key = username, value = winMoney}
			List<WinMoneyVo> winMoneyList = this.betInfoService.findWinByTerm(winPlays, gameType, term, luckyNum);
			if (winMoneyList == null || winMoneyList.size() <= 0) {
				logger.info("期数 = {}, 没有中奖数据", term);
				return;
			}
			// {key = tableId, {key = username, value = money}}
			Map<Integer, Map<String, MoneyTransferVo>> tableIdTransferMap = new HashMap<>();
			for (WinMoneyVo winMoneyVo : winMoneyList) {
				Map<String, MoneyTransferVo> usernameMap = tableIdTransferMap.get(winMoneyVo.getTableId());
				if (usernameMap == null) {
					usernameMap = new HashMap<>();
					tableIdTransferMap.put(winMoneyVo.getTableId(), usernameMap);
				}
				MoneyTransferVo winTransferVo = usernameMap.get(winMoneyVo.getUsername());
				if (winTransferVo == null) { // 初始化
					winTransferVo = new MoneyTransferVo();
					String urlByTableId = this.redisService.get(KEY_URL_CONFIG_TABLE_ID + winMoneyVo.getTableId());
					UrlConfigVo urlConfigVo = JSONUtils.json2Bean(urlByTableId, UrlConfigVo.class);
					winTransferVo.setSiteId(urlConfigVo.getSiteId());
					winTransferVo.setTableId(winMoneyVo.getTableId());
					winTransferVo.setUsername(winMoneyVo.getUsername());
					winTransferVo.setType(IN);
					winTransferVo.setOrginalUsername(winMoneyVo.getOriginalUsername());
					winTransferVo.setMoney(winMoneyVo.getWinMoney());
					winTransferVo.setMemo(TRANSFER_MEMO.replaceAll(":term", term + ""));
				} else { // 叠加money
					winTransferVo.setMoney(winTransferVo.getMoney().add(winMoneyVo.getWinMoney()));
				}
				usernameMap.put(winMoneyVo.getUsername(), winTransferVo);
			}
			// 派彩加钱
			Date now = new Date();
			Set<Entry<Integer, Map<String, MoneyTransferVo>>> tableIdTransferEntry = tableIdTransferMap.entrySet();
			Map<String, Object> resultMap = null;
			List<PayOffRecord> recordList = new ArrayList<>();
			for (Entry<Integer, Map<String, MoneyTransferVo>> entry : tableIdTransferEntry) { // 每张桌子派彩
				String urlByTableId = this.redisService.get(KEY_URL_CONFIG_TABLE_ID + entry.getKey());
				UrlConfigVo urlConfigVo = JSONUtils.json2Bean(urlByTableId, UrlConfigVo.class);
				resultMap = this.moneyService.transferMoneyInBatch(TransferType.PAY_OFF.getKey(), term, entry.getValue(), urlConfigVo);
				PayOffRecord payOffRecord = new PayOffRecord();
				payOffRecord.setCreateTime(now);
				if (SUCCESS.equals(resultMap.get(STATUS))) { // 成功
					payOffRecord.setResulltState(Integer.valueOf(SUCCESS));
				} else if (PART_OF_SUCCESS.equals(resultMap.get(STATUS))) { // 部分成功
					payOffRecord.setResulltState(Integer.valueOf(PART_OF_SUCCESS));
				} else { // 失败
					payOffRecord.setResulltState(Integer.valueOf(resultMap.get(STATUS) + ""));
				}
				payOffRecord.setResultMsg(resultMap.get(MESSAGE) + "");
				payOffRecord.setTableId(entry.getKey());
				payOffRecord.setTerm(term);
				recordList.add(payOffRecord);
			}
			this.payOffRecordRepository.save(recordList);
		} catch (Exception e) {
			logger.error("queue_payoff 派彩 is error : ", e);
			throw new RuntimeException("queue_payoff is failure :" + content);
		} finally {
			try {
				message.acknowledge();
			} catch (JMSException e) {
				logger.error("jms异常 ", e);
			}
		}
	}
}
