package com.ds.statements.service;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.annotation.Resource;
import javax.jms.Queue;
import javax.transaction.Transactional;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.scheduling.annotation.EnableScheduling;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;

import com.alibaba.fastjson.JSONArray;
import com.ds.bet.service.BetBillService;
import com.ds.bet.vo.TodoOpenVo;
import com.ds.common.bet.BetType;
import com.ds.common.mq.queue.key.KeyConfig;
import com.ds.common.service.CommonService;
import com.ds.common.state.MoneyState;
import com.ds.entity.LotteryResult;
import com.ds.lottery.result.service.LotteryResultService;
import com.ds.mq.provider.p2p.MQProviderService;
import com.ds.redis.api.RedisService;
import com.ds.statements.statements.AbstractStatements;
import com.ds.statements.statements.pc28.PC28Statements;
import com.ds.statements.statements.ssc.OrderBetNum;

@Service
@EnableScheduling
public class StatementsService extends CommonService implements KeyConfig, com.ds.redis.key.KeyConfig, com.ds.common.bet.KeyConfig {

	//	private final StringBuffer statementBillBuffer = new StringBuffer("UPDATE pc_bet_bill SET state = ");

	private Logger logger = LoggerFactory.getLogger(this.getClass());

	@Autowired
	private BetBillService betBillService;

	@Autowired
	private LotteryResultService lotteryResultService;

	@Autowired
	private MQProviderService mqService;

	@Autowired
	private RedisService redisService;

	@Resource(name = QUEUE_PAY_OFF)
	private Queue queueTransfer;

	@Resource(name = QUEUE_BILL_RECORD)
	private Queue queueBillRecord;

	@Autowired
	private JdbcTemplate jdbcTemplate;

	private boolean opening = false;

	/**
	 * 查询待开奖的奖期<br>
	 * 1. 获取未开奖的期数<br>
	 * 2. 遍历开奖
	 */
	@Scheduled(fixedDelay = 5 * 1000)
	@Transactional
	public void findTodoOpen() {
		Date now = new Date();
		if (opening) {
			return;
		}
		try {
			List<TodoOpenVo> todoOpenList = this.betBillService.findTermByState(MoneyState.BET.getState());
			if (todoOpenList == null || todoOpenList.size() <= 0) {
				return;
			}
			for (TodoOpenVo todoOpen : todoOpenList) {
				logger.info("待开奖 : 游戏类型 = {}, 开奖期数 = {}", todoOpen.getGameType(), todoOpen.getTerm());
				LotteryResult lotteryResult = this.lotteryResultService.findByGameTypeAndTerm(todoOpen.getGameType(), todoOpen.getTerm());
				if (lotteryResult == null) {
					continue;
				}
				opening = true;
				AbstractStatements statements = null;
				if (lotteryResult.getGameType().endsWith("28")) { // 28类玩法
					statements = new PC28Statements(now, todoOpen, lotteryResult, //
							queueBillRecord, queueTransfer, //
							mqService, redisService, //
							jdbcTemplate, betBillService);
					statements.statements();
				} else if (lotteryResult.getGameType().endsWith("ssc")) { // 时时彩玩法
					Set<String> winPlays = new HashSet<>(); // 赢得玩法
					// {key = play, value = [下注顺序含义]}
					Map<String, List<Integer>> playOrderNumMap = new HashMap<>();
					logger.info("正在开奖 : 游戏类型 = {}, 开奖期数 = {}", todoOpen.getGameType(), todoOpen.getTerm());
					// 获取赢得玩法
					this.getWinPlays(lotteryResult, winPlays, playOrderNumMap);
					JSONArray playArr = JSONArray.parseArray(this.redisService.get(KEY_PLAY + lotteryResult.getGameType()));
					for (int i = 0; i < playArr.size(); i++) {
						
					}
				}
			}
		} catch (Exception e) {
			logger.error("派彩错误 : ", e);
			throw new RuntimeException("派彩出现异常");
		} finally {
			opening = false;
		}
	}

	private void getWinPlays(LotteryResult lotteryResult, Set<String> winPlays, Map<String, List<Integer>> playOrderNumMap) {
		String originalNum = lotteryResult.getOriginalNum();
		int tenThousand = originalNum.charAt(0);
		int thousand = originalNum.charAt(1);
		int hundred = originalNum.charAt(2);
		int ten = originalNum.charAt(3);
		int unit = originalNum.charAt(4);
		// 大小单双玩法
		dxdsPlayOrderNum(winPlays, playOrderNumMap, tenThousand, OrderBetNum.TEN_THOUSAND.getOrderBetNum());
		dxdsPlayOrderNum(winPlays, playOrderNumMap, thousand, OrderBetNum.THOUSAND.getOrderBetNum());
		dxdsPlayOrderNum(winPlays, playOrderNumMap, hundred, OrderBetNum.HUNDRED.getOrderBetNum());
		dxdsPlayOrderNum(winPlays, playOrderNumMap, ten, OrderBetNum.TEN.getOrderBetNum());
		dxdsPlayOrderNum(winPlays, playOrderNumMap, unit, OrderBetNum.UNIT.getOrderBetNum());
		// 龙虎和玩法
		if (tenThousand > unit) {
			winPlays.add(BetType.DRAGON.getType());
		} else if (thousand < unit) {
			winPlays.add(BetType.TIGER.getType());
		} else {
			winPlays.add(BetType.EQUAL.getType());
		}
		// 总和玩法
		int total = tenThousand + thousand + hundred + ten + unit;
		dxdsPlayOrderNum(winPlays, playOrderNumMap, total, OrderBetNum.TOTAL.getOrderBetNum());
	}

	/**
	 * 大小大双玩法收集
	 */
	private void dxdsPlayOrderNum(Set<String> winPlays, Map<String, List<Integer>> playOrderNumMap, int num, Integer orderBetNum) {
		// 匹配大小
		if (num >= 5) {
			winPlays.add(BetType.BIG.getType());
			List<Integer> bigList = playOrderNumMap.get(BetType.BIG.getType());
			if (bigList == null) {
				bigList = new ArrayList<>();
				playOrderNumMap.put(BetType.BIG.getType(), bigList);
			}
			bigList.add(orderBetNum);
		} else {
			winPlays.add(BetType.SMALL.getType());
			List<Integer> smallList = playOrderNumMap.get(BetType.SMALL.getType());
			if (smallList == null) {
				smallList = new ArrayList<>();
				playOrderNumMap.put(BetType.SMALL.getType(), smallList);
			}
			smallList.add(orderBetNum);
		}
		// 匹配单双
		if (num % 2 == 1) {
			winPlays.add(BetType.ODD.getType());
			List<Integer> oddList = playOrderNumMap.get(BetType.ODD.getType());
			if (oddList == null) {
				oddList = new ArrayList<>();
				playOrderNumMap.put(BetType.ODD.getType(), oddList);
			}
			oddList.add(orderBetNum);
		} else {
			winPlays.add(BetType.EVEN.getType());
			List<Integer> evenList = playOrderNumMap.get(BetType.EVEN.getType());
			if (evenList == null) {
				evenList = new ArrayList<>();
				playOrderNumMap.put(BetType.EVEN.getType(), evenList);
			}
			evenList.add(orderBetNum);
		}
	}

}
