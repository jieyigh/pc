package com.ds.transfer.service;

import java.math.BigDecimal;
import java.util.Map;

import com.ds.common.task.UrlConfigVo;
import com.ds.transfer.vo.MoneyTransferVo;

public interface MoneyService {

	/**
	 * 钱包转账-->目前只支持转入钱到钱包
	 * 
	 * @param term
	 *            期数
	 * @param username
	 *            用户名
	 * @param transferMoney
	 *            转账金额
	 * @param urlConfigVo
	 *            url配置
	 * @return
	 */
	Map<String, Object> transferMoney(Long term, String username, BigDecimal transferMoney, UrlConfigVo urlConfigVo);

	/**
	 * List<MoneyTransferVo> moneyList 返回结果数据如下：
	 * {"message":"ok","code":100000,"data":[{"message":"Nomal","data":{"username":"tusername0","money":34.67000,"hashCode":"dsgame"},"code":100000},{"message":"money
	 * is not enough","data":{"username":"tusername1"},"code":110012}]}
	 */
	public Map<String, Object> transferMoneyInBatch(Integer transferType, Long term, Map<String, MoneyTransferVo> moneyMap, UrlConfigVo urlConfigVo);
	

}
