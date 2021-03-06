package com.ds.bet.function;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;
import java.util.Set;
import java.util.concurrent.CountDownLatch;
import java.util.concurrent.Future;
import java.util.concurrent.LinkedBlockingQueue;
import java.util.concurrent.ThreadPoolExecutor;
import java.util.concurrent.TimeUnit;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.ds.bet.entity.BetBill;
import com.ds.bet.entity.BetInfo;
import com.ds.bet.repository.BetBillRepository;
import com.ds.bet.thread.BetInfoThreadService;
import com.ds.bet.vo.PlayVo;
import com.ds.common.bet.BetType;
import com.ds.common.constants.Constants;
import com.ds.common.service.CommonService;
import com.ds.common.state.MoneyState;
import com.ds.common.task.UrlConfigVo;
import com.ds.common.threadpool.AbortPolicyWithReport;
import com.ds.common.threadpool.NamedThreadFactory;
import com.ds.common.threadpool.ThreadRuntimeExceptionProcess;
import com.ds.common.util.JSONUtils;
import com.ds.common.util.RandomUtil;
import com.ds.common.util.StringUtil;
import com.ds.entity.BetOdd;
import com.ds.odds.cache.BetOddsCache;
import com.ds.odds.vo.BetOddsType;
import com.ds.redis.api.RedisService;
import com.ds.redis.key.KeyConfig;
import com.ds.transfer.service.MoneyService;

@Service("betWebService")
public class BetInfoService extends CommonService implements KeyConfig, com.ds.common.mq.queue.key.KeyConfig, com.ds.common.bet.KeyConfig {

	private Logger logger = LoggerFactory.getLogger(this.getClass());

	private final String threadName = "bet";

	@Autowired
	private JdbcTemplate jdbcTemplate;

	@Autowired
	private MoneyService moneyService;

	@Autowired
	private RedisService redisService;

	@Autowired
	private BetOddsCache betOddsCache;

	@Autowired
	private BetBillRepository betBillRepository;

	private JSONObject limitObject;

	// fixed固定线程池,需要扔出运行时异常
	private ThreadPoolExecutor fixedPool = new ThreadPoolExecutor(500, 500, 0, TimeUnit.MILLISECONDS, new LinkedBlockingQueue<Runnable>(), //
			new NamedThreadFactory(threadName, true), new AbortPolicyWithReport(threadName)) {
		@Override
		protected void afterExecute(Runnable r, Throwable t) {
			super.afterExecute(r, t);
			new ThreadRuntimeExceptionProcess(r, t).throwsException();
		}
	};

	/**
	 * 批量保存下注
	 * 
	 * @param username
	 *            用户名
	 * @param term
	 *            期数
	 * @param tableId
	 *            桌号
	 * @param betParams
	 *            下注参数
	 */
	@Transactional(propagation = Propagation.NOT_SUPPORTED)
	public Map<String, Object> bet(String username, Long term, Integer tableId, String gameType, JSONArray betParams) {
		String msg = null;
		String type = null;
		Integer num = null;
		Integer money = null;
		Integer siteId = null;
		Date now = new Date(System.currentTimeMillis());
		try {
			// 奖期判断
			String openPrizeJson = this.redisService.get(KEY_LOTTERY + gameType);
			if (StringUtil.isNull(openPrizeJson)) {
				return result(BET_GAME_TYPE_NOT_EXISTS, "bet game type not exists!");
			}
			JSONArray openPrizeArr = JSONArray.parseArray(openPrizeJson);
			long newOpenTerm = openPrizeArr.getJSONObject(0).getLongValue("term");
			if (new BigDecimal(term).compareTo(new BigDecimal(newOpenTerm)) <= 0) {
				return result(BET_NOT_IN_CUR_TERM, "bet term not in cur term!");
			}
			// 限额处理
			int totalMoney = 0;
			String urlConfigStr = this.redisService.get(KEY_URL_CONFIG_TABLE_ID + tableId);
			if (StringUtil.isNull(urlConfigStr)) {
				return result(TABLE_ID_NOT_EXIST, "tableId = " + tableId + " is invalid, not exists urlconfig!");
			}
			UrlConfigVo urlConfigVo = JSONUtils.json2Bean(urlConfigStr, UrlConfigVo.class);
			siteId = urlConfigVo.getSiteId();
			if (!gameType.equals(urlConfigVo.getGameType())) {
				return result(ERROR, "game type donot match tableId!");
			}
			long redisStart = System.currentTimeMillis();
			String cacheLimits = this.redisService.get(KEY_PREFIX_LIMIT + tableId);
//			logger.info("redis 取出限额 = {}", cacheLimits);
			logger.info("redis 取出限额 = {}ms", System.currentTimeMillis() - redisStart);
			if (!StringUtil.isNull(cacheLimits)) {
				limitObject = JSONObject.parseObject(cacheLimits);
			}
			Map<Long, Map<String, BetOdd>> parentIdBetOddsMap = this.betOddsCache.getBetOddsMapByTableId(tableId);
			if (parentIdBetOddsMap == null) {
				return result(TABLE_ID_NOT_EXIST, "tableId=" + tableId + " is invalid, not exists odds!");
			}
			//			Map<Integer, Map<Long, Map<String, BetOdd>>> tableIdBetOddsMap = this.betOddsCache.getTableIdBetOddsMap();
			//			Map<Long, Map<String, BetOdd>> parentIdBetOddsMap = tableIdBetOddsMap.get(tableId);
			// 注单map,key = 玩法type, value=该玩法的注单
			Map<String, List<BetInfo>> betInfoMap = new HashMap<>(); // 下注
			Map<String, BigDecimal> betInfoMapLimit = new HashMap<>(); // 限额
			StringBuffer betMsgBuffer = new StringBuffer();
			boolean pass = true;
			BigDecimal typeBetMoney = null;
			String playType = null;
			String moreLimitType = null;
			for (int i = 0; i < betParams.size(); i++) {
				Map<String, Object> resultMap = new HashMap<>();
				BetInfo betInfo = new BetInfo();
				JSONObject betObject = betParams.getJSONObject(i);
				msg = betObject.getString("msg"); // 下注信息
				type = betObject.getString("type"); // 下注类型
				num = betObject.getInteger("num");
				money = betObject.getInteger("money"); // 下注金额
				betMsgBuffer.append(msg).append(",");
				betInfo.setBetMoney(new BigDecimal(money));
				betInfo.setBillNo(tableId + "_" + RandomUtil.generateString(4) + "_" + money + "_" + username + "_" + type + "_" + System.currentTimeMillis() + "_" + RandomUtil.generateString(8));
				
				String billNo = betInfo.getBillNo();
				if(null != billNo){
					logger.info("账单号:{}",billNo);
					logger.info("长度:{}",billNo.length());
				}
				
				betInfo.setBetMsg(msg);
				betInfo.setBetNum(num);
				betInfo.setBetType(type);
				betInfo.setCreateTime(now);
				betInfo.setGameType(gameType);
				betInfo.setState(MoneyState.BET.getState());
				betInfo.setTableId(tableId);
				betInfo.setTerm(term);
				betInfo.setUsername(siteId + "_" + username);
				// 预计算输赢信息
				PlayVo play = new PlayVo();
				BigDecimal profitExcepted = this.compusePayoff(betInfo, parentIdBetOddsMap, play, limitObject, resultMap);
				BigDecimal profit1314 = this.compusePayoff11314(betInfo, parentIdBetOddsMap, play);
				betInfo.setWinMoney1314(profit1314 == null ? profitExcepted : profit1314);
				betInfo.setWinMoneyExpected(profitExcepted);
				betInfo.setBetOdds1314(play.getBetOdds1314() == null ? play.getBetOddsExcepted() : play.getBetOdds1314());
				betInfo.setBetOddsExpected(play.getBetOddsExcepted());
				betInfo.setSiteId(siteId);
				betInfo.setOriginalUsername(username);
				// 注单集合
				List<BetInfo> playBetList = betInfoMap.get(gameType + Constants.TABLE_CONCAT + type);
				if (playBetList == null) {
					playBetList = new ArrayList<>();
					betInfoMap.put(gameType + Constants.TABLE_CONCAT + type, playBetList);
				}
				playBetList.add(betInfo);
				// 限额集合
				if (BetType.CAO.getType().equals(type)) {
					playType = type + "_" + num;
				} else {
					playType = type;
				}
				typeBetMoney = betInfoMapLimit.get(playType);
				if (typeBetMoney == null) {
					typeBetMoney = new BigDecimal(0);
				}
				typeBetMoney = typeBetMoney.add(betInfo.getBetMoney());
				betInfoMapLimit.put(playType, typeBetMoney);
				totalMoney += money;
				pass = processEveryBetLimit(type, money);
				if (!pass) {
					moreLimitType = type;
					break;
				}
			}
			if (!pass) {
				return result(LESS_OR_MORE_LIMIT_MONEY, moreLimitType);
			}
			Long count = this.betBillRepository.isPayoff(gameType, term, MoneyState.PAY_OFF_WIN.getState());
			if (count != null && count > 0) {
				return result(BET_NOT_IN_CUR_TERM, "bet term is exists payoff record");
			}
			List<Object> resultList = new ArrayList<>();
			Map<String, Object> resultLimitMap = processBetLimitAndSaveBetBill(gameType, tableId, term, username, now, betMsgBuffer, betInfoMapLimit, resultList);
			if (!SUCCESS.equals(resultLimitMap.get(STATUS))) {
				return resultLimitMap;
			}
			BetBill betBill = (BetBill) resultList.get(0);
			String betPlayMoney = (String) resultList.get(1);

			//						Long count = this.betInfoRepository.isPayoff(term, MoneyState.PAY_OFF_LOSS.getState(), MoneyState.PAY_OFF_WIN.getState());
			if (betInfoMap == null || betInfoMap.size() <= 0) {
				return failure("bet play type don't exist");
			}
			long transferStart = System.currentTimeMillis();
			Map<String, Object> resultMap = this.moneyService.transferMoney(term, username, new BigDecimal(totalMoney), urlConfigVo);
			logger.info("transfer 下注转账 = {}ms", System.currentTimeMillis() - transferStart);
			if (SUCCESS.equals(resultMap.get(STATUS))) { // 成功
				// 下注分而食之
				Set<Entry<String, List<BetInfo>>> entrySet = betInfoMap.entrySet();
				List<BetInfo> allBetInfo = new ArrayList<>();
				CountDownLatch latch = new CountDownLatch(entrySet.size());
				Map<String, Future<Integer>> playTypeInsertItem = new HashMap<>();
				long start = System.currentTimeMillis();
				for (Entry<String, List<BetInfo>> entry : entrySet) {
					allBetInfo.addAll(entry.getValue());
					Future<Integer> taskFuture = fixedPool.submit(new BetInfoThreadService(entry.getKey(), entry.getValue(), this.jdbcTemplate, latch));
					playTypeInsertItem.put(entry.getKey(), taskFuture);
				}
				latch.await();
				logger.info("下注数据总耗时 = {}ms", System.currentTimeMillis() - start);
				Set<Entry<String, Future<Integer>>> playTypeInsertEntry = playTypeInsertItem.entrySet();
				for (Entry<String, Future<Integer>> entry : playTypeInsertEntry) {
					if (entry != null) {
						if (entry.getValue().get().intValue() <= 0) {
							logger.error("siteId = {}, 下注人 = {}, 玩法 = {}, 没有得到更新", siteId, username, entry.getKey());
							throw new RuntimeException(entry.getKey() + ":不存在更新条目数");
						}
					}
				}
				long billStart = System.currentTimeMillis();
				betBill.setBetPlayMoney(betPlayMoney);
				betBill.setBetMoney(betBill.getBetMoney().add(new BigDecimal(totalMoney)));
				betBill.setBetMsg((StringUtil.isNull(betBill.getBetMsg()) ? "" : betBill.getBetMsg()) + betMsgBuffer.toString());
				betBill.setUpdateTime(now);
				this.betBillRepository.save(betBill);
				logger.info("注单数据总耗时 = {}ms, 下注到注单耗时 = {}ms", System.currentTimeMillis() - billStart, System.currentTimeMillis() - start);
				return success(allBetInfo);
			}
			if (TRANS_NO_MONEY.equals(resultMap.get(STATUS))) { // 钱不够
				return resultMap;
			}
			return failure(resultMap.get(MESSAGE) + "");
		} catch (Exception e) {
			logger.error("下注异常 : ", e);
			return maybe("下注异常");
		}
	}

	private Map<String, Object> processBetLimitAndSaveBetBill(String gameType, Integer tableId, Long term, String username, Date now, StringBuffer betMsgBuffer, Map<String, BigDecimal> betInfoMapLimit, List<Object> resultList) {
		BetBill betBill = this.betBillRepository.findByTermAndUsernameAndTableId(term, username, tableId);
		String betPlayMoney = null;
		if (betBill == null) {
			betBill = new BetBill();
			betBill.setBetMoney(new BigDecimal(0));
			betPlayMoney = JSONUtils.map2Json(betInfoMapLimit);
			betBill.setBetPlayMoney(betPlayMoney);
			betBill.setBetMsg("");
			betBill.setCreateTime(now);
			betBill.setTableId(tableId);
			betBill.setTerm(term);
			betBill.setUsername(username);
			betBill.setState(MoneyState.BET.getState());
			betBill.setGameType(gameType);
		} else {
			JSONObject betPlayObj = JSONObject.parseObject(betBill.getBetPlayMoney());
			Set<Entry<String, BigDecimal>> entrySet = betInfoMapLimit.entrySet();
			for (Entry<String, BigDecimal> entry : entrySet) {
				BigDecimal bigDecimal = betPlayObj.getBigDecimal(entry.getKey());
				if (bigDecimal == null) {
					bigDecimal = new BigDecimal(0);
				}
				bigDecimal = bigDecimal.add(entry.getValue());
				betPlayObj.put(entry.getKey(), bigDecimal);
			}
			betPlayMoney = betPlayObj.toJSONString();
		}
		StringBuffer errorBuffer = new StringBuffer();
		boolean pass = processTotalLimits(tableId, betPlayMoney, errorBuffer);
		if (!pass) {
			return result(LESS_OR_MORE_LIMIT_MONEY, errorBuffer.toString());
		}
		resultList.add(betBill);
		resultList.add(betPlayMoney);
		return success("ok");
	}

	private boolean processEveryBetLimit(String type, Integer money) {
		JSONObject playObj = limitObject.getJSONObject(type);
		if (money.intValue() < playObj.getIntValue("min") || money.intValue() > playObj.getIntValue("max")) {
			return false;
		}
		return true;
	}

	private boolean processTotalLimits(Integer tableId, String betPlayMoney, StringBuffer errorBuffer) {
		Map<String, Object> betPlayMoneyMap = JSONUtils.json2Map(betPlayMoney);
		Set<Entry<String, Object>> entrySet = betPlayMoneyMap.entrySet();
		int playBetMoney = 0;
		for (Entry<String, Object> entry : entrySet) {
			if (entry.getKey().startsWith(BetType.CAO.getType())) { // 如果以cao开头
				playBetMoney = Integer.valueOf(entry.getValue() + "");
				String[] arr = entry.getKey().split("_");
				JSONObject playLimit = limitObject.getJSONObject(arr[0]);
				if (playLimit == null) {
					throw new RuntimeException("玩法类型 = " + arr[0] + ", 获取不到限额! 玩法第二个小类型 = " + arr[1]);
				}
				playLimit = playLimit.getJSONObject(BetType.CAO.getType());
				playLimit = playLimit.getJSONObject(arr[1]);
				if (playBetMoney > playLimit.getIntValue("max")) {
					errorBuffer.append(arr[0]);
					return false;
				}
				continue;
			}
			JSONObject playLimit = limitObject.getJSONObject(entry.getKey());
			playBetMoney = new BigDecimal(entry.getValue() + "").intValue();
			if (playBetMoney > playLimit.getIntValue("max")) {
				errorBuffer.append(entry.getKey());
				return false;
			}
		}
		return true;
	}

	private BigDecimal compusePayoff11314(BetInfo betInfo, Map<Long, Map<String, BetOdd>> parentIdBetOddsMap, PlayVo play) {
		BigDecimal payoff = null;
		Map<String, BetOdd> dxds1314Map = parentIdBetOddsMap.get(Long.valueOf(BetOddsType.dxds_1314.getType()));
		Map<String, BetOdd> compuse1314Map = parentIdBetOddsMap.get(Long.valueOf(BetOddsType.compuse_1314.getType()));
		BigDecimal odds = null;
		if (BetType.BIG.getType().equals(betInfo.getBetType())) { // 14大
			odds = new BigDecimal(dxds1314Map.get("14_big").getPlay());
		}
		if (BetType.SMALL.getType().equals(betInfo.getBetType())) { // 13小
			odds = new BigDecimal(dxds1314Map.get("13_small").getPlay());
		}
		if (BetType.EVEN.getType().equals(betInfo.getBetType())) { // 14双
			odds = new BigDecimal(dxds1314Map.get("14_even").getPlay());
		}
		if (BetType.ODD.getType().equals(betInfo.getBetType())) { // 13 单
			odds = new BigDecimal(dxds1314Map.get("13_odd").getPlay());
		}
		if (BetType.BIG_EVEN.getType().equals(betInfo.getBetType())) { // 14大双
			odds = new BigDecimal(compuse1314Map.get("14_big_even").getPlay());
		}
		if (BetType.SMALL_ODD.getType().equals(betInfo.getBetType())) { // 13小单
			odds = new BigDecimal(compuse1314Map.get("13_small_odd").getPlay());
		}
		if (odds != null) {
			payoff = betInfo.getBetMoney().multiply(odds);
			play.setBetOdds1314(odds);
		}
		return payoff;
	}

	/**
	 * 计算各个玩法
	 */
	private BigDecimal compusePayoff(BetInfo betInfo, Map<Long, Map<String, BetOdd>> betOddsMap, PlayVo play, JSONObject limitObject, Map<String, Object> resultMap) {
		BigDecimal payoff = null;
		// 获取赔率
		// BetOddsNewExample example = new BetOddsNewExample();
		// List<BetOddsNew> betOddsList =
		// betOddsNewMapper.selectByExample(example);

		Map<String, BetOdd> topBetOdds = betOddsMap.get(null);
		Map<String, BetOdd> jdjxMap = betOddsMap.get(Long.valueOf(BetOddsType.jdjx.getType()));

		/** 红绿蓝波玩法 */
		payoff = colorPlay(betInfo, betOddsMap, play, limitObject, resultMap);
		if (payoff != null) {
			return payoff;
		}

		/** 特殊玩法 */
		payoff = specialPlay(betInfo, betOddsMap, play);
		if (payoff != null) {
			return payoff;
		}
		/** 简单玩法 */
		payoff = dxdsPlay(betInfo, betOddsMap, topBetOdds, play);
		if (payoff != null) {
			return payoff;
		}

		/** 极大极小玩法 */
		payoff = jdjxPlay(betInfo, jdjxMap, play);
		if (payoff != null) {
			return payoff;
		}

		/** 组合玩法 */
		payoff = compusePlay(betInfo, betOddsMap, topBetOdds, play);
		if (payoff != null) {
			return payoff;
		}

		/** 单点玩法 */
		payoff = singPlay(betInfo, betOddsMap, play);
		if (payoff != null) {
			return payoff;
		}

		return payoff;
	}

	/**
	 * 红波, 蓝波, 绿波玩法
	 */
	private BigDecimal colorPlay(BetInfo betInfo, Map<Long, Map<String, BetOdd>> betOddsMap, PlayVo play, JSONObject limitObject, Map<String, Object> resultMap) {
		BigDecimal payoff = null;
		Map<String, BetOdd> colorMap = betOddsMap.get(Long.valueOf(BetOddsType.color.getType()));
		if (BetType.RED.getType().equals(betInfo.getBetType())) {
			BigDecimal odds = new BigDecimal(colorMap.get(BetType.RED.getType()).getPlay());
			payoff = betInfo.getBetMoney().multiply(odds);
			play.setRed(true);
			play.setBetOddsExcepted(odds);
		}
		if (BetType.GREEN.getType().equals(betInfo.getBetType())) {
			BigDecimal odds = new BigDecimal(colorMap.get(BetType.GREEN.getType()).getPlay());
			payoff = betInfo.getBetMoney().multiply(odds);
			play.setGreen(true);
			play.setBetOddsExcepted(odds);
		}
		if (BetType.BLUE.getType().equals(betInfo.getBetType())) {
			BigDecimal odds = new BigDecimal(colorMap.get(BetType.BLUE.getType()).getPlay());
			payoff = betInfo.getBetMoney().multiply(odds);
			play.setBlue(true);
			play.setBetOddsExcepted(odds);
		}
		return payoff;
	}

	/**
	 * 顺子|豹子|对子
	 */
	private BigDecimal specialPlay(BetInfo betInfo, Map<Long, Map<String, BetOdd>> betOddsMap, PlayVo play) {
		BigDecimal payoff = null;
		Map<String, BetOdd> specialMap = betOddsMap.get(Long.valueOf(BetOddsType.special.getType()));
		if (BetType.STRAIGHT.getType().equals(betInfo.getBetType())) {
			BigDecimal odds = new BigDecimal(specialMap.get(BetType.STRAIGHT.getType()).getPlay());
			payoff = betInfo.getBetMoney().multiply(odds);
			play.setStraight(true);
			play.setBetOddsExcepted(odds);
		}
		if (BetType.LEOPARD.getType().equals(betInfo.getBetType())) {
			BigDecimal odds = new BigDecimal(specialMap.get(BetType.LEOPARD.getType()).getPlay());
			payoff = betInfo.getBetMoney().multiply(odds);
			play.setLeopard(true);
			play.setBetOddsExcepted(odds);
		}
		if (BetType.PAIR.getType().equals(betInfo.getBetType())) {
			BigDecimal odds = new BigDecimal(specialMap.get(BetType.PAIR.getType()).getPlay());
			payoff = betInfo.getBetMoney().multiply(odds);
			play.setPair(true);
			play.setBetOddsExcepted(odds);
		}
		return payoff;
	}

	/**
	 * 大小单双|1314大小单双
	 */
	private BigDecimal dxdsPlay(BetInfo betInfo, Map<Long, Map<String, BetOdd>> betOddsMap, Map<String, BetOdd> topBetOdds, PlayVo play) {
		BigDecimal payoff = null;
		Map<String, BetOdd> dxdsMap = betOddsMap.get(Long.valueOf(BetOddsType.dxds.getType()));
		if (BetType.BIG.getType().equals(betInfo.getBetType())) { // 开大
			BigDecimal odds = new BigDecimal(dxdsMap.get("big").getPlay());
			payoff = betInfo.getBetMoney().multiply(odds);
			play.setBig(true);
			play.setBetOddsExcepted(odds);
		}
		if (BetType.SMALL.getType().equals(betInfo.getBetType())) { // 开小
			BigDecimal odds = new BigDecimal(dxdsMap.get("small").getPlay());
			payoff = betInfo.getBetMoney().multiply(odds);
			play.setSmall(true);
			play.setBetOddsExcepted(odds);
		}
		if (BetType.EVEN.getType().equals(betInfo.getBetType())) { // 开双
			BigDecimal odds = new BigDecimal(dxdsMap.get("even").getPlay());
			payoff = betInfo.getBetMoney().multiply(odds);
			play.setEven(true);
			play.setBetOddsExcepted(odds);
		}
		if (BetType.ODD.getType().equals(betInfo.getBetType())) { // 开单
			BigDecimal odds = new BigDecimal(dxdsMap.get("odd").getPlay());
			payoff = betInfo.getBetMoney().multiply(odds);
			play.setOdd(true);
			play.setBetOddsExcepted(odds);
		}
		return payoff;
	}

	/**
	 * 极大极小玩法
	 */
	private BigDecimal jdjxPlay(BetInfo betInfo, Map<String, BetOdd> jdjxMap, PlayVo play) {
		BigDecimal payoff = null;
		if (BetType.MIN.getType().equals(betInfo.getBetType())) { // 极小
			BigDecimal odds = new BigDecimal(jdjxMap.get("min").getPlay());
			payoff = betInfo.getBetMoney().multiply(odds);
			play.setMin(true);
			play.setBetOddsExcepted(odds);
		}
		if (BetType.MAX.getType().equals(betInfo.getBetType())) { // 极大
			BigDecimal odds = new BigDecimal(jdjxMap.get("max").getPlay());
			payoff = betInfo.getBetMoney().multiply(odds);
			play.setMax(true);
			play.setBetOddsExcepted(odds);
		}
		return payoff;
	}

	/**
	 * 组合玩法|1314组合玩法
	 */
	private BigDecimal compusePlay(BetInfo betInfo, Map<Long, Map<String, BetOdd>> betOddsMap, Map<String, BetOdd> topBetOdds, PlayVo play) {
		BigDecimal payoff = null;
		Map<String, BetOdd> compuseMap = betOddsMap.get(Long.valueOf(BetOddsType.compuse.getType()));
		if (BetType.BIG_ODD.getType().equals(betInfo.getBetType())) {
			BigDecimal odds = new BigDecimal(compuseMap.get("big_odd").getPlay());
			payoff = betInfo.getBetMoney().multiply(odds);
			play.setBigOdd(true);
			play.setBetOddsExcepted(odds);
		}

		if (BetType.BIG_EVEN.getType().equals(betInfo.getBetType())) {
			BigDecimal odds = new BigDecimal(compuseMap.get("big_even").getPlay());
			payoff = betInfo.getBetMoney().multiply(odds);
			play.setBigEven(true);
			play.setBetOddsExcepted(odds);
		}

		if (BetType.SMALL_ODD.getType().equals(betInfo.getBetType())) {
			BigDecimal odds = new BigDecimal(compuseMap.get("small_odd").getPlay());
			payoff = betInfo.getBetMoney().multiply(odds);
			play.setSmallOdd(true);
			play.setBetOddsExcepted(odds);
		}

		if (BetType.SMALL_EVEN.getType().equals(betInfo.getBetType())) {
			BigDecimal odds = new BigDecimal(compuseMap.get("small_even").getPlay());
			payoff = betInfo.getBetMoney().multiply(odds);
			play.setSmallEven(true);
			play.setBetOddsExcepted(odds);
		}
		return payoff;
	}

	/**
	 * 单点数字草玩法
	 */
	private BigDecimal singPlay(BetInfo betInfo, Map<Long, Map<String, BetOdd>> betOddsMap, PlayVo play) {
		BigDecimal payoff = null;
		Map<String, BetOdd> singMap = betOddsMap.get(Long.valueOf(BetOddsType.sing.getType()));
		if (BetType.CAO.getType().equals(betInfo.getBetType())) {
			play.setSing(true);
			BigDecimal singOdds = null;
			// 下面对中奖的号码进行赔率计算
			if (betInfo.getBetNum() == 0) {
				singOdds = new BigDecimal(singMap.get("0").getPlay());
			}
			if (betInfo.getBetNum() == 1) {
				singOdds = new BigDecimal(singMap.get("1").getPlay());
			}
			if (betInfo.getBetNum() == 2) {
				singOdds = new BigDecimal(singMap.get("2").getPlay());
			}
			if (betInfo.getBetNum() == 3) {
				singOdds = new BigDecimal(singMap.get("3").getPlay());
			}
			if (betInfo.getBetNum() == 4) {
				singOdds = new BigDecimal(singMap.get("4").getPlay());
			}
			if (betInfo.getBetNum() == 5) {
				singOdds = new BigDecimal(singMap.get("5").getPlay());
			}
			if (betInfo.getBetNum() == 6) {
				singOdds = new BigDecimal(singMap.get("6").getPlay());
			}
			if (betInfo.getBetNum() == 7) {
				singOdds = new BigDecimal(singMap.get("7").getPlay());
			}
			if (betInfo.getBetNum() == 8) {
				singOdds = new BigDecimal(singMap.get("8").getPlay());
			}
			if (betInfo.getBetNum() == 9) {
				singOdds = new BigDecimal(singMap.get("9").getPlay());
			}
			if (betInfo.getBetNum() == 10) {
				singOdds = new BigDecimal(singMap.get("10").getPlay());
			}
			if (betInfo.getBetNum() == 11) {
				singOdds = new BigDecimal(singMap.get("11").getPlay());
			}
			if (betInfo.getBetNum() == 12) {
				singOdds = new BigDecimal(singMap.get("12").getPlay());
			}
			if (betInfo.getBetNum() == 13) {
				singOdds = new BigDecimal(singMap.get("13").getPlay());
			}
			if (betInfo.getBetNum() == 14) {
				singOdds = new BigDecimal(singMap.get("14").getPlay());
			}
			if (betInfo.getBetNum() == 15) {
				singOdds = new BigDecimal(singMap.get("15").getPlay());
			}
			if (betInfo.getBetNum() == 16) {
				singOdds = new BigDecimal(singMap.get("16").getPlay());
			}
			if (betInfo.getBetNum() == 17) {
				singOdds = new BigDecimal(singMap.get("17").getPlay());
			}
			if (betInfo.getBetNum() == 18) {
				singOdds = new BigDecimal(singMap.get("18").getPlay());
			}
			if (betInfo.getBetNum() == 19) {
				singOdds = new BigDecimal(singMap.get("19").getPlay());
			}
			if (betInfo.getBetNum() == 20) {
				singOdds = new BigDecimal(singMap.get("20").getPlay());
			}
			if (betInfo.getBetNum() == 21) {
				singOdds = new BigDecimal(singMap.get("21").getPlay());
			}
			if (betInfo.getBetNum() == 22) {
				singOdds = new BigDecimal(singMap.get("22").getPlay());
			}
			if (betInfo.getBetNum() == 23) {
				singOdds = new BigDecimal(singMap.get("23").getPlay());
			}
			if (betInfo.getBetNum() == 24) {
				singOdds = new BigDecimal(singMap.get("24").getPlay());
			}
			if (betInfo.getBetNum() == 25) {
				singOdds = new BigDecimal(singMap.get("25").getPlay());
			}
			if (betInfo.getBetNum() == 26) {
				singOdds = new BigDecimal(singMap.get("26").getPlay());
			}
			if (betInfo.getBetNum() == 27) {
				singOdds = new BigDecimal(singMap.get("27").getPlay());
			}
			payoff = betInfo.getBetMoney().multiply(singOdds);
			play.setBetOddsExcepted(singOdds);
		}
		return payoff;
	}

}
