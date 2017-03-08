package com.ds.limit.service.impl;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.EnableScheduling;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.alibaba.fastjson.JSONObject;
import com.ds.common.constants.Constants.NormalState;
import com.ds.common.util.BeanUtil;
import com.ds.entity.BetLimit;
import com.ds.limit.repository.BetLimitRepository;
import com.ds.limit.service.BetLimitService;
import com.ds.limit.vo.BetLimitParams;
import com.ds.limit.vo.BetLimitResult;

@Service
@EnableScheduling
public class BetLimitServiceImpl implements BetLimitService {

	@Autowired
	private BetLimitRepository betLimitRepository;

	@Override
	public List<BetLimit> findByTableId(Integer tableId) {
		return betLimitRepository.findByTableId(tableId);
	}

	@Override
	public List<BetLimit> findByTableIdAndParentId(Integer tableId, Long parentId) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<BetLimit> findBySiteId(Integer siteId) {
		return betLimitRepository.findBySiteId(siteId);
	}

	@Transactional
	@Override
	public BetLimit edit(BetLimitParams params) {
		if (null == params.getId()) {
			BetLimit e = new BetLimit();
			BeanUtils.copyProperties(params, e);
			e.setTableId(Integer.valueOf(params.getTableId()));
			e.setMin(Integer.valueOf(params.getMin()));
			e.setMax(Integer.valueOf(params.getMax()));
			e.setEnabled(NormalState.启用.getKey());
			e.setCreateTime(new Date());
			return this.betLimitRepository.save(e);
		}

		BetLimit e = this.betLimitRepository.findOne(params.getId());

		if (null == e) {
			return null;
		}

		BeanUtil.copyPropertiesIgnoreNull(params, e);
		if (null != params.getTableId()) {
			e.setTableId(Integer.valueOf(params.getTableId()));
		}

		if (null != params.getMin()) {
			e.setMin(Integer.valueOf(params.getMin()));
		}

		if (null != params.getMax()) {
			e.setMax(Integer.valueOf(params.getMax()));
		}

		if (null != params.getEnabled()) {
			e.setEnabled(Integer.valueOf(params.getEnabled()));
		}

		e.setUpdateTime(new Date());
		return betLimitRepository.saveAndFlush(e);

	}

	@Override
	public List<BetLimit> saveList(List<BetLimit> limits) {
		return betLimitRepository.save(limits);
	}

	@Override
	public List<BetLimit> findAll() {
		return this.betLimitRepository.findAll();
	}

	@Override
	public Map<Integer, Map<String, BetLimitResult>> cacheBetLimitData(Integer tableId) {

		Map<Integer, Map<String, BetLimitResult>> betLimitMap = new HashMap<>(); // 下注限额map
		List<BetLimit> allBetLimit = this.betLimitRepository.findByTableId(tableId);
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
