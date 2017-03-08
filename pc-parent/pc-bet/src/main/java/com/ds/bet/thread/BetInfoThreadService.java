package com.ds.bet.thread;

import java.util.ArrayList;
import java.util.List;
import java.util.Map.Entry;
import java.util.concurrent.Callable;
import java.util.concurrent.CountDownLatch;

import javax.transaction.Transactional;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.jdbc.core.JdbcTemplate;

import com.ds.bet.entity.BetInfo;
import com.ds.common.bet.KeyConfig;

/**
 * 下注线程业务
 * 
 * @author jackson
 *
 */
public class BetInfoThreadService implements Callable<Integer>, KeyConfig {

	private final Logger logger = LoggerFactory.getLogger(this.getClass());

	private final StringBuffer betSqlBuffer = new StringBuffer("INSERT INTO :tableName(")//
			.append("bill_no, username, original_username, game_type, term, bet_type, bet_money, bet_num, bet_msg, ")//
			.append("pay_off, after_balance, state, win_money_valid, win_money1314, win_money_expected, ")//
			.append("bet_odds1314, bet_odds_expected, table_id, site_id, create_time) VALUES ");

	private String playType;

	private List<BetInfo> betInfoList;

	private JdbcTemplate jdbcTemplate;

	private CountDownLatch latch;

	public BetInfoThreadService(String playType, List<BetInfo> betInfoList, JdbcTemplate jdbcTemplate, CountDownLatch latch) {
		this.playType = playType;
		this.betInfoList = betInfoList;
		this.jdbcTemplate = jdbcTemplate;
		this.latch = latch;
	}

	@Transactional
	@Override
	public Integer call() throws Exception {
		long start = System.currentTimeMillis();
		try {
			StringBuilder sqlBuffer = new StringBuilder(betSqlBuffer.toString());
			if (betInfoList == null || betInfoList.size() <= 0) {
				logger.info("玩法 = {}生成,但是不存在注单", playType);
			}
			List<Object> paramList = new ArrayList<>();
			for (int i = 0; i < betInfoList.size(); i++) {
				sqlBuffer.append("(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
				BetInfo betInfo = betInfoList.get(i);
				paramList.add(betInfo.getBillNo());
				paramList.add(betInfo.getUsername());
				paramList.add(betInfo.getOriginalUsername());
				paramList.add(betInfo.getGameType());
				paramList.add(betInfo.getTerm());
				paramList.add(betInfo.getBetType());
				paramList.add(betInfo.getBetMoney());
				paramList.add(betInfo.getBetNum());
				paramList.add(betInfo.getBetMsg());
				paramList.add(betInfo.getPayOff());
				paramList.add(betInfo.getAfterBalance());
				paramList.add(betInfo.getState());
				paramList.add(betInfo.getWinMoneyValid());
				paramList.add(betInfo.getWinMoney1314());
				paramList.add(betInfo.getWinMoneyExpected());
				paramList.add(betInfo.getBetOdds1314());
				paramList.add(betInfo.getBetOddsExpected());
				paramList.add(betInfo.getTableId());
				paramList.add(betInfo.getSiteId());
				paramList.add(betInfo.getCreateTime());
				if (i != betInfoList.size() - 1) {
					sqlBuffer.append(", ");
				}
			}
			return this.jdbcTemplate.update(sqlBuffer.toString().replaceAll(":tableName", PREFIX_BET_TABLE + playType), paramList.toArray(new Object[paramList.size()]));
		} finally {
			long end = System.currentTimeMillis();
			logger.info("单表 = {}, 耗时 = {}ms", PREFIX_BET_TABLE + playType, end - start);
			latch.countDown();
		}
	}

}
