package com.ds.manager.lottery.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.alibaba.fastjson.JSONObject;
import com.ds.common.constants.StatusCode;
import com.ds.common.controller.base.BaseController;
import com.ds.common.util.EncUtil;
import com.ds.common.util.StringUtil;
import com.ds.common.util.ValidateUtil;
import com.ds.entity.LotteryResult;
import com.ds.lottery.result.service.LotteryResultService;
import com.ds.lottery.result.vo.LotteryResultParams;
import com.ds.lottery.result.vo.LotteryResultParams.LotteryResultParamsAdd;

import io.swagger.annotations.ApiImplicitParam;
import io.swagger.annotations.ApiImplicitParams;
import io.swagger.annotations.ApiOperation;

@RestController
@RequestMapping("/lottery")
public class LotteryResultController extends BaseController {

	private static final Logger logger = LoggerFactory.getLogger(LotteryResultController.class);

	@Autowired
	private LotteryResultService lotteryResultService;
	
	@Value("${time.zone}")
	private Integer timeZone;

	@ApiOperation(value = "人工开奖")
	@ApiImplicitParams({ //
		@ApiImplicitParam(name = "timestamp", value = "时间戳", dataType = "long", required = true, paramType = "header"), //
		@ApiImplicitParam(name = "encrypt", value = "encrypt", dataType = "string", required = true, paramType = "header")//
	})
	@RequestMapping(value = "/edit", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	public @ResponseBody Object edit(HttpServletRequest request, HttpServletResponse response,
			@RequestBody String params) {
		try {

			String timestamp = request.getHeader("timestamp");
			String encrypt = request.getHeader("encrypt");
			if (StringUtil.isNull(timestamp) || StringUtil.isNull(encrypt)) {
				md5Process(request, response, timestamp, encrypt, MD5_IS_ERROR, "md5 param is null");
				return false;
			}

			if (!encrypt.equalsIgnoreCase(EncUtil.toMD5(timestamp + StatusCode.DT_MD5_KEY))) {
				logger.info("明文 = {}", (timestamp + StatusCode.DT_MD5_KEY));
				md5Process(request, response, timestamp, encrypt, MD5_IS_ERROR, "md5 is error");
				return false;
			}

			logger.info("add : params = {}", params);
			LotteryResultParams lotteryResultParams = JSONObject.parseObject(params, LotteryResultParams.class);

			if (null == lotteryResultParams) {
				return result(MAYBE, "param format is error");
			}

			String valid = ValidateUtil.validateModel(lotteryResultParams, LotteryResultParamsAdd.class);

			if (StringUtils.isNotEmpty(valid)) {
				return result(MAYBE, valid);
			}

			LotteryResult result = new LotteryResult();
			Map<String, Object> map = new HashMap<>();
			
			String openTime = lotteryResultParams.getOpenTime();
			
			if(StringUtils.isEmpty(openTime)){
				lotteryResultService.edit(lotteryResultParams, result, map , timeZone);
			}else{
				lotteryResultService.editWithTime(lotteryResultParams, result, map);
			}
					
			

			if (null != map && !map.isEmpty()) {
				return map;
			}
			return result(SUCCESS, result);
		} catch (Exception e) {
			logger.error("系统错误 add : ", e);
			return result(MAYBE, "system error maybe cause param format is error");
		}
	}

}
