package com.ds.lottery.result.task.thread;

import java.text.MessageFormat;
import java.util.Date;

import javax.transaction.Transactional;

import org.apache.commons.lang.StringUtils;
import org.apache.commons.lang.time.DateUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.client.RestTemplate;

import com.alibaba.fastjson.JSONObject;
import com.ds.common.constants.Constants.GameType;
import com.ds.common.constants.Constants.GameTypeTime;
import com.ds.common.constants.Constants.GameTypeToAG;
import com.ds.common.util.DateUtil;
import com.ds.common.util.JSONUtils;
import com.ds.common.util.LottoUtil;
import com.ds.common.util.StringUtil;
import com.ds.entity.LotteryResult;
import com.ds.lottery.result.repository.LotteryResultRepository;
import com.ds.redis.api.RedisService;
import com.ds.redis.key.KeyConfig;

public class Thread_AG implements Runnable {
	private final Logger logger = LoggerFactory.getLogger(this.getClass());
	private RestTemplate restTemplate;

	private LotteryResultRepository lotteryResultInfoRepository;
	private String gameType;

	private String lock;

	private String url;

	private RedisService redisService;

	private Integer timeZone;

	public Thread_AG(LotteryResultRepository lotteryResultInfoRepository, String gameType, RestTemplate restTemplate, String url, String lock, RedisService redisService, Integer timeZone) {
		this.lotteryResultInfoRepository = lotteryResultInfoRepository;
		this.gameType = gameType;
		this.restTemplate = restTemplate;
		this.lock = lock;
		this.url = url;
		this.redisService = redisService;
		this.timeZone = timeZone;
	}

	@Transactional
	@Override
	public void run() {
		synchronized (lock) {
			try {

				if (gameType.equals(GameType.加拿大二八.getKey())) {
					url = MessageFormat.format(url, GameTypeToAG.加拿大二八.getKey());
				} else {
					url = MessageFormat.format(url, GameTypeToAG.幸运二八.getKey());
				}
				String jsons = restTemplate.getForObject(url, String.class);
				if (StringUtils.isEmpty(jsons)) {
					logger.info("AG获取{}开奖数据为空", gameType);
					return;
				}
				JSONObject jsonObject = JSONObject.parseObject(jsons);
				String status = jsonObject.getString("status");
				if (StringUtils.isEmpty(status)) {
					logger.info("AG解析{}开奖数据为空", gameType);
					return;
				}

				if (!status.equals("ok")) {
					logger.info("AG获取{}开奖数据出错", gameType);
					return;
				}

				LotteryResult lastest = lotteryResultInfoRepository.findLastestOneByGameType(gameType);
				if (lastest == null) {
					logger.info("获取{}参考开奖数据为空", gameType);
					return;
				}

				String term = jsonObject.getString("issue");

				String result = jsonObject.getString("code");
				result = StringUtil.getNumeric(result);
				String sum = jsonObject.getString("sum");
				
				Date closeTime = DateUtil.parse(DateUtil.YY_MM_DD_HH_MM_SS, LottoUtil.getCloseDate(Long.valueOf(term), lastest.getTerm() + "", DateUtil.format(DateUtil.YY_MM_DD_HH_MM_SS, lastest.getOpenTime()), Float.valueOf(LottoUtil.getMins(gameType, timeZone))));

				Date openTime = DateUtils.addSeconds(closeTime, 30);

				Date dateB = DateUtils.addMinutes(new Date(), GameTypeTime.getValue(gameType).getValue());
				if (openTime.getTime() < dateB.getTime() || openTime.getTime() > System.currentTimeMillis()) {
					logger.info("AG拉取{},{}开奖数据开奖时间{}错误", gameType, term, openTime);
					return;
				}

				LotteryResult lotteryResult = lotteryResultInfoRepository.findByGameTypeAndTerm(gameType, Long.valueOf(term));
				if (null != lotteryResult) {
					logger.info("{}期的开奖数据已经存在", term);
					return;
				}

				LotteryResult entity = new LotteryResult();

				entity.setGameType(gameType);
				entity.setTerm(Long.valueOf(term));
				entity.setCloseTime(closeTime);
				entity.setOpenTime(openTime);
				entity.setOriginalNum(result);
				entity.setOpenUrl(url);
				entity.setLuckyNum(Integer.valueOf(sum));
				entity.setCreateTime(new Date());

				lotteryResultInfoRepository.save(entity);
				logger.info("{},{}期的开奖数据插入成功", gameType, term);
				redisService.set(KeyConfig.KEY_LOTTERY + gameType, JSONUtils.bean2Json(lotteryResultInfoRepository.findLastest10ByGameType(gameType)));

			} catch (Exception e) {
				logger.error("AG拉取" + gameType + "开奖数据开奖错误", e);
			}
		}

	}

}
