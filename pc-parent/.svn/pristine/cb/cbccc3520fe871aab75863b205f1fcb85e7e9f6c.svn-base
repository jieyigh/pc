package com.ds.odds.controller;

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
import com.ds.odds.service.BetOddService;
import com.ds.odds.vo.BetOddParams;

@RestController
@RequestMapping("/odd")
public class BetOddController extends BaseController {

	private static final Logger logger = LoggerFactory.getLogger(BetOddController.class);

	@Autowired
	private BetOddService betOddService;

	@RequestMapping(value = "/get", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	public @ResponseBody Object findByTableIdAndGameType(@RequestBody String params) {
		logger.info("请求参数->params={}", params);

		BetOddParams betOddParams = JSONObject.parseObject(params, BetOddParams.class);
		String valid = ValidateUtil.validateModel(betOddParams);
		if (StringUtils.isNotEmpty(valid)) {
			return result(MAYBE, valid);
		}

		try {
			String odds = betOddService.findByTableId(Integer.valueOf(betOddParams.getTableId()));
			if (StringUtils.isEmpty(odds)) {
				return result(ERROR, "data is null");
			}
			return result(SUCCESS, JSON.parse(odds));
		} catch (Exception e) {
			logger.info(SYSTEM_ERROR);
			return result(ERROR, SYSTEM_ERROR);
		}
	}

}
