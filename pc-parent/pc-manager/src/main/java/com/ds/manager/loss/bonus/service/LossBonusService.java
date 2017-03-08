package com.ds.manager.loss.bonus.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ds.common.service.CommonService;
import com.ds.common.task.UrlConfigVo;
import com.ds.common.util.JSONUtils;
import com.ds.constants.LossBonusState;
import com.ds.entity.ActivityUser;
import com.ds.redis.api.RedisService;
import com.ds.redis.key.KeyConfig;
import com.ds.service.ActivityUserService;
import com.ds.transfer.constants.TransferType;
import com.ds.transfer.service.MoneyService;
import com.ds.transfer.vo.MoneyTransferVo;

@Service
public class LossBonusService extends CommonService implements KeyConfig {

	@Autowired
	private ActivityUserService activityUserService;

	@Autowired
	private MoneyService moneyService;

	@Autowired
	private RedisService redisService;

	public Map<String, Object> sendBonus(Integer siteId, String operator, String date, String... usernameArr) {
		// 1.查询待反水用户
		List<ActivityUser> activityUserList = this.activityUserService.getActivityUserBySiteIdAndDateOrUsernames(siteId, LossBonusState.will_send.getKey(), date, usernameArr);
		if (activityUserList == null || activityUserList.size() <= 0) {
			return result(SUCCESS, "no more user need to do loss bonus");
		}
		Map<String, MoneyTransferVo> moneyMap = new HashMap<>();
		for (ActivityUser activityUser : activityUserList) {
			if (activityUser.getLossMoneyBonus() == null) {
				continue;
			}
			MoneyTransferVo vo = new MoneyTransferVo();
			vo.setMemo("操作者:" + operator + "(会员亏损送)");
			vo.setMoney(activityUser.getLossMoneyBonus());
			vo.setOrginalUsername(activityUser.getOriginalUsername());
			vo.setSiteId(siteId);
			vo.setType(IN);
			vo.setUsername(activityUser.getUsername());
			moneyMap.put(activityUser.getUsername(), vo);
		}
		if (moneyMap == null || moneyMap.size() <= 0) {
			return result(SUCCESS, "no more user need to do loss bonus");
		}
		UrlConfigVo urlConfigVo = JSONUtils.json2Bean(this.redisService.get(KEY_URL_CONFIG_SITE_ID + siteId), UrlConfigVo.class);
		Map<String, Object> resultMap = this.moneyService.transferMoneyInBatch(TransferType.LOSS_BONUS.getKey(), null, moneyMap, urlConfigVo);
		if (SUCCESS.equals(resultMap.get(STATUS))) { // 成功
			this.activityUserService.updateBonusByState(siteId, date, LossBonusState.sended.getKey(), operator, moneyMap.keySet(), true);
		} else if (PART_OF_SUCCESS.equals(resultMap.get(STATUS))) {
			Map<String, Object> failureMap = (Map<String, Object>) resultMap.get(MESSAGE);
			this.activityUserService.updateBonusByState(siteId, date, LossBonusState.sended.getKey(), operator, failureMap.keySet(), false);
		}
		return resultMap;
	}

}
