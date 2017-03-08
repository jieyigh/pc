package com.ds.betinfo.record.consumer;

import java.util.ArrayList;
import java.util.List;

import javax.jms.Message;
import javax.jms.TextMessage;
import javax.transaction.Transactional;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;

import com.ds.bet.entity.BetInfo;
import com.ds.common.mq.queue.key.KeyConfig;
import com.ds.common.util.StringUtil;

public class SyncBetDataYesterdayConsumer implements KeyConfig, AbstractMqConsumer {

	private final Logger logger = LoggerFactory.getLogger(this.getClass());

	private final String betBetweenIdSql = "SELECT * FROM :tableName WHERE id >= ? and id <= ?";

	private final StringBuffer syncBetYesterdaySqlBuffer = new StringBuffer("INSERT INTO pc_bet_info_yesterday(bill_no, username, original_username, game_type, term, ")//
			.append("bet_type, bet_money, bet_num, bet_msg, pay_off, after_balance, state, ")//
			.append("win_money_valid, win_money1314, win_money_expected, bet_odds1314, bet_odds_expected, ")//
			.append("table_id, site_id, create_time, update_time) VALUES ");

	private JdbcTemplate jdbcTemplate;

	private Message message;

	public SyncBetDataYesterdayConsumer(JdbcTemplate jdbcTemplate, Message message) {
		this.jdbcTemplate = jdbcTemplate;
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
				// 代表结算时候注单
				logger.info("content = {}", content);
				if (!content.contains(":")) {
					throw new RuntimeException(QUEUE_BET_DATA_YESTERDAY + "格式错误,不包含分隔符:");
				}
				String[] arr = content.split(":"); // arr[0] = tableName, arr[1] = minId, arr[2] = maxId
				List<BetInfo> betInfoList = this.jdbcTemplate.query(betBetweenIdSql.replaceAll(":tableName", arr[0]), new Object[] { arr[1], arr[2] }, new BeanPropertyRowMapper<BetInfo>(BetInfo.class));
				if (betInfoList == null || betInfoList.size() <= 0) {
					logger.info("{}表不存在数据,fromId = {}, toId = {}, 查询不到数据", arr[0], arr[1], arr[2]);
				}
				StringBuffer sqlBuffer = new StringBuffer();
				List<Object> paramList = new ArrayList<>();
				BetInfo betInfo = null;
				for (int i = 0; i < betInfoList.size(); i++) {
					betInfo = betInfoList.get(i);
					sqlBuffer.append("(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
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
					paramList.add(betInfo.getUpdateTime());
					if (i != betInfoList.size() - 1) {
						sqlBuffer.append(", ");
					}
				}
				Long start = System.currentTimeMillis();
				int count = this.jdbcTemplate.update(syncBetYesterdaySqlBuffer.toString() + sqlBuffer.toString(), paramList.toArray(new Object[paramList.size()]));
				logger.info("同步到pc_bet_info_yesterday从表{},fromId={},toId={},总更新条目数={},耗时 = {}ms", arr[0], arr[1], arr[2], count, System.currentTimeMillis() - start);
			}
		} catch (Exception e) {
			logger.error("receiveBetDataYesterday 同步出错 : ", e);
			throw new RuntimeException("receiveBetDataYesterday 同步出错");
		}
	}
}
