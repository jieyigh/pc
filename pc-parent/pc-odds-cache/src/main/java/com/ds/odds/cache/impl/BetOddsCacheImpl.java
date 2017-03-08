package com.ds.odds.cache.impl;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.alibaba.fastjson.JSONObject;
import com.alibaba.fastjson.TypeReference;
import com.ds.common.util.StringUtil;
import com.ds.entity.BetOdd;
import com.ds.odds.cache.BetOddsCache;
import com.ds.redis.api.RedisService;
import com.ds.redis.key.KeyConfig;

@Service
public class BetOddsCacheImpl implements BetOddsCache, KeyConfig {

	@Autowired
	private RedisService redisService;

	// {key = parentId, {key = type, value=BetOdd}}
	@Override
	public Map<Long, Map<String, BetOdd>> getBetOddsMapByTableId(Integer tableId) {
		String json = this.redisService.get(KEY_PREFIX_ODDS + tableId);
		if (StringUtil.isNull(json)) {
			return null;
		}
		return JSONObject.parseObject(json, new TypeReference<Map<Long, Map<String, BetOdd>>>() {
		});
	}

}
