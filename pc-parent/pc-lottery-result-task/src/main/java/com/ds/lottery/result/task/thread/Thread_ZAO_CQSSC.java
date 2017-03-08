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
import com.ds.common.constants.Constants.GameTypeTime;
import com.ds.common.constants.Constants.GameTypeToZAO;
import com.ds.common.constants.Constants.TimeZone;
import com.ds.common.util.DateUtil;
import com.ds.common.util.JSONUtils;
import com.ds.common.util.LottoUtil;
import com.ds.common.util.StringUtil;
import com.ds.entity.LotteryResult;
import com.ds.lottery.result.repository.LotteryResultRepository;
import com.ds.redis.api.RedisService;
import com.ds.redis.key.KeyConfig;

public class Thread_ZAO_CQSSC implements Runnable {
	private final Logger logger = LoggerFactory.getLogger(this.getClass());
	private RestTemplate restTemplate;

	private LotteryResultRepository lotteryResultInfoRepository;
	private String gameType;

	private String lock;

	private String url;

	private RedisService redisService;

	private Integer timeZone;

	public Thread_ZAO_CQSSC(LotteryResultRepository lotteryResultInfoRepository, String gameType, RestTemplate restTemplate, String url, String lock, RedisService redisService, Integer timeZone) {
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
				url = MessageFormat.format(url, GameTypeToZAO.重庆时时彩.getKey());
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
				      "issue": "20170120-053",
				      "kjcode": "5,4,5,0,9",
				      "time": "2017-01-20 14:50:00"
				    }
				 */
				
				String term = last.getString("issue");
				String kjcode = last.getString("kjcode");
				String time = last.getString("time");		

				kjcode = StringUtil.getNumeric(kjcode);
				term = StringUtil.getNumeric(term);
				
				String resultStr = LottoUtil.getNumberStrByNone(kjcode, gameType);
				if (!StringUtils.isNumeric(resultStr)) {
					logger.info("ZAO获取开奖数据不为数字");
					return;
				}
				
				String webAddress = "https://api.zao28.com/News?name=cqssc&type=json";
				

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
				
				LotteryResult firstLottery = lotteryResultInfoRepository.findFirstOneByGameType(gameType,new Date());
				if(null != firstLottery){
					String calCloseTime = LottoUtil.getCloseDate(Long.valueOf(term), firstLottery.getTerm()+"", 
							DateUtil.format(DateUtil.YY_MM_DD_HH_MM_SS, firstLottery.getOpenTime()), Float.valueOf(LottoUtil.getMins(gameType, timeZone)));
					Date calCloseTimeD = DateUtil.parse(DateUtil.YY_MM_DD_HH_MM_SS, calCloseTime);
					logger.info("计算的封盘时间：{}",calCloseTimeD);
					logger.info("获取的封盘时间：{},奖期：{},ID：{}",closeTime,term,firstLottery.getId());
					if(calCloseTimeD.compareTo(closeTime) != 0 ){
						logger.info("计算的封盘时间{}和获取的封盘时间{}出现错误!",calCloseTimeD,closeTime);
						return;
					}
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
				entity.setOpenUrl(webAddress);
				entity.setLuckyNum(LottoUtil.getNumberSum(resultStr));
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
