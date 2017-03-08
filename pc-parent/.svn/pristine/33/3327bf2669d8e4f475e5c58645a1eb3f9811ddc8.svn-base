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
import com.ds.common.util.DateUtil;
import com.ds.common.util.JSONUtils;
import com.ds.common.util.LottoUtil;
import com.ds.entity.LotteryResult;
import com.ds.lottery.result.repository.LotteryResultRepository;
import com.ds.redis.api.RedisService;
import com.ds.redis.key.KeyConfig;

public class LuckyThread_360 implements Runnable {
	private final Logger logger = LoggerFactory.getLogger(this.getClass());
	private RestTemplate restTemplate;

	private LotteryResultRepository lotteryResultInfoRepository;

	private String lock;

	private String url;

	private RedisService redisService;

	private Integer timeZone;

	public LuckyThread_360(LotteryResultRepository lotteryResultInfoRepository, RestTemplate restTemplate, String url, String lock, RedisService redisService, Integer timeZone) {
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
				
				
				LotteryResult firstlottery = lotteryResultInfoRepository.findFirstOneByGameType(GameType.幸运二八.getKey(),new Date());
				
				if(null == firstlottery){
					logger.info("获取当天幸运28初始开奖数据为空");
					return;
				}

				logger.info("id:{},openTime:{}",firstlottery.getId(),firstlottery.getOpenTime());
				

				LotteryResult lastest = lotteryResultInfoRepository.findLastestOneByGameType(GameType.幸运二八.getKey());
				if (lastest == null) {
					logger.info("获取幸运28参考开奖数据为空");
					return;
				}

				Long term = lastest.getTerm() + 1;
				url = MessageFormat.format(url, term + "", System.currentTimeMillis() + "");
				String jsons = restTemplate.getForObject(url, String.class);
				if (StringUtils.isEmpty(jsons)) {
					logger.info("360彩票{}期获取幸运28开奖数据为空", term + "");
					return;
				}
				JSONArray array = (JSONArray) JSONArray.parse(jsons);
				JSONObject jsonObject = (JSONObject) array.get(0);
				String lotteryNumberStr = jsonObject.getString("code");
				if (StringUtils.isEmpty(lotteryNumberStr)) {
					logger.info("360彩票{}期解析幸运28开奖数据为空", term + "");
					return;
				}
				String Str = lotteryNumberStr.substring(0, lotteryNumberStr.length() - 3);
				Str = Str.replace(" ", ",");

				Date closeTime = DateUtil.parse(DateUtil.YY_MM_DD_HH_MM_SS
						, LottoUtil.getCloseDate(term, firstlottery.getTerm()+"", DateUtil.format(DateUtil.YY_MM_DD_HH_MM_SS, firstlottery.getOpenTime()), Float.valueOf(LottoUtil.getMins(GameType.幸运二八.getKey(), timeZone))));

				Date openTime = DateUtils.addSeconds(closeTime, 30);

				Date dateB = DateUtils.addMinutes(new Date(), GameTypeTime.幸运二八.getValue());
				if (openTime.getTime() < dateB.getTime() || openTime.getTime() > System.currentTimeMillis()) {
					logger.info("360拉取{}期开奖数据开奖时间{}错误", term, openTime);
					return;
				}

				LotteryResult lotteryResult = lotteryResultInfoRepository.findByGameTypeAndTerm(GameType.幸运二八.getKey(), term);
				if (null != lotteryResult) {
					logger.info("{}期的开奖数据已经存在", term);
					return;
				}

				LotteryResult entity = new LotteryResult();

				String resultStr = LottoUtil.getLuckyNumberStrByNone(Str);
				if (!StringUtils.isNumeric(resultStr)) {
					logger.info("360彩票获取幸运28开奖数据不为数字");
					return;
				}

				entity.setGameType(GameType.幸运二八.getKey());
				entity.setTerm(term);
				entity.setCloseTime(closeTime);
				entity.setOpenTime(openTime);
				entity.setOriginalNum(resultStr);
				entity.setOpenUrl(url);
				entity.setLuckyNum(LottoUtil.getNumberSum(resultStr));
				entity.setCreateTime(new Date());

				lotteryResultInfoRepository.save(entity);
				logger.info("{}期的开奖数据插入成功", term);
				redisService.set(KeyConfig.KEY_LOTTERY + GameType.幸运二八.getKey(), JSONUtils.bean2Json(lotteryResultInfoRepository.findLastest10ByGameType(GameType.幸运二八.getKey())));

			} catch (Exception e) {
				logger.error("360彩票拉取" + GameType.幸运二八.getValue() + "开奖数据开奖错误", e);
			}
		}

	}

}
