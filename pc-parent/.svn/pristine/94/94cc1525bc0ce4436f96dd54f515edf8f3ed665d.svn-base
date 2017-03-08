package com.ds.bet.service;

import java.util.List;

import com.alibaba.fastjson.JSONArray;
import com.ds.bet.entity.BetInfo;
import com.ds.bet.loss.vo.LossBonusVo;
import com.ds.bet.vo.WinMoneyVo;

public interface BetInfoService {

	int insertBatch(List<BetInfo> betInfoList);

	/** 查询待反水的网站 */
	List<Integer> todoLossBonusSiteIdList(String yesterdayStr, List<Integer> lossBonusSiteIdList, Integer num);

	/** 根据siteId统计亏损信息 */
	List<LossBonusVo> totalLossBonusInfosBySiteId(Integer siteId, String yesterdayStr);

	/** 统计赢得 */
	List<WinMoneyVo> findWinByTerm(JSONArray winPlays, String gameType, Long term, Integer luckyNum);

}
