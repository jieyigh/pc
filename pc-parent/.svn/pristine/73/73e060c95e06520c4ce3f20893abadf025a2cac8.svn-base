package com.ds.lottery.result.controller;

import org.apache.commons.lang.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import com.ds.common.controller.base.BaseController;
import com.ds.common.util.ValidateUtil;
import com.ds.lottery.result.service.LotteryResultService;
import com.ds.lottery.result.vo.LotteryResultParams;

@RestController
@RequestMapping("/lottery")
public class LotteryResultController extends BaseController{

	private static final Logger logger = LoggerFactory.getLogger(LotteryResultController.class);

	@Autowired
	private LotteryResultService lotteryResultService;

	@RequestMapping(value = "/get", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	public @ResponseBody Object get(@RequestBody String params) {
		logger.info("请求参数->params={}",params);
		
		LotteryResultParams lotteryParams = JSONObject.parseObject(params, LotteryResultParams.class);
		
		String valid = ValidateUtil.validateModel(lotteryParams);

		if (StringUtils.isNotEmpty(valid)) {
			return result(MAYBE, valid);
		}
		

		try {
			String results = lotteryResultService.getLotterys(lotteryParams.getGameType());
			
			if (StringUtils.isEmpty(results)) {
				logger.info("数据为空");
				return result(ERROR, "data is null");
			}
			return result(SUCCESS, JSON.parse(results));
		} catch (Exception e) {
			logger.info(SYSTEM_ERROR);
			return result(ERROR, SYSTEM_ERROR);
		}
	}

}
