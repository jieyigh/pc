package com.ds.history.data.betinfo.task;

import java.util.Date;

import org.apache.commons.lang.StringUtils;
import org.apache.commons.lang.math.NumberUtils;
import org.apache.commons.lang.time.DateUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.scheduling.annotation.EnableScheduling;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import com.ds.bet.repository.BetInfoRepository;
import com.ds.common.state.MoneyState;
import com.ds.common.util.DateUtil;

/**
 * 注单同步任务
 * 
 * @author jackson
 *
 */
@Component
@EnableScheduling
public class BetInfoTask {

	private static final Logger logger = LoggerFactory.getLogger(BetInfoTask.class);

	@Autowired
	private BetInfoRepository betInfoRepository;
	
	@Value("${yesterday.num}")
	private String num;

	@Transactional
	@Scheduled(fixedDelay = 1 * 60 * 1000)
	public void yesterdayDataTask() {
		String date = DateUtil.format(DateUtil.YYMMDDHH, DateUtils.addDays(new Date(), -1));
		Integer state = MoneyState.BET.getState();

		Long yesterdayBet = betInfoRepository.countYesterdayBet(date, state);

		if (yesterdayBet > 0L) {
			// 昨天存在未派彩的数据
			logger.info(" 昨天存在未派彩的数据,最小ID：{}", yesterdayBet);
			return;
		}

		Long id = betInfoRepository.getTargetBetMaxId();

		if(StringUtils.isEmpty(num) || !NumberUtils.isNumber(num)){
			logger.info(" 请设置每次拉取条数,目前值为 yesterday.num：{}", this.num);
			return;
		}
		Integer num = Integer.valueOf(this.num);

		Integer i = betInfoRepository.copySourceBet(date, id, num, state);
		if (i == 0) {
			logger.info("源数据为空,插入数据失败");
			return;
		}
		// 获取原库最大ID
		Long maxId = betInfoRepository.getSourceBetMaxId(date, id, num, state);

		// 计算源数据库数量
		Integer count = betInfoRepository.countSourceBet(id, maxId, date, state);

		if (count.intValue() != i.intValue()) {
			throw new RuntimeException("插入的数据和原库数据对不上");
		}

		/*
		 * Integer delcount = betInfoRepository.delSourceBet(id, maxId, date,
		 * state); if (delcount != i) { throw new RuntimeException("删除原数据失败"); }
		 */
		logger.info("拷贝昨天注单数据成功,一共{}条,{}-{}", i, id, maxId);
	}

}
