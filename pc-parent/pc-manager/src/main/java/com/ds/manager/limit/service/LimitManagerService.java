package com.ds.manager.limit.service;

import java.util.Map;
import java.util.Set;
import java.util.Map.Entry;

import javax.annotation.Resource;
import javax.jms.Queue;
import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ds.common.mq.queue.key.KeyConfig;
import com.ds.common.util.JSONUtils;
import com.ds.entity.BetLimit;
import com.ds.limit.service.BetLimitService;
import com.ds.limit.vo.BetLimitParams;
import com.ds.limit.vo.BetLimitResult;
import com.ds.mq.provider.p2p.MQProviderService;
import com.ds.redis.api.RedisService;

@Service
public class LimitManagerService implements KeyConfig,com.ds.redis.key.KeyConfig {

	@Autowired
	private BetLimitService betLimitService;

	@Resource(name = QUEUE_BET_LIMIT)
	private Queue queueBetLimit;

	@Autowired
	private MQProviderService mqService;
	
	@Autowired
	private RedisService redisService;

	@Transactional
	public BetLimit edit(BetLimitParams betLimitParams) throws Exception {
		BetLimit edit = this.betLimitService.edit(betLimitParams);
//		this.mqService.send(queueBetLimit, JSONUtils.bean2Json(edit));
		
		//实时刷新redis
		//限额
		
		if(null != betLimitParams.getTableId()){
			Map<Integer, Map<String, BetLimitResult>> betLimitMap = this.betLimitService.cacheBetLimitData(Integer.valueOf(betLimitParams.getTableId()));
			Set<Entry<Integer, Map<String, BetLimitResult>>> limitEntrySet = betLimitMap.entrySet();
			for (Entry<Integer, Map<String, BetLimitResult>> entry : limitEntrySet) {
				this.redisService.set(KEY_PREFIX_LIMIT + entry.getKey(), JSONUtils.map2Json(entry.getValue()));
			}
		}
		
		
		return edit;
	}

}
