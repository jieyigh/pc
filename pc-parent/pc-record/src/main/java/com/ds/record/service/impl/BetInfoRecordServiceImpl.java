package com.ds.record.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ds.record.entity.BetInfoRecord;
import com.ds.record.repository.BetInfoRecordRepository;
import com.ds.record.service.BetInfoRecordService;

@Service
public class BetInfoRecordServiceImpl implements BetInfoRecordService {

	@Autowired
	private BetInfoRecordRepository betInfoRecordRepository;
	
	

	@Override
	public List<BetInfoRecord> getBetInfoRecords(List<Integer> tableIds, Long id, Integer num) {
		return this.betInfoRecordRepository.getBetInfos(tableIds, id, num);
	}

	@Override
	public List<BetInfoRecord> get100BetInfoRecords(Integer tableId, Long id, Integer num) {
		return this.betInfoRecordRepository.get100BetInfos(tableId, id, num);
	}

	@Override
	public List<Integer> getTableIdsBySiteId(Integer siteId) {
		return this.betInfoRecordRepository.getTableIdsBySiteId(siteId);
	}

}
