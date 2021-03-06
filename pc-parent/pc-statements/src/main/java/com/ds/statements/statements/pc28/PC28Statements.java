package com.ds.statements.statements.pc28;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.jms.Queue;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.jdbc.core.JdbcTemplate;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.ds.bet.service.BetBillService;
import com.ds.bet.vo.TodoOpenVo;
import com.ds.common.bet.BetType;
import com.ds.common.constants.Constants;
import com.ds.common.state.MoneyState;
import com.ds.common.util.JSONUtils;
import com.ds.common.util.LottoUtil;
import com.ds.entity.LotteryResult;
import com.ds.mq.provider.p2p.MQProviderService;
import com.ds.redis.api.RedisService;
import com.ds.redis.key.KeyConfig;
import com.ds.statements.statements.AbstractStatements;

/**
 * 28类结算
 * 
 * @author jackson
 *
 */
public class PC28Statements extends AbstractStatements implements KeyConfig, com.ds.common.bet.KeyConfig {

	private Logger logger = LoggerFactory.getLogger(this.getClass());

	private final int offset = 20000; // 每次处理容量

	private final StringBuffer statementExceptedBuffer = new StringBuffer("UPDATE :tableName SET state = 2, update_time = ?, pay_off = win_money_expected WHERE term = ? AND state = 1 AND game_type = ? ");
	private final StringBuffer statement1314Buffer =     new StringBuffer("UPDATE :tableName SET state = 2, update_time = ?, pay_off = win_money1314 WHERE term = ? AND state = 1 AND game_type = ? ");
	private final StringBuffer statementLossBuffer =     new StringBuffer("UPDATE :tableName SET state = 3, update_time = ?, pay_off = 0 WHERE term = ? AND state = 1 AND game_type = ? ");
	private final StringBuffer statementWinCaoBuffer =   new StringBuffer("UPDATE :tableName SET state = 2, update_time = ?, pay_off = win_money_expected WHERE term = ? AND state = 1 AND bet_num = ? AND game_type = ?  ");

	private Date now;
	private TodoOpenVo todoOpen;
	private LotteryResult lotteryResult;

	private Queue queueBillRecord;
	private Queue queueTransfer;

	private MQProviderService mqService;
	private RedisService redisService;
	private JdbcTemplate jdbcTemplate;
	private BetBillService betBillService;

	public PC28Statements(Date now, TodoOpenVo todoOpen, LotteryResult lotteryResult, //
			Queue queueBillRecord, Queue queueTransfer, //
			MQProviderService mqService, RedisService redisService, //
			JdbcTemplate jdbcTemplate, BetBillService betBillService) {
		this.now = now;
		this.todoOpen = todoOpen;
		this.lotteryResult = lotteryResult;
		this.queueBillRecord = queueBillRecord;
		this.queueTransfer = queueTransfer;
		this.mqService = mqService;
		this.redisService = redisService;
		this.jdbcTemplate = jdbcTemplate;
		this.betBillService = betBillService;
	}

	@Override
	public void statements() throws Exception {
		List<String> winPlays = new ArrayList<>(); // 赢得玩法
		logger.info("正在开奖 : 游戏类型 = {}, 开奖期数 = {}", todoOpen.getGameType(), todoOpen.getTerm());
		// 获取赢得玩法
		this.getWinPlays(lotteryResult, winPlays);
		// get该彩种的所有玩法--对应的表
		JSONArray playArr = JSONArray.parseArray(this.redisService.get(KEY_PLAY + lotteryResult.getGameType()));
		String tableName = null;
		String playType = null;
		String sql = null;
		List<Object> paramList = null;
		// 结算每张玩法表
		for (int i = 0; i < playArr.size(); i++) {
			int caoWin = 0;
			paramList = new ArrayList<>();
			JSONObject jsonObject = playArr.getJSONObject(i);
			playType = jsonObject.getString("type");
			tableName = PREFIX_BET_TABLE + lotteryResult.getGameType() + Constants.TABLE_CONCAT + playType;
			if (winPlays.contains(playType)) { // 赢
				if (BetType.CAO.getType().equals(playType)) { // 单点玩法
					caoWin = this.jdbcTemplate.update(statementWinCaoBuffer.toString().replaceAll(":tableName", tableName), new Object[] { now, lotteryResult.getTerm(), lotteryResult.getLuckyNum(), lotteryResult.getGameType() });
					sql = statementLossBuffer.toString();//将尾数为cao的表执为派彩输
				} else { // 其他玩法
					if (13 == lotteryResult.getLuckyNum().intValue() || 14 == lotteryResult.getLuckyNum().intValue()) { // 13|14幸运号码
						sql = statement1314Buffer.toString();
					} else { // !13|14幸运号码
						sql = statementExceptedBuffer.toString();
					}
				}
			} else {
				sql = statementLossBuffer.toString();
			}
			sql = sql.replaceAll(":tableName", tableName);
			paramList.add(now);
			paramList.add(todoOpen.getTerm());
			paramList.add(lotteryResult.getGameType());
			// 同步数据
			int total = this.jdbcTemplate.update(sql, paramList.toArray(new Object[paramList.size()]));
			total += caoWin;
			int j = 0;
			while (total > 0) {
				int process = total > offset ? offset : total;
				this.mqService.send(queueBillRecord, tableName + ":" + todoOpen.getTerm() + ":" + (j * offset) + ":" + process);
				total -= process;
				j++;
				Thread.sleep(100);
			}
		}
		// 更新bill
		// 派彩数据同步
		//				this.betInfoService.syncWinData(term);
		// 同步数据完成,发送队列
		Map<String, Object> queueMsg = new HashMap<>();
		queueMsg.put("winPlays", winPlays);
		queueMsg.put("term", todoOpen.getTerm());
		queueMsg.put("num", lotteryResult.getLuckyNum());
		queueMsg.put("gameType", lotteryResult.getGameType());
		this.mqService.send(queueTransfer, JSONUtils.map2Json(queueMsg));
		this.betBillService.updateStateByTerm(lotteryResult.getGameType(), todoOpen.getTerm(), MoneyState.PAY_OFF_WIN.getState());
	}

	/**
	 * 派彩各个玩法
	 */
	private void getWinPlays(LotteryResult lotteryResult, List<String> winPlays) {
		/** 红绿蓝波玩法 */
		colorPlay(lotteryResult, winPlays);
		/** 特殊玩法 */
		specialPlay(lotteryResult.getOriginalNum(), winPlays);
		/** 简单玩法 */
		dxdsPlay(lotteryResult, winPlays);
		/** 极大极小玩法 */
		jdjxPlay(lotteryResult, winPlays);
		/** 组合玩法 */
		compusePlay(lotteryResult, winPlays);
		/** 单点玩法 */
		winPlays.add(BetType.CAO.getType());
		//		singPlay(lotteryResult, winPlays);
	}

	/**
	 * 红波|绿波|蓝波 玩法
	 */
	private void colorPlay(LotteryResult lotteryResult, List<String> winPlays) {
		if (LottoUtil.isRed(lotteryResult.getLuckyNum())) {
			winPlays.add(BetType.RED.getType());
		}
		if (LottoUtil.isBlue(lotteryResult.getLuckyNum())) {
			winPlays.add(BetType.BLUE.getType());
		}
		if (LottoUtil.isGreen(lotteryResult.getLuckyNum())) {
			winPlays.add(BetType.GREEN.getType());
		}
	}

	/**
	 * 顺子|豹子
	 */
	private void specialPlay(String originalNum, List<String> winPlays) {
		if (LottoUtil.isStraight(originalNum)) {
			winPlays.add(BetType.STRAIGHT.getType());
		}
		if (LottoUtil.isLeopard(originalNum)) {
			winPlays.add(BetType.LEOPARD.getType());
		}
		if (LottoUtil.isPair(originalNum)) {
			winPlays.add(BetType.PAIR.getType());
		}
	}

	/**
	 * 大小单双|1314大小单双
	 */
	private void dxdsPlay(LotteryResult lotteryResult, List<String> winPlays) {
		int luckyNumber = lotteryResult.getLuckyNum();
		if (luckyNumber >= 14 && luckyNumber <= 27) {
			winPlays.add(BetType.BIG.getType());
		}
		if (luckyNumber >= 0 && luckyNumber <= 13) {
			winPlays.add(BetType.SMALL.getType());
		}
		if (luckyNumber % 2 == 0) {
			winPlays.add(BetType.EVEN.getType());
		} else {
			winPlays.add(BetType.ODD.getType());
		}
	}

	/**
	 * 极大极小玩法
	 */
	private void jdjxPlay(LotteryResult lotteryResult, List<String> winPlays) {
		int luckyNumber = lotteryResult.getLuckyNum();
		if (luckyNumber >= 0 && luckyNumber <= 5) { // 极小
			winPlays.add(BetType.MIN.getType());
		}
		if (luckyNumber >= 22 && luckyNumber <= 27) { // 极大
			winPlays.add(BetType.MAX.getType());
		}
	}

	/**
	 * 组合玩法|1314组合玩法
	 */
	private void compusePlay(LotteryResult lotteryResult, List<String> winPlays) {
		int luckyNumber = lotteryResult.getLuckyNum();
		if ((luckyNumber >= 14 && luckyNumber <= 27) && (luckyNumber % 2 != 0)) { // 大单
			winPlays.add(BetType.BIG_ODD.getType());
		}

		if ((luckyNumber >= 14 && luckyNumber <= 27) && (luckyNumber % 2 == 0)) { // 大双
			winPlays.add(BetType.BIG_EVEN.getType());
		}

		if ((luckyNumber >= 0 && luckyNumber <= 13) && (luckyNumber % 2 != 0)) { // 小单
			winPlays.add(BetType.SMALL_ODD.getType());
		}

		if ((luckyNumber >= 0 && luckyNumber <= 13) && (luckyNumber % 2 == 0)) { // 小双
			winPlays.add(BetType.SMALL_EVEN.getType());
		}
	}

}
