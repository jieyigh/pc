package com.ds.transfer.service.impl;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;
import java.util.Set;

import javax.transaction.Transactional;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.ds.common.service.CommonService;
import com.ds.common.task.UrlConfigVo;
import com.ds.common.util.DateUtil;
import com.ds.common.util.EncUtil;
import com.ds.common.util.HttpUtil;
import com.ds.common.util.JSONUtils;
import com.ds.common.util.RandomUtil;
import com.ds.common.util.client.HttpClientUtil;
import com.ds.entity.TransferRecord;
import com.ds.transfer.constants.TransferType;
import com.ds.transfer.record.service.TransferRecordService;
import com.ds.transfer.service.MoneyService;
import com.ds.transfer.vo.MoneyTransferVo;

@Service
public class MoneyServiceImpl extends CommonService implements MoneyService {

	private Logger logger = LoggerFactory.getLogger(this.getClass());

	private static final String PAY_OFF_BILLNO_PREFIX = "pc_payoff_:term_:tableId_:username";

	private static final String LOSS_BONUS_BILLNO_PREFIX = "pc_loss_bonus_:siteId_:username_:date";

	private static final String TRANSFER_MEMO = "PC28，下注期数:term";

	@Autowired
	private TransferRecordService transferRecordService;

	@Transactional
	//	@Override
	public Map<String, Object> bettransferMoney(Long term, String username, BigDecimal transferMoney, UrlConfigVo urlConfigVo) {
		Map<String, Object> param = new HashMap<>();
		Map<String, Object> paramMap = new HashMap<>();
		TransferRecord record = new TransferRecord();
		try {
			String billNo = "pc_" + System.currentTimeMillis() + "_" + RandomUtil.generateString(5);
			record.setBillNo(billNo);
			record.setCreateTime(new Date());
			record.setMoney(transferMoney);
			record.setTableId(urlConfigVo.getTableId());
			record.setType(OUT);
			record.setUsername(urlConfigVo.getSiteId() + "_" + username);
			record.setTransferType(TransferType.BET.getKey());
			record.setTerm(term);

			paramMap.put("username", username);
			paramMap.put("key", RandomUtil.generateString(4) + EncUtil.toMD5(username + urlConfigVo.getTransferKeyb() + DateUtil.getCurDate()) + RandomUtil.generateString(1));
			paramMap.put("fromLive", 22);
			paramMap.put("billno", billNo);
			paramMap.put("type", OUT);
			paramMap.put("credit", transferMoney);
			paramMap.put("cur", "CNY");
			param.put("params", paramMap);
			param.put("hashCode", urlConfigVo.getTransferHashCode());
			param.put("command", "transfer");
			String result = HttpUtil.sendPost(urlConfigVo.getTransferUrl(), JSONUtils.map2Json(param));
			record.setResultMsg(result);
			record.setSiteId(urlConfigVo.getSiteId());
			record.setOriginalUsername(username);

			Map<String, Object> resultMap = JSONUtils.json2Map(result);
			if ("110012".equals(resultMap.get(STATUS))) { // 钱不够
				return result(TRANS_NO_MONEY, "money is not enough!");
			}
			if (!SUCCESS.equals(resultMap.get(STATUS))) { // 扣款成功
				return failure(result);
			}
		} catch (Exception e) {
			logger.error("转账异常 : ", e);
			return maybe("转账异常 : ");
		} finally {
			try {
				this.transferRecordService.insert(record);
			} catch (Exception e) {
				return maybe("转账异常 : ");
			}
		}
		return success("ok");
	}

	@Transactional
	@Override
	public Map<String, Object> transferMoney(Long term, String username, BigDecimal transferMoney, UrlConfigVo urlConfigVo) {
		Map<String, Object> param = new HashMap<>();
		TransferRecord record = new TransferRecord();
		try {
			String billNo = "pc_bet_" + term + "_" + username + "_" + transferMoney.toString() + "_" + System.currentTimeMillis() + "_" + RandomUtil.generateString(5);
			record.setBillNo(billNo);
			record.setCreateTime(new Date());
			record.setMoney(transferMoney);
			record.setTableId(urlConfigVo.getTableId());
			record.setType(OUT);
			record.setUsername(urlConfigVo.getSiteId() + "_" + username);
			record.setTransferType(TransferType.BET.getKey());
			record.setTerm(term);

			param.put("fromKey", urlConfigVo.getMoneyKey());
			param.put("remitno", billNo);
			param.put("username", username);
			param.put("transType", OUT);
			param.put("wagerCancel", 0);
			param.put("remit", transferMoney);
			param.put("siteId", urlConfigVo.getSiteId());
			param.put("fromKeyType", "70000");
			param.put("memo", TRANSFER_MEMO.replaceAll(":term", term + ""));
			param.put("key", RandomUtil.generateString(5) + EncUtil.toMD5((urlConfigVo.getMoneyKey() + username + billNo)) + RandomUtil.generateString(6));

			//			String result = HttpUtil.sendPost(urlConfigVo.getMoneyUrl(), JSONUtils.map2Json(param));
			String result = HttpClientUtil.sendPost(urlConfigVo.getMoneyUrl() + "/transMoney", param);
			record.setResultMsg(result);
			record.setSiteId(urlConfigVo.getSiteId());
			record.setOriginalUsername(username);

			JSONObject jsonMap = JSONObject.parseObject(result);
			String msg = jsonMap.getString("message");
			String code = jsonMap.getString("code");

			// 用户余额不足
			if ("110012".equals(code)) {
				return result(TRANS_NO_MONEY, "transfer money is not enough");
			}

			// 用户转账失败
			if (!"100000".equals(code)) {
				return failure(result);
			}

		} catch (Exception e) {
			logger.error("转账异常 : ", e);
			return maybe("转账异常 : ");
		} finally {
			try {
				this.transferRecordService.insert(record);
			} catch (Exception e) {
				return maybe("转账异常 : ");
			}
		}
		return success("ok");
	}

	/**
	 * 单个网站转账 List<MoneyTransferVo> moneyList 返回结果数据如下：
	 * {"message":"ok","code":100000,"data":[{"message":"Nomal","data":{"username":"tusername0","money":34.67000,"hashCode":"dsgame"},"code":100000},{"message":"money
	 * is not enough","data":{"username":"tusername1"},"code":110012}]}
	 */
	@Transactional
	@Override
	public Map<String, Object> transferMoneyInBatch(Integer transferType, Long term, Map<String, MoneyTransferVo> moneyMap, UrlConfigVo urlConfigVo) {
		Map<String, Object> resultMap = new HashMap<>();
		List<Map<String, Object>> paramList = new ArrayList<>();
		String billno = null;
		try {
			Set<Entry<String, MoneyTransferVo>> entrySet = moneyMap.entrySet();
			for (Entry<String, MoneyTransferVo> entry : entrySet) {
				String fromKeyType = null;
				MoneyTransferVo vo = entry.getValue();
				if (TransferType.PAY_OFF.getKey().equals(transferType)) {
					billno = PAY_OFF_BILLNO_PREFIX.replaceAll(":term", term + "").replaceAll(":tableId", urlConfigVo.getTableId() + "").replaceAll(":username", entry.getKey());
					fromKeyType = "70001";
				} else if (TransferType.LOSS_BONUS.getKey().equals(transferType)) {
					billno = LOSS_BONUS_BILLNO_PREFIX//
							.replaceAll(":siteId", vo.getSiteId() + "")//
							.replaceAll(":username", vo.getUsername())//
							.replaceAll(":date", DateUtil.getCurDate());
					fromKeyType = "70002";
				} else {
					throw new RuntimeException("不存在transferType=" + transferType);
				}
				vo.setBillno(billno);
				Map<String, Object> param = new HashMap<>();
				param.put("fromKey", urlConfigVo.getMoneyKey());
				param.put("remitno", billno);
				param.put("username", vo.getOrginalUsername());
				param.put("transType", vo.getType());
				param.put("remit", vo.getMoney());
				//				param.put("siteId", vo.getSiteId());
				param.put("siteId", vo.getSiteId());
				param.put("fromKeyType", fromKeyType);
				param.put("memo", vo.getMemo());
				param.put("key", (RandomUtil.generateString(5) + EncUtil.toMD5(urlConfigVo.getMoneyKey() + vo.getOrginalUsername() + billno) + RandomUtil.generateString(6)).toLowerCase());
				paramList.add(param);
			}
			String result = HttpUtil.sendPost(urlConfigVo.getMoneyUrl() + "/transMoneyBatch", JSONArray.toJSONString(paramList));
			JSONObject resultObj = JSONObject.parseObject(result);
			Map<String, Object> failureMap = new HashMap<>();
			List<TransferRecord> recordList = new ArrayList<>();
			List<TransferRecord> repeatRecords = new ArrayList<>();
			if ("100000".equals(resultObj.getString("code"))) { // 通讯正常
				JSONArray dataArr = resultObj.getJSONArray("data");
				String username = null;
				for (int i = 0; i < dataArr.size(); i++) { // 每个用户交互返回
					JSONObject dataObj = dataArr.getJSONObject(i);
					username = dataObj.getJSONObject("data").getString("username");
					TransferRecord record = new TransferRecord();
					MoneyTransferVo moneyTransferVo = moneyMap.get(urlConfigVo.getSiteId() + "_" + username);
					record.setBillNo(moneyTransferVo.getBillno());
					record.setMoney(moneyTransferVo.getMoney());
					record.setResultMsg(JSONObject.toJSONString(dataObj));
					record.setResultState(dataObj.getString("code"));
					if(null != urlConfigVo.getTableId()){
						record.setTableId(urlConfigVo.getTableId());
					}
					record.setTerm(term);
					record.setType(moneyTransferVo.getType());
					record.setUsername(urlConfigVo.getSiteId() + "_" + username);
					record.setOriginalUsername(username);
					record.setSiteId(urlConfigVo.getSiteId());
					record.setTransferType(transferType);
					if ("100000".equals(dataObj.getString("code"))) { // 用户正常
						recordList.add(record);
					} else if ("110015".equals(dataObj.getString("code"))) { // 重复请求
						repeatRecords.add(record);
					} else { // 其他非正常情况
						JSONObject userResult = dataObj.getJSONObject("data");
						logger.info("失败用户 = {}, 原因 = {}", userResult.getString("username"), dataObj.getString("message"));
						failureMap.put(userResult.getString("username"), dataObj.getString("message"));
					}
				}

				if (!recordList.isEmpty()) {
					this.transferRecordService.insertBatch(recordList);
				}

				if (term != null) {
					this.transferRecordService.insertRepeatTermPayoff(term, repeatRecords);
				}
				if (failureMap != null && failureMap.size() > 0) {
					resultMap.put(STATUS, PART_OF_SUCCESS);
					resultMap.put(MESSAGE, failureMap);
					return resultMap;
				}
				return success("ok");
			}
			logger.info("格式错误 = {}", JSONArray.toJSONString(paramList));
			return failure("格式错误");
		} catch (Exception e) {
			logger.error("反水出现异常 : ", e);
			return maybe("loss bonus is exception");
		}
	}


}
