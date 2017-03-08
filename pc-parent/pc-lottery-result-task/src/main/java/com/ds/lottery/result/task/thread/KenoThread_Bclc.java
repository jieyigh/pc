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
import com.ds.common.constants.Constants.TimeZone;
import com.ds.common.util.DateUtil;
import com.ds.common.util.JSONUtils;
import com.ds.common.util.LottoUtil;
import com.ds.entity.LotteryResult;
import com.ds.lottery.result.repository.LotteryResultRepository;
import com.ds.redis.api.RedisService;
import com.ds.redis.key.KeyConfig;

public class KenoThread_Bclc implements Runnable {
	private final Logger logger = LoggerFactory.getLogger(this.getClass());
	private RestTemplate restTemplate;

	private LotteryResultRepository lotteryResultInfoRepository;

	private String lock;

	private String url;

	private RedisService redisService;

	private Integer timeZone;

	public KenoThread_Bclc(LotteryResultRepository lotteryResultInfoRepository, RestTemplate restTemplate, String url, String lock, RedisService redisService, Integer timeZone) {
		this.lotteryResultInfoRepository = lotteryResultInfoRepository;
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
				url = MessageFormat.format(url, System.currentTimeMillis() + "");
				String str = restTemplate.getForObject(url, String.class);
				if (str == null) {
					logger.info("获取的开奖数据为空");
					return;
				}
				JSONArray array = JSONArray.parseArray(str);
				JSONObject jsonObject = array.getJSONObject(0);
				// 期数
				String term = jsonObject.getString("drawNbr");
				// 原始号码
				String originalNumber = jsonObject.getString("drawNbrs");
				originalNumber = originalNumber.replaceAll("^.*\\[", "").replaceAll("].*", "").replaceAll(" ", "");

				String drawDate = jsonObject.getString("drawDate");
				String drawTime = jsonObject.getString("drawTime");

				String s = drawDate + " " + drawTime;

				Date d = DateUtil.getDateByEngString(s);
				Date openTime = null;
				if (timeZone.intValue() == TimeZone.北京时间.getKey().intValue()) {
					openTime = DateUtils.addHours(d, 16);// 北京
				} 
				if (timeZone.intValue() == TimeZone.美东时间.getKey().intValue()) {
					openTime = DateUtils.addHours(d, 4);// 北京-12
				}

				Date closeTime = DateUtils.addSeconds(openTime, -30);

				Date dateB = DateUtils.addMinutes(new Date(), GameTypeTime.加拿大二八.getValue());
				if (openTime.getTime() < dateB.getTime() || openTime.getTime() > System.currentTimeMillis()) {
					logger.info("加拿大28官网2拉取{}期开奖数据开奖时间{}错误", term, openTime);
					return;
				}

				LotteryResult lotteryResult = lotteryResultInfoRepository.findByGameTypeAndTerm(GameType.加拿大二八.getKey(), Long.valueOf(term));
				if (null != lotteryResult) {
					logger.info("{}期的开奖数据已经存在", term);
					return;
				}

				LotteryResult entity = new LotteryResult();

				String resultStr = LottoUtil.getKenoNumberStrByNone(originalNumber);
				if (!StringUtils.isNumeric(resultStr)) {
					logger.info("加拿大28官网2获取开奖数据不为数字");
					return;
				}

				entity.setGameType(GameType.加拿大二八.getKey());
				entity.setTerm(Long.valueOf(term));
				entity.setCloseTime(closeTime);
				entity.setOpenTime(openTime);
				entity.setOriginalNum(resultStr);
				entity.setOpenUrl(url);
				entity.setLuckyNum(LottoUtil.getNumberSum(resultStr));
				entity.setCreateTime(new Date());

				lotteryResultInfoRepository.save(entity);
				logger.info("{}期的开奖数据插入成功", term);
				redisService.set(KeyConfig.KEY_LOTTERY + GameType.加拿大二八.getKey(), JSONUtils.bean2Json(lotteryResultInfoRepository.findLastest10ByGameType(GameType.加拿大二八.getKey())));

			} catch (Exception e) {
				logger.error("官网2拉取加拿大28开奖错误", e);
			}
		}

	}

}
