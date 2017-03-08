package com.ds.redis.provider.odds;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ds.entity.BetOdd;
import com.ds.odds.service.BetOddService;

@Service
public class BetOddsCache {

	@Autowired
	private BetOddService betOddService;

	public Map<Integer, Map<Long, Map<String, BetOdd>>> cacheBetOddsData() {
		// {key = tableId, {key = parentId, {key = type, value = betOdd}}}
		Map<Integer, Map<Long, Map<String, BetOdd>>> tableIdBetOddsMap = new HashMap<>();
		List<BetOdd> allBetOdds = this.betOddService.findAll();
		for (BetOdd betOdd : allBetOdds) {
			Map<Long, Map<String, BetOdd>> parentIdBetOddMap = tableIdBetOddsMap.get(betOdd.getTableId());
			if (parentIdBetOddMap == null) {
				parentIdBetOddMap = new HashMap<>();
				tableIdBetOddsMap.put(betOdd.getTableId(), parentIdBetOddMap);
			}
			Map<String, BetOdd> betOddTypeMap = parentIdBetOddMap.get(betOdd.getParentId());
			if (betOddTypeMap == null) {
				betOddTypeMap = new HashMap<>();
				parentIdBetOddMap.put(betOdd.getParentId(), betOddTypeMap);
			}
			betOddTypeMap.put(betOdd.getType(), betOdd);
		}
		return tableIdBetOddsMap;
	}

	public List<BetOdd> findByParentIdIsNull() {
		return this.betOddService.findByParentIdIsNull();
	}

}
