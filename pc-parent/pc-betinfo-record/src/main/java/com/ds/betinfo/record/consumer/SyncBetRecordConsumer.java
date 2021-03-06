package com.ds.betinfo.record.consumer;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.jms.Message;
import javax.jms.TextMessage;
import javax.transaction.Transactional;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.dao.DataAccessException;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.ConnectionCallback;
import org.springframework.jdbc.core.JdbcTemplate;

import com.ds.bet.entity.BetInfo;
import com.ds.common.util.StringUtil;

public class SyncBetRecordConsumer implements AbstractMqConsumer {

	private final Logger logger = LoggerFactory.getLogger(this.getClass());

	private final StringBuffer syncBetRecordSqlBuffer = new StringBuffer("INSERT INTO pc_bet_info_record(")//
			.append("bill_no, username, game_type, term, bet_type, bet_money, bet_num, bet_msg, ") //
			.append("pay_off, after_balance, state, win_money_valid, win_money1314, win_money_expected, table_id, bet_info_id, bet_odds1314, bet_odds_expected, create_time, bet_time, payoff_time, site_id, original_username) ")//
			.append("VALUES ");;

	private final StringBuffer findBetInfoSqlBuffer = new StringBuffer("SELECT * FROM :tableName WHERE pay_off IS NOT NULL and term = ? LIMIT ?,?");

	private JdbcTemplate jdbcTemplate;

	private JdbcTemplate recordJdbcTemplate;

	private Message message;

	public SyncBetRecordConsumer(JdbcTemplate jdbcTemplate, JdbcTemplate recordJdbcTemplate, Message message) {
		this.jdbcTemplate = jdbcTemplate;
		this.recordJdbcTemplate = recordJdbcTemplate;
		this.message = message;
	}

	@Transactional
	@Override
	public void execute() {
		String content = null;
		try {
			if (message instanceof TextMessage) {
				content = ((TextMessage) message).getText();
				
				if (StringUtil.isNull(content)) {
					throw new RuntimeException("queue_bill_record content is null");
				}
				
				if (!StringUtil.isNull(content)) {
					throw new RuntimeException("故意抛出异常");
				}
				
				// 代表结算时候注单
				logger.info("bill record queue content = {}", content);
				if (content.contains(":")) {
					String[] arr = content.split(":"); // arr[0] = tableName, arr[1] = term, arr[2] = start, arr[3] = count
					//SELECT * FROM pc_bet_info WHERE term = ?1 LIMIT ?2,?3
					List<Object> paramList = new ArrayList<>();
					paramList.add(arr[1]);
					paramList.add(Integer.valueOf(arr[2]));
					paramList.add(Integer.valueOf(arr[3]));
					final List<BetInfo> betInfoList = this.jdbcTemplate.query(findBetInfoSqlBuffer.toString().replaceAll(":tableName", arr[0]), paramList.toArray(new Object[paramList.size()]), new BeanPropertyRowMapper<BetInfo>(BetInfo.class));
					if (betInfoList == null || betInfoList.size() <= 0) {
						throw new RuntimeException("one more time,It's impossible that data is null =====");
//						return;
					}
					this.recordJdbcTemplate.execute(new ConnectionCallback<Integer>() {
						@Override
						public Integer doInConnection(Connection con) throws SQLException, DataAccessException {
							try {
								StringBuffer sqlBuffer = new StringBuffer();
								List<Object> paramList = new ArrayList<>();
								Date now = new Date();
								BetInfo betInfo = null;
								for (int i = 0; i < betInfoList.size(); i++) {
									betInfo = betInfoList.get(i);
									sqlBuffer.append("(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?) ");
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
									paramList.add(betInfo.getBetOdds1314());
									paramList.add(betInfo.getBetOddsExpected());
									paramList.add(now);
									paramList.add(betInfo.getCreateTime());
									paramList.add(betInfo.getUpdateTime());
									paramList.add(betInfo.getSiteId());
									paramList.add(betInfo.getOriginalUsername());
									if (i != betInfoList.size() - 1) {
										sqlBuffer.append(", ");
									}
								}
								PreparedStatement prepareStatement = con.prepareStatement(syncBetRecordSqlBuffer.toString() + sqlBuffer.toString());
								for (int i = 0; i < paramList.size(); i++) {
									prepareStatement.setObject(i + 1, paramList.get(i));
								}
								int count = prepareStatement.executeUpdate();
								logger.info("insert count = {}", count);
								return count;
							} catch (Exception e) {
								logger.error("同步记录异常 : ", e);
								throw new RuntimeException("同步记录出错 : ");
							}
						}
					});
				}
			}
		} catch (Exception e) {
			logger.error("queue_bill_record is failure", e);
			throw new RuntimeException("同步记录出错 : ");
		}

	}

}
