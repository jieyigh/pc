package com.ds.limit.service;

import java.util.List;
import java.util.Map;

import com.ds.entity.BetLimit;
import com.ds.limit.vo.BetLimitParams;
import com.ds.limit.vo.BetLimitResult;

public interface BetLimitService {

	public List<BetLimit> findByTableIdAndParentId(Integer tableId, Long parentId);

	public List<BetLimit> findByTableId(Integer tableId);

	public List<BetLimit> findBySiteId(Integer siteId);

	public BetLimit edit(BetLimitParams params);

	public List<BetLimit> saveList(List<BetLimit> limits);

	public List<BetLimit> findAll();
	
	public Map<Integer, Map<String, BetLimitResult>> cacheBetLimitData(Integer tableId);
}
