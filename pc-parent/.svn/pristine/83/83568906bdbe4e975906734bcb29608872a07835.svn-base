package com.ds.bet.controller;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.ds.bet.function.BetInfoService;
import com.ds.common.controller.base.BaseController;
import com.ds.common.util.StringUtil;
import com.ds.redis.api.RedisService;
import com.ds.room.service.SiteConfigService;

@RestController
public class BetInfoController extends BaseController {

	private Logger logger = LoggerFactory.getLogger(this.getClass());

	@Resource(name = "betWebService")
	private BetInfoService betInfoService;

	@Autowired
	private RedisService redisService;

	/**
	 * 下注接口
	 * 
	 * @param username
	 *            用户名
	 * @param term
	 *            期数
	 * @param tableId
	 *            桌号
	 * @betParams 自定义json串-> [{msg:xx,type:xx,money:xx,num:xx}, ...] <br>
	 *            msg:消息 <br>
	 *            type:类型<br>
	 *            money:金额<br>
	 *            num:号码<br>
	 */
	@RequestMapping(value = "/bet/{tableId}/{gameType}/{term}/{username}", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	public @ResponseBody Object bet(@PathVariable String tableId, @PathVariable String gameType, @PathVariable String term, @PathVariable String username, //
			@RequestBody String betMsg, HttpServletRequest request) {
		Map<String, Object> map = new HashMap<String, Object>();
		long start = System.currentTimeMillis();
		try {
			logger.info("gameType = {}, username = {}, term = {}, tableId = {}, betMsg = {}", gameType, username, term, tableId, betMsg);
			if (!StringUtil.isNull(betMsg)) {
				JSONArray betParams = JSONArray.parseArray(betMsg);
				// 校验注单的合法性
				Map<String, Object> resultMap = validBetInfo(betParams);
				if (!SUCCESS.equals(resultMap.get(STATUS))) {
					return resultMap;
				}
				return this.betInfoService.bet(username, Long.valueOf(term), Integer.valueOf(tableId), gameType, betParams);
			}
		} catch (Exception e) {
			logger.info("下注出错 : ", e);
			map.put(STATUS, MAYBE);
			map.put(MESSAGE, SYSTEM_ERROR);
		} finally {
			long end = System.currentTimeMillis();
			logger.info("bet 耗时 = {} ms", end - start);
		}
		return map;
	}

	/**
	 * 校验注单的合法性
	 */
	private Map<String, Object> validBetInfo(JSONArray betParams) {
		if (betParams == null) {
			return result(ERROR, "bet paramas is null!");
		}
		JSONObject betObj = null;
		String type = null;
		String money = null;
		String num = null;
		for (int i = 0; i < betParams.size(); i++) {
			betObj = betParams.getJSONObject(i);
			type = betObj.getString("type");
			money = betObj.getString("money");
			num = betObj.getString("num");
			if (StringUtil.isNull(type)) {
				return result(BET_INFO_FORMAT_ERROR, "exists type is null!");
			}
			if (!StringUtil.isNumeric(money)) {
				return result(BET_INFO_FORMAT_ERROR, "exists money is no numberic!");
			}
			if ("cao".equals(type) && !StringUtil.isNumeric(num)) {
				return result(BET_INFO_FORMAT_ERROR, "exists cao play and num is no numberic!");
			}
		}
		return result(SUCCESS, "ok");
	}

}
