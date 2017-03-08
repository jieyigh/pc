package com.ds.lottery.result.task.thread;

import java.text.MessageFormat;
import java.util.Date;

import javax.transaction.Transactional;

import org.apache.commons.lang.StringUtils;
import org.apache.commons.lang.time.DateUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.client.RestTemplate;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.ds.common.constants.Constants.GameType;
import com.ds.common.constants.Constants.GameTypeTime;
import com.ds.common.constants.Constants.GameTypeToZAO;
import com.ds.common.constants.Constants.TimeZone;
import com.ds.common.util.DateUtil;
import com.ds.common.util.JSONUtils;
import com.ds.common.util.StringUtil;
import com.ds.entity.LotteryResult;
import com.ds.lottery.result.repository.LotteryResultRepository;
import com.ds.redis.api.RedisService;
import com.ds.redis.key.KeyConfig;

public class Thread_ZAO implements Runnable {
	private final Logger logger = LoggerFactory.getLogger(this.getClass());
	private RestTemplate restTemplate;

	private LotteryResultRepository lotteryResultInfoRepository;
	private String gameType;

	private String lock;

	private String url;

	private RedisService redisService;

	private Integer timeZone;

	public Thread_ZAO(LotteryResultRepository lotteryResultInfoRepository, String gameType, RestTemplate restTemplate, String url, String lock, RedisService redisService, Integer timeZone) {
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
					url = MessageFormat.format(url, GameTypeToZAO.加拿大二八.getKey());
				} else if(gameType.equals(GameType.幸运二八.getKey())) {					
					url = MessageFormat.format(url, GameTypeToZAO.北京二八.getKey());
				} 
				String jsons = restTemplate.getForObject(url, String.class);
				
				if (StringUtils.isEmpty(jsons)) {
					logger.info("ZAO获取{}开奖数据为空", gameType);
					return;
				}
				JSONObject jsonObject = JSONObject.parseObject(jsons);
				String status = jsonObject.getString("status");				

				if (!status.equals("ok")) {
					logger.info("ZAO获取{}开奖数据出错", gameType);
					return;
				}

				String datas = jsonObject.getString("datas");
				JSONArray datasArr = JSONArray.parseArray(datas);
				
				JSONObject last = (JSONObject) datasArr.get(0);
				
				/**
				 * {
					  "issue": "2095336",
					  "kjcodes": "0,2,5",
					  "kjcode": 7,
					  "srccode": "5,6,8,11,17,18,20,25,28,32,34,39,44,49,57,61,69,72,77,80",
					  "time": "2017-01-20 13:59:30"
					}
				 */
				
				String term = last.getString("issue");
				String kjcodes = last.getString("kjcodes");
				String kjcode = last.getString("kjcode");
				String time = last.getString("time");		

				kjcodes = StringUtil.getNumeric(kjcodes);

				Date openTime = DateUtil.parse(DateUtil.YY_MM_DD_HH_MM_SS,time);
				
				if (timeZone.intValue() == TimeZone.美东时间.getKey().intValue()) {
					//北京时间-12
					openTime = DateUtils.addHours(openTime, -12);
				}
				Date closeTime = DateUtils.addSeconds(openTime, -30);

				Date dateB = DateUtils.addMinutes(new Date(), GameTypeTime.getValue(gameType).getValue());
				if (openTime.getTime() < dateB.getTime() || openTime.getTime() > System.currentTimeMillis()) {
					logger.info("ZAO拉取{},{}开奖数据开奖时间{}错误", gameType, term, openTime);
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
				entity.setOriginalNum(kjcodes);
				entity.setOpenUrl(url);
				entity.setLuckyNum(Integer.valueOf(kjcode));
				entity.setCreateTime(new Date());

				lotteryResultInfoRepository.save(entity);
				logger.info("{},{}期的开奖数据插入成功", gameType, term);
				redisService.set(KeyConfig.KEY_LOTTERY + gameType, JSONUtils.bean2Json(lotteryResultInfoRepository.findLastest10ByGameType(gameType)));

			} catch (Exception e) {
				logger.error("ZAO拉取" + gameType + "开奖数据开奖错误", e);
			}
		}

	}

}
