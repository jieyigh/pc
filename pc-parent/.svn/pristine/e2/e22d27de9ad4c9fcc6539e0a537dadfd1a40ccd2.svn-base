package com.ds.limit.controller;

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
import com.ds.limit.service.BetLimitService;
import com.ds.limit.vo.BetLimitParams;

@RestController
@RequestMapping("/limit")
public class BetLimitController extends BaseController{

	private static final Logger logger = LoggerFactory.getLogger(BetLimitController.class);

	@Autowired
	private BetLimitService betLimitService;

	@RequestMapping(value = "/get", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	public @ResponseBody Object findByTableId(@RequestBody String params) {
		logger.info("请求参数->params={}",params);
		
		BetLimitParams betLimitParams = JSONObject.parseObject(params, BetLimitParams.class);
		String valid = ValidateUtil.validateModel(betLimitParams);

		if (StringUtils.isNotEmpty(valid)) {
			return result(MAYBE, valid);
		}
		
		try {
			Integer tableId = Integer.valueOf(betLimitParams.getTableId());
			String limits = betLimitService.findByTableId(tableId);
			if (StringUtils.isEmpty(limits)) {
				logger.info("数据为空");
				return result(ERROR, "data is null");
			}
			return result(SUCCESS, JSON.parse(limits));
		} catch (Exception e) {
			logger.info(SYSTEM_ERROR);
			return result(ERROR, SYSTEM_ERROR);
		}
	}

}
