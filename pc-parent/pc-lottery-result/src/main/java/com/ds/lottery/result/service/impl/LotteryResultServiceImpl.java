package com.ds.lottery.result.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ds.lottery.result.service.LotteryResultService;
import com.ds.redis.api.RedisService;
import com.ds.redis.key.KeyConfig;

@Service
public class LotteryResultServiceImpl implements LotteryResultService{

	@Autowired
	private RedisService redisService;

	public String getLotterys(String gameType) {
		return redisService.get(KeyConfig.KEY_LOTTERY + gameType);
	}

}
