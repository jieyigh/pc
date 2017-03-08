package com.ds.lottery.result.service;

import java.util.Date;
import java.util.List;
import java.util.Map;

import com.ds.entity.LotteryResult;
import com.ds.lottery.result.vo.LotteryResultParams;

public interface LotteryResultService {

	public List<LotteryResult> findLastest10ByGameType(String gameType);
	
	public void edit(LotteryResultParams params,LotteryResult result,Map<String, Object> map,Integer timeZone);
	
	public void editWithTime(LotteryResultParams params,LotteryResult result,Map<String, Object> map);

	public LotteryResult findFirstOneByGameType(String gameType,Date now);
	
	public LotteryResult findByGameTypeAndTerm(String gameType, Long term);

}
