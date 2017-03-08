package com.ds.room.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;
import javax.validation.Valid;

import org.apache.commons.lang.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import com.ds.common.controller.base.BaseController;
import com.ds.common.util.ValidateUtil;
import com.ds.room.service.SiteConfigService;
import com.ds.room.vo.RoomParams;

@RestController
@RequestMapping("/room")
public class RoomInfoController extends BaseController {

	private static final Logger logger = LoggerFactory.getLogger(RoomInfoController.class);

	@Autowired
	private SiteConfigService siteConfigService;

	@RequestMapping(value = "/getTables", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	public @ResponseBody Object getTablesByCode(@Valid RoomParams params, BindingResult bindingResult,
			HttpServletResponse resp) {
		logger.info("请求参数-> code={}",params.getCode());
		resp.setHeader("Access-Control-Allow-Origin", "*");// 允许跨域
		Map<String, Object> map = new HashMap<String, Object>();
		if (bindingResult.hasErrors()) {
			map.put(STATUS, ERROR);
			String errors = ValidateUtil.getErrors(bindingResult);
			map.put(MESSAGE, errors);
			logger.info(errors);
			return map;
		}
		try {
			String result = siteConfigService.findBySiteId(Integer.valueOf(params.getCode()));
			if (null == result) {
				map.put(STATUS, ERROR);
				map.put(MESSAGE, "data is null");
				logger.info("数据为空");
				return map;
			}
			map.put(STATUS, SUCCESS);
			map.put(MESSAGE, JSON.parse(result));
			return map;
		} catch (Exception e) {
			map.put(STATUS, ERROR);
			map.put(MESSAGE, SYSTEM_ERROR);
			logger.info(SYSTEM_ERROR);
		}
		return map;
	}
	
	@RequestMapping(value = "/get", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	public @ResponseBody Object getSitesByCode(HttpServletResponse resp, @RequestBody String params) {
		resp.setHeader("Access-Control-Allow-Origin", "*");// 允许跨域
		logger.info("请求参数-> params={}", params);
		RoomParams roomParams = JSONObject.parseObject(params, RoomParams.class);
		String valid = ValidateUtil.validateModel(roomParams);

		if (StringUtils.isNotEmpty(valid)) {
			return result(MAYBE, valid);
		}

		try {
			String result = siteConfigService.findRoomsBySiteId(Integer.valueOf(roomParams.getCode()));
			if (null == result) {
				logger.info("数据为空");
				return result(ERROR, "data is null");
			}
			return result(SUCCESS, JSON.parse(result));
		} catch (Exception e) {
			logger.info(SYSTEM_ERROR);
			return result(ERROR, SYSTEM_ERROR);
		}

	}

}
