package com.ds.lottery.result.task.thread;

import java.text.MessageFormat;
import java.util.Date;

import javax.transaction.Transactional;

import org.apache.commons.lang.StringUtils;
import org.apache.commons.lang.time.DateUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.ResponseEntity;
import org.springframework.web.client.RestTemplate;

import com.alibaba.fastjson.JSONObject;
import com.ds.common.constants.Constants.GameType;
import com.ds.common.constants.Constants.GameTypeTime;
import com.ds.common.constants.Constants.GameTypeTo168;
import com.ds.common.constants.Constants.TimeZone;
import com.ds.common.util.DateUtil;
import com.ds.common.util.JSONUtils;
import com.ds.common.util.LottoUtil;
import com.ds.entity.LotteryResult;
import com.ds.lottery.result.repository.LotteryResultRepository;
import com.ds.redis.api.RedisService;
import com.ds.redis.key.KeyConfig;

public class Thread_168 implements Runnable {
	private final Logger logger = LoggerFactory.getLogger(this.getClass());
	private RestTemplate restTemplate;

	private LotteryResultRepository lotteryResultInfoRepository;
	private String gameType;

	private String lock;

	private String url;

	private RedisService redisService;

	private Integer timeZone;

	public Thread_168(LotteryResultRepository lotteryResultInfoRepository, String gameType, RestTemplate restTemplate, String url, String lock, RedisService redisService, Integer timeZone) {
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
					url = MessageFormat.format(url, GameTypeTo168.加拿大二八.getKey());
				} 
				if (gameType.equals(GameType.幸运二八.getKey())){
					url = MessageFormat.format(url, GameTypeTo168.幸运二八.getKey());
				}
				if (gameType.equals(GameType.重庆二八.getKey())) {
					url = MessageFormat.format(url, GameTypeTo168.重庆二八.getKey());
				} 
				if (gameType.equals(GameType.新疆二八.getKey())) {
					url = MessageFormat.format(url, GameTypeTo168.新疆二八.getKey());
				}

				HttpHeaders headers = new HttpHeaders();
				headers.add("Referer", "http://...");
				headers.add("User-Agent", "Mozilla/5.0");

				ResponseEntity<String> resp = restTemplate.exchange(url, HttpMethod.GET, new HttpEntity(headers), String.class);

				String jsons = resp.getBody();
				if (StringUtils.isEmpty(jsons)) {
					logger.info("168获取{}开奖数据为空", gameType);
					return;
				}
				JSONObject jsonObject = JSONObject.parseObject(jsons);
				String term = jsonObject.getString("l_t");
				String originalNumber = jsonObject.getString("l_r");
				String time = jsonObject.getString("c_d");

				//xj28   4,6,9,6,5
				//cq28   0,5,6,0,9
				//keno28 1,2,7,8,18,20,36,37,44,46,48,53,57,61,66,67,68,69,78,80
				//xy28   35,20,64,55,4,59,39,3,26,58,68,6,46,36,75,16,52,34,77,5,2
				String resultStr = LottoUtil.getNumberStrByNone(gameType.equals(GameType.幸运二八.getKey()) ? originalNumber.substring(0, originalNumber.length() - 2) : originalNumber, gameType);
				if (!StringUtils.isNumeric(resultStr)) {
					logger.info("168获取开奖数据不为数字");
					return;
				}

				Date openTime = DateUtil.parse(DateUtil.YY_MM_DD_HH_MM_2, time);
				if (timeZone.intValue() == TimeZone.美东时间.getKey().intValue()) {
					//北京时间-12
					openTime = DateUtils.addHours(openTime, -12);
				}
				Date closeTime = DateUtils.addSeconds(openTime, -30);

				Date dateB = DateUtils.addMinutes(new Date(), GameTypeTime.getValue(gameType).getValue());
				if (openTime.getTime() < dateB.getTime() || openTime.getTime() > System.currentTimeMillis()) {
					logger.info("168拉取{},{}开奖数据开奖时间{}错误", gameType, term, openTime);
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
				entity.setOriginalNum(resultStr);
				entity.setOpenUrl(url);
				entity.setLuckyNum(LottoUtil.getNumberSum(resultStr));
				entity.setCreateTime(new Date());
				lotteryResultInfoRepository.save(entity);
				
				logger.info("{},{}期的开奖数据插入成功", gameType, term);
				redisService.set(KeyConfig.KEY_LOTTERY + gameType, JSONUtils.bean2Json(lotteryResultInfoRepository.findLastest10ByGameType(gameType)));

			} catch (Exception e) {
				logger.error("168拉取" + gameType + "开奖数据开奖错误", e);
			}
		}

	}

}
