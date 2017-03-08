package com.ds.bet.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ds.bet.repository.BetInfoRepository;
import com.ds.bet.service.BetInfoYesterdayService;

/**
 * 反水表业务
 * 
 * @author jackson
 *
 */
@Service
public class BetInfoYesterdayServiceImpl implements BetInfoYesterdayService {

	@Autowired
	private BetInfoRepository betInfoRepository;

	@Override
	public Long queryCountLossToday(String now) {
		return this.betInfoRepository.queryCountLossToday(now);
	}

}
