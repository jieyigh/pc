package com.ds.lottery.result.service.impl;

import java.util.Date;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.time.DateUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.ds.bet.repository.BetBillRepository;
import com.ds.common.constants.StatusCode;
import com.ds.common.state.MoneyState;
import com.ds.common.util.DateUtil;
import com.ds.common.util.JSONUtils;
import com.ds.common.util.LottoUtil;
import com.ds.entity.LotteryResult;
import com.ds.lottery.result.repository.LotteryResultRepository;
import com.ds.lottery.result.service.LotteryResultService;
import com.ds.lottery.result.vo.LotteryResultParams;
import com.ds.redis.api.RedisService;
import com.ds.redis.key.KeyConfig;

@Service
public class LotteryResultServiceImpl implements LotteryResultService, StatusCode {

	private final Logger logger = LoggerFactory.getLogger(this.getClass());

	@Autowired
	private LotteryResultRepository lotteryResultRepository;
	
	@Autowired
	private BetBillRepository betBillRepository;
	
	@Autowired
	private RedisService redisService;
	

	@Override
	public List<LotteryResult> findLastest10ByGameType(String gameType) {
		return this.lotteryResultRepository.findLastest10ByGameType(gameType);
	}

	@Transactional
	@Override
	public void edit(LotteryResultParams params, LotteryResult entity, Map<String, Object> map,Integer timeZone) {

		String gameType = params.getGameType();
		String term = params.getTerm();
		String originalNum = params.getOriginalNum();

		Long count = this.betBillRepository.isPayoff(gameType, Long.valueOf(term), MoneyState.BET.getState());
		if (count == null || count < 1) {
			logger.info("{},{}期没有下注数据", gameType,term);
			map.put(STATUS, MAYBE);
			map.put(MESSAGE, "bet data is not exist");
			return;
		}
		
		
		LotteryResult lastest = lotteryResultRepository.findFirstOneByGameType(gameType, new Date());
		if (lastest == null) {
			logger.info("获取{}参考开奖数据为空", gameType);
			map.put(STATUS, MAYBE);
			map.put(MESSAGE, "reference data is empty");
			return;
		}

		String webAddress = "人工开奖";
		Date closeTime = DateUtil.parse(DateUtil.YY_MM_DD_HH_MM_SS, 
				LottoUtil.getCloseDate(Long.valueOf(term), lastest.getTerm() + "", DateUtil.format(DateUtil.YY_MM_DD_HH_MM_SS, lastest.getOpenTime()), Float.valueOf(LottoUtil.getMins(gameType, timeZone))));

		Date openTime = DateUtils.addSeconds(closeTime, 30);

		/*Date dateB = DateUtils.addMinutes(new Date(), gameType.equals(GameType.幸运二八.getKey()) ? -10 : -7);
		if (openTime.getTime() < dateB.getTime() || openTime.getTime() > System.currentTimeMillis()) {
			logger.info("{},{}开奖数据开奖时间{}错误", gameType, term, openTime);
			map.put(STATUS, MAYBE);
			map.put(MESSAGE, "term is error");
			return;
		}*/

		LotteryResult lotteryResult = lotteryResultRepository.findByGameTypeAndTerm(gameType, Long.valueOf(term));
		if (null != lotteryResult) {
			logger.info("{}期的开奖数据已经存在", term);
			map.put(STATUS, MAYBE);
			map.put(MESSAGE, "data is exist");
			return;
		}

		entity.setGameType(gameType);
		entity.setTerm(Long.valueOf(term));
		entity.setCloseTime(closeTime);
		entity.setOpenTime(openTime);
		entity.setOriginalNum(originalNum);
		entity.setOpenUrl(webAddress);
		entity.setLuckyNum(LottoUtil.getNumberSum(originalNum));
		entity.setCreateTime(new Date());

		lotteryResultRepository.save(entity);
		
		redisService.set(KeyConfig.KEY_LOTTERY + gameType, JSONUtils.bean2Json(lotteryResultRepository.findLastest10ByGameType(gameType)));

	}
		

	@Override
	public LotteryResult findFirstOneByGameType(String gameType,Date now) {
		return lotteryResultRepository.findFirstOneByGameType(gameType,new Date());
	}

	@Override
	public LotteryResult findByGameTypeAndTerm(String gameType, Long term) {
		return this.lotteryResultRepository.findByGameTypeAndTerm(gameType, term);
	}

	@Transactional
	@Override
	public void editWithTime(LotteryResultParams params, LotteryResult entity, Map<String, Object> map) {
		String gameType = params.getGameType();
		String term = params.getTerm();
		String originalNum = params.getOriginalNum();	
		String openTimeP = params.getOpenTime();
		

		String webAddress = "人工开奖(特殊)";
		Date openTime = DateUtil.parse(DateUtil.YY_MM_DD_HH_MM_SS,openTimeP);
		
		if (null == openTime) {
			logger.info("{}日期格式错误", openTimeP);
			map.put(STATUS, MAYBE);
			map.put(MESSAGE, "openTime format is error");
			return;
		}

		Date closeTime = DateUtils.addSeconds(openTime, -30);		

		LotteryResult lotteryResult = lotteryResultRepository.findByGameTypeAndTerm(gameType, Long.valueOf(term));
		if (null != lotteryResult) {
			logger.info("{}期的开奖数据已经存在", term);
			map.put(STATUS, MAYBE);
			map.put(MESSAGE, "data is exist");
			return;
		}

		entity.setGameType(gameType);
		entity.setTerm(Long.valueOf(term));
		entity.setCloseTime(closeTime);
		entity.setOpenTime(openTime);
		entity.setOriginalNum(originalNum);
		entity.setOpenUrl(webAddress);
		entity.setLuckyNum(LottoUtil.getNumberSum(originalNum));
		entity.setCreateTime(new Date());

		lotteryResultRepository.save(entity);
		
		redisService.set(KeyConfig.KEY_LOTTERY + gameType, JSONUtils.bean2Json(lotteryResultRepository.findLastest10ByGameType(gameType)));

	
		
		
	}

}
