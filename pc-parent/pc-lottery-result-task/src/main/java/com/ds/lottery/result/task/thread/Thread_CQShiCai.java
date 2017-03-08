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

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.ds.common.constants.Constants.GameType;
import com.ds.common.constants.Constants.GameTypeTime;
import com.ds.common.constants.Constants.GameTypeToCQShiCai;
import com.ds.common.constants.Constants.TimeZone;
import com.ds.common.util.DateUtil;
import com.ds.common.util.JSONUtils;
import com.ds.common.util.LottoUtil;
import com.ds.entity.LotteryResult;
import com.ds.lottery.result.repository.LotteryResultRepository;
import com.ds.redis.api.RedisService;
import com.ds.redis.key.KeyConfig;

public class Thread_CQShiCai implements Runnable {
	private final Logger logger = LoggerFactory.getLogger(this.getClass());
	private RestTemplate restTemplate;

	private LotteryResultRepository lotteryResultInfoRepository;

	private String lock;

	private String url;

	private RedisService redisService;
	
	private String gameType;
	
	private Integer timeZone;

	public Thread_CQShiCai(LotteryResultRepository lotteryResultInfoRepository, String gameType,RestTemplate restTemplate, String url, String lock, RedisService redisService,Integer timeZone) {
		this.lotteryResultInfoRepository = lotteryResultInfoRepository;
		this.restTemplate = restTemplate;
		this.lock = lock;
		this.url = url;
		this.redisService = redisService;
		this.gameType=gameType;
		this.timeZone = timeZone;
	}

	@Transactional
	@Override
	public void run() {
		synchronized (lock) {
			try {

				HttpHeaders headers = new HttpHeaders();
				headers.add("Referer", "http://...");
				headers.add("User-Agent", "Mozilla/5.0");
				
				if (gameType.equals(GameType.重庆二八.getKey())) {
					url = MessageFormat.format(url, GameTypeToCQShiCai.重庆二八.getKey());
				} 
				if (gameType.equals(GameType.新疆二八.getKey())) {
					url = MessageFormat.format(url, GameTypeToCQShiCai.新疆二八.getKey());
				}
				
				ResponseEntity<String> resp = restTemplate.exchange(url, HttpMethod.GET, new HttpEntity(headers), String.class);

				String jsons = resp.getBody();
				if (StringUtils.isEmpty(jsons)) {
					logger.info("CQShiCai获取{}开奖数据为空", gameType);
					return;
				}
				JSONObject jsonObject = JSONObject.parseObject(jsons);
				String message = jsonObject.getString("message");
				
				if(null != message && !message.equals("操作成功")){
					logger.info("CQShiCai获取{}开奖数据有错", gameType);
					return;
				}
				
				JSONObject result = jsonObject.getJSONObject("result");
				
				JSONArray dataJson = result.getJSONArray("data");
				JSONObject first = dataJson.getJSONObject(0);
				
				String preDrawCode = first.getString("preDrawCode");
				String preDrawIssue = first.getString("preDrawIssue");
				String preDrawTime = first.getString("preDrawTime");
				
				String resultStr = LottoUtil.getNumberStrByNone(preDrawCode, gameType);
				if (!StringUtils.isNumeric(resultStr)) {
					logger.info("CQShiCai获取开奖数据不为数字");
					return;
				}
				
				
				Date openTime = DateUtil.parse(DateUtil.YY_MM_DD_HH_MM, preDrawTime);
				if (timeZone.intValue() == TimeZone.美东时间.getKey().intValue()) {
					//北京时间-12
					openTime = DateUtils.addHours(openTime, -12);
				}
				Date closeTime = DateUtils.addSeconds(openTime, -30);

				Date dateB = DateUtils.addMinutes(new Date(), GameTypeTime.getValue(gameType).getValue());
				if (openTime.getTime() < dateB.getTime() || openTime.getTime() > System.currentTimeMillis()) {
					logger.info("CQShiCai拉取{},{}开奖数据开奖时间{}错误", gameType, preDrawIssue, openTime);
					return;
				}

				LotteryResult lotteryResult = lotteryResultInfoRepository.findByGameTypeAndTerm(gameType, Long.valueOf(preDrawIssue));
				if (null != lotteryResult) {
					logger.info("{}期的开奖数据已经存在", preDrawIssue);
					return;
				}

				LotteryResult entity = new LotteryResult();

				entity.setGameType(gameType);
				entity.setTerm(Long.valueOf(preDrawIssue));
				entity.setCloseTime(closeTime);
				entity.setOpenTime(openTime);
				entity.setOriginalNum(resultStr);
				entity.setOpenUrl(url);
				entity.setLuckyNum(LottoUtil.getNumberSum(resultStr));
				entity.setCreateTime(new Date());
				lotteryResultInfoRepository.save(entity);
				
				logger.info("{},{}期的开奖数据插入成功", gameType, preDrawIssue);
				redisService.set(KeyConfig.KEY_LOTTERY + gameType, JSONUtils.bean2Json(lotteryResultInfoRepository.findLastest10ByGameType(gameType)));

			} catch (Exception e) {
				logger.error("CQShiCai拉取" + gameType + "开奖数据开奖错误", e);
			}
		}

	}

}
