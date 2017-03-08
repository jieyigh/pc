package com.ds.bet.service.impl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.ConnectionCallback;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Service;

import com.alibaba.fastjson.JSONArray;
import com.ds.bet.entity.BetInfo;
import com.ds.bet.loss.vo.LossBonusVo;
import com.ds.bet.service.BetInfoService;
import com.ds.bet.vo.WinMoneyVo;
import com.ds.common.bet.BetType;
import com.ds.common.bet.KeyConfig;
import com.ds.common.constants.Constants;
import com.ds.common.state.MoneyState;

@Service
public class BetInfoServiceImpl implements BetInfoService, KeyConfig {

	private final StringBuilder findWinSql = new StringBuilder("SELECT table_id tableId, username username,original_username originalUsername, SUM(pay_off) winMoney ")//
			.append("FROM :tableName ")// 表名
			.append("WHERE game_type = ? AND term = ? AND state = ? ")//游戏类型, 期数和状态
			.append(":betNumCondition ")//下注号码只针对cao表
			.append("GROUP BY table_id, username");

	//	private final StringBuilder betInfoField = new StringBuilder()//
	//			.append("bill_no, username, game_type, term, bet_type, bet_money, bet_num, bet_msg, pay_off, after_balance, state, ")//
	//			.append("win_money_valid, win_money1314, win_money_expected, table_id, create_time, update_time, ")//
	//			.append("bet_odds1314, bet_odds_expected, site_id, original_username ");

	@Autowired
	private JdbcTemplate jdbcTemplate;

	@Transactional
	@Override
	public int insertBatch(List<BetInfo> betInfoList) {
		if (betInfoList == null || betInfoList.size() <= 0) {
			return 0;
		}
		final StringBuffer sqlBuffer = new StringBuffer();
		sqlBuffer.append("INSERT INTO pc_bet_info_record(") //
				.append("bill_no, username, game_type, term, bet_type, bet_money, bet_num, bet_msg, pay_off, after_balance, ")//
				.append("state, win_money_valid, win_money1314, win_money_expected, table_id, bet_info_id, create_time) ")//
				.append("VALUES ");
		final List<Object> paramList = new ArrayList<>();
		BetInfo betInfo = null;
		for (int i = 0; i < betInfoList.size(); i++) {
			betInfo = betInfoList.get(i);
			sqlBuffer.append("(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
			paramList.add(betInfo.getBillNo());
			paramList.add(betInfo.getUsername());
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
			paramList.add(betInfo.getTableId());
			paramList.add(betInfo.getId());
			paramList.add(betInfo.getCreateTime());
			if (i != betInfoList.size() - 1) {
				sqlBuffer.append(",");
			}
		}
		return this.jdbcTemplate.execute(new ConnectionCallback<Integer>() {
			@Override
			public Integer doInConnection(Connection con) throws SQLException, DataAccessException {
				PreparedStatement ps = con.prepareStatement(sqlBuffer.toString());
				for (int i = 0; i < paramList.size(); i++) {
					ps.setObject(i, paramList.get(i));
				}
				return ps.executeUpdate();
			}
		});
	}

	@Override
	public List<Integer> todoLossBonusSiteIdList(String yesterdayStr, List<Integer> lossBonusSiteIdList, Integer num) {
		List<Object> paramList = new ArrayList<>();
		StringBuilder sqlBuffer = new StringBuilder();
		sqlBuffer.append("SELECT DISTINCT(site_id) siteId FROM pc_bet_info_yesterday ")//
				.append("WHERE DATE_FORMAT(create_time, '%Y-%m-%d') = ? ");
		paramList.add(yesterdayStr);
		if (lossBonusSiteIdList != null && lossBonusSiteIdList.size() > 0) {
			sqlBuffer.append("AND site_id NOT IN (");
			for (int i = 0; i < lossBonusSiteIdList.size(); i++) {
				sqlBuffer.append("?").append((i == lossBonusSiteIdList.size() - 1) ? ") " : ",");
				paramList.add(lossBonusSiteIdList.get(i));
			}
		}
		sqlBuffer.append("LIMIT ? ");
		paramList.add(num);
		return this.jdbcTemplate.queryForList(sqlBuffer.toString(), paramList.toArray(new Object[paramList.size()]), Integer.class);
	}

	@Override
	public List<LossBonusVo> totalLossBonusInfosBySiteId(Integer siteId, String yesterdayStr) {
		List<Object> paramList = new ArrayList<>();
		StringBuilder sqlBuffer = new StringBuilder();
		sqlBuffer.append("SELECT site_id siteId, username, original_username originalUsername, IFNULL(SUM(bet_money),0) totalBetMoney, IFNULL(SUM(pay_off),0) totalPayOff, COUNT(1) betCount ")//
				.append("FROM pc_bet_info_yesterday WHERE 1=1 ");
		if (siteId == null) {
			return null;
		}
		sqlBuffer.append("AND site_id = ? ").append("AND DATE_FORMAT(create_time,'%Y-%m-%d') = ? ");
		paramList.add(siteId);
		paramList.add(yesterdayStr);
		sqlBuffer.append("GROUP BY site_id, username ");
		return this.jdbcTemplate.query(sqlBuffer.toString(), paramList.toArray(new Object[paramList.size()]), new BeanPropertyRowMapper<LossBonusVo>(LossBonusVo.class));
	}

	@Override
	public List<WinMoneyVo> findWinByTerm(JSONArray winPlays, String gameType, Long term, Integer luckyNum) {
		List<Object> paramList = null;
		List<WinMoneyVo> allWins = new ArrayList<>();
		String betNumCondition = null;
		for (int i = 0; i < winPlays.size(); i++) {
			paramList = new ArrayList<>();
			paramList.add(gameType);
			paramList.add(term);
			paramList.add(MoneyState.PAY_OFF_WIN.getState());
			if (BetType.CAO.getType().equals(winPlays.getString(i))) { // 单点玩法
				betNumCondition = "AND bet_num = ? ";
				paramList.add(luckyNum);
			} else { //!单点玩法
				betNumCondition = "";
			}
			List<WinMoneyVo> playWin = this.jdbcTemplate.query(findWinSql.toString().replaceAll(":betNumCondition", betNumCondition).replaceAll(":tableName", PREFIX_BET_TABLE + gameType + Constants.TABLE_CONCAT + winPlays.getString(i)), paramList.toArray(new Object[paramList.size()]), new BeanPropertyRowMapper<WinMoneyVo>(WinMoneyVo.class));
			allWins.addAll(playWin);
		}
		return allWins;
	}

}
