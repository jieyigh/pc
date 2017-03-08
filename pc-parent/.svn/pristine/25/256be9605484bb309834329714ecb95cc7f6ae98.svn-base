package com.ds.redis.provider.limit;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.alibaba.fastjson.JSONObject;
import com.ds.entity.BetLimit;
import com.ds.limit.service.BetLimitService;
import com.ds.limit.vo.BetLimitResult;

@Service
public class BetLimitCache {

	private Logger logger = LoggerFactory.getLogger(this.getClass());
	
	@Autowired
	private BetLimitService betLimitService;

	// {key = tableId, {key = type, value = betlimit集合}}
	public Map<Integer, Map<String, BetLimitResult>> cacheBetLimitData() {
		Map<Integer, Map<String, BetLimitResult>> betLimitMap = new HashMap<>(); // 下注限额map
		List<BetLimit> allBetLimit = this.betLimitService.findAll();
		for (BetLimit betLimit : allBetLimit) {
			BetLimitResult bet = new BetLimitResult();
			BeanUtils.copyProperties(betLimit, bet);
			if (null != betLimit.getSingPlayLimit()) {
				String singPlayLimit = betLimit.getSingPlayLimit();
				Object o = JSONObject.parse(singPlayLimit);
				bet.setCao(o);
				bet.setSingPlayLimit("");
			}
			Map<String, BetLimitResult> betTypeLimitMap = betLimitMap.get(bet.getTableId());
			if (betTypeLimitMap == null) {
				betTypeLimitMap = new HashMap<>();
				betLimitMap.put(bet.getTableId(), betTypeLimitMap);
			}
			betTypeLimitMap.put(bet.getType(), bet);
		}
		return betLimitMap;
	}

}
