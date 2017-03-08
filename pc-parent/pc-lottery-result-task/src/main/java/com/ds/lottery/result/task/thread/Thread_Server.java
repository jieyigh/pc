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
import com.ds.common.constants.Constants.GameTypeToUrl;
import com.ds.common.constants.Constants.TimeZone;
import com.ds.common.util.DateUtil;
import com.ds.common.util.JSONUtils;
import com.ds.common.util.LottoUtil;
import com.ds.entity.LotteryResult;
import com.ds.lottery.result.repository.LotteryResultRepository;
import com.ds.redis.api.RedisService;
import com.ds.redis.key.KeyConfig;

public class Thread_Server implements Runnable {
	private final Logger logger = LoggerFactory.getLogger(this.getClass());
	private RestTemplate restTemplate;

	private LotteryResultRepository lotteryResultInfoRepository;
	private String gameType;

	private String lock;

	private String url;

	private RedisService redisService;

	private Integer timeZone;

	public Thread_Server(LotteryResultRepository lotteryResultInfoRepository, String gameType, RestTemplate restTemplate, String url, String lock, RedisService redisService, Integer timeZone) {
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
					url = MessageFormat.format(url, GameTypeToUrl.加拿大二八.getKey(), 1, 1);
				} else {
					// 幸运28时间校验
					long start = 0;//
					long end = 0;//

					Date startDate = null;
					Date endDate = null;
					Date nowDate = new Date();

					if (timeZone.intValue() == TimeZone.北京时间.getKey().intValue()) {
						startDate = DateUtil.parse(DateUtil.YY_MM_DD_HH_MM_SS, DateUtil.getTodayDateDifferDay(0, "-") + " 00:00:00");
						endDate = DateUtil.parse(DateUtil.YY_MM_DD_HH_MM_SS, DateUtil.getTodayDateDifferDay(0, "-") + " 09:00:00");
					} else if (timeZone.intValue() == TimeZone.美东时间.getKey().intValue()) {
						startDate = DateUtil.parse(DateUtil.YY_MM_DD_HH_MM_SS, DateUtil.getTodayDateDifferDay(0, "-") + " 12:00:00");//
						endDate = DateUtil.parse(DateUtil.YY_MM_DD_HH_MM_SS, DateUtil.getTodayDateDifferDay(0, "-") + " 21:00:00");//
					}
					logger.info("startDate:"+startDate+",endDate:"+endDate+",nowDate:"+nowDate);
					start = startDate.getTime();//
					end = endDate.getTime();//
					long now = nowDate.getTime();
					
					/*if (now >= start && now <= end) {
						logger.info("服务器不在幸运28指定时间内拉取");
						return;
					}*/
					url = MessageFormat.format(url, GameTypeToUrl.幸运二八.getKey(), 1, 1);
				}
				String jsons = restTemplate.getForObject(url, String.class);
				if (StringUtils.isEmpty(jsons)) {
					logger.info("服务器获取{}开奖数据为空", gameType);
					return;
				}
				JSONObject jsonObject = JSONObject.parseObject(jsons);
				String data = jsonObject.getString("data");
				if (StringUtils.isEmpty(data)) {
					logger.info("服务器解析{}开奖数据为空", gameType);
					return;
				}
				JSONArray array = (JSONArray) JSONArray.parse(data);
				JSONObject dataObject = (JSONObject) array.get(0);
				String term = dataObject.getString("qishu");
				String time = dataObject.getString("lotteryTime");
				Date lottoTime = new Date(Long.valueOf(time));

				String result = dataObject.getString("result");
				Date openTime = lottoTime;
				if (timeZone.intValue() == TimeZone.美东时间.getKey().intValue()) {
					//美东时间
					openTime = DateUtils.addHours(openTime, -12);
				}

				Date closeTime = DateUtils.addSeconds(openTime, -30);

				Date dateB = DateUtils.addMinutes(new Date(), GameTypeTime.getValue(gameType).getValue());
				if (openTime.getTime() < dateB.getTime() || openTime.getTime() > System.currentTimeMillis()) {
					logger.info("服务器拉取{},{}开奖数据开奖时间{}错误", gameType, term, openTime);
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
				entity.setOpenUrl("http://www.dt778899.com");
				entity.setLuckyNum(LottoUtil.getNumberSum(result));
				entity.setCreateTime(new Date());

				lotteryResultInfoRepository.save(entity);
				logger.info("{}期的开奖数据插入成功", term);

				redisService.set(KeyConfig.KEY_LOTTERY + gameType, JSONUtils.bean2Json(lotteryResultInfoRepository.findLastest10ByGameType(gameType)));

			} catch (Exception e) {
				logger.error("服务器拉取" + gameType + "开奖数据开奖错误", e);
			}
		}

	}

}
