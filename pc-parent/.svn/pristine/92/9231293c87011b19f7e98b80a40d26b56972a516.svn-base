package com.ds.limit.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ds.limit.service.BetLimitService;
import com.ds.redis.api.RedisService;
import com.ds.redis.key.KeyConfig;


@Service
public class BetLimitServiceImpl implements BetLimitService {

	@Autowired
	private RedisService redisService;
	
	@Override
	public String findByTableId(Integer tableId) {
		return redisService.get(KeyConfig.KEY_PREFIX_LIMIT + tableId);
	}

	

}
