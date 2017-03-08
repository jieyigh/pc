package com.ds.room.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ds.redis.api.RedisService;
import com.ds.redis.key.KeyConfig;
import com.ds.room.service.SiteConfigService;

@Service
public class SiteConfigServiceImpl implements SiteConfigService {

	@Autowired
	private RedisService redisService;
	
	@Override
	public String findBySiteId(Integer siteId) {
		return redisService.get(KeyConfig.KEY_TABLE + siteId);
	}

	@Override
	public String findRoomsBySiteId(Integer siteId) {
		return redisService.get(KeyConfig.KEY_ROOM + siteId);
	}
}
