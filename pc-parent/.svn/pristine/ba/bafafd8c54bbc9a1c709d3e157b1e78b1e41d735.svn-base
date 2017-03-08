package com.ds.room.controller;

import java.util.HashMap;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.alibaba.fastjson.JSON;
import com.ds.common.controller.base.BaseController;
import com.ds.redis.api.RedisService;
import com.ds.redis.key.KeyConfig;

@RestController
@RequestMapping("/basic")
public class BasicController extends BaseController {

	private static final Logger logger = LoggerFactory.getLogger(BasicController.class);

	@Autowired
	private RedisService redisService;

	@RequestMapping(value = "/constant", produces = "application/json;charset=UTF-8")
	public @ResponseBody Object constant() {
		Map<String, Object> map = new HashMap<String, Object>();
		try {
			map.put(STATUS, SUCCESS);
			map.put(MESSAGE, JSON.parse(redisService.get(KeyConfig.KEY_BASIC)));
			return map;
		} catch (Exception e) {
			map.put(STATUS, ERROR);
			map.put(MESSAGE, SYSTEM_ERROR);
			logger.info(SYSTEM_ERROR);
		}
		return map;
	}

}
