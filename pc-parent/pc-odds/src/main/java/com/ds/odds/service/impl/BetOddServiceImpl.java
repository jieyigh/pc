package com.ds.odds.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ds.odds.service.BetOddService;
import com.ds.redis.api.RedisService;
import com.ds.redis.key.KeyConfig;


@Service
public class BetOddServiceImpl implements BetOddService {
	
	@Autowired
	private RedisService redisService;

	@Override
	public String findByTableId(Integer tableId) {
		return redisService.get(KeyConfig.KEY_PREFIX_ODDS + tableId);
	}

	

}
