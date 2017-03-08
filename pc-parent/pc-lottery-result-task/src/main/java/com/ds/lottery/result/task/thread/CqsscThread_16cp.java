package com.ds.lottery.result.task.thread;

import java.util.Calendar;
import java.util.Date;

import javax.transaction.Transactional;

import org.apache.commons.lang.StringUtils;
import org.apache.commons.lang.time.DateUtils;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.client.RestTemplate;

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

public class CqsscThread_16cp implements Runnable {

	private final Logger logger = LoggerFactory.getLogger(this.getClass());
	
	
	private RestTemplate restTemplate;

	private LotteryResultRepository lotteryResultInfoRepository;

	private String url;

	private String lock;
	
	private RedisService redisService;
	
	private Integer timeZone;

	public CqsscThread_16cp(LotteryResultRepository lotteryResultInfoRepository, RestTemplate restTemplate,
			String url, String lock,RedisService redisService,Integer timeZone) {
		this.lotteryResultInfoRepository = lotteryResultInfoRepository;
		this.restTemplate = restTemplate;
		this.url = url;
		this.lock = lock;
		this.redisService=redisService;
		this.timeZone=timeZone;
	}

	@Transactional
	@Override
	public void run() {
		synchronized (lock) {
			try {
				String result = restTemplate.getForObject(url, String.class);
				
				//<ul class='openul bgF0F9FE'><li class='openli1'>170102052</li><li class='openli2'>4,6,5,1,8</li><li class='openli3'>01-02 14:40</li></ul><ul class='openul'><li class='openli1'>170102051</li><li class='openli2'>6,0,2,5,0</li><li class='openli3'>01-02 14:30</li></ul><ul class='openul bgF0F9FE'><li class='openli1'>170102050</li><li class='openli2'>3,5,7,3,1</li><li class='openli3'>01-02 14:20</li></ul><ul class='openul'><li class='openli1'>170102049</li><li class='openli2'>1,0,1,8,9</li><li class='openli3'>01-02 14:10</li></ul><ul class='openul bgF0F9FE'><li class='openli1'>170102048</li><li class='openli2'>3,6,7,8,1</li><li class='openli3'>01-02 14:00</li></ul><ul class='openul'><li class='openli1'>170102047</li><li class='openli2'>2,4,2,3,0</li><li class='openli3'>01-02 13:50</li></ul>
				if (StringUtils.isEmpty(result)) {
					logger.info("重庆福利彩票获取重庆时时彩开奖数据为空");
					return;
				}

				Document parse = Jsoup.parse(result);
				Element ulElement = parse.select("ul").get(0);
				/*
				 * <ul class="openul bgF0F9FE">
					 <li class="openli1">170102053</li>
					 <li class="openli2">5,1,0,4,8</li>
					 <li class="openli3">01-02 14:50</li>
					</ul>
				 */
				Element liElementA = ulElement.select("li").get(0);
				Element liElementB = ulElement.select("li").get(1);
				Element liElementC = ulElement.select("li").get(2);
				
				Calendar c = Calendar.getInstance();
				int year = c.get(Calendar.YEAR);
				
				String termStr = 20+liElementA.html();
				String lotteryStr = liElementB.html();
				String time = year+"-"+liElementC.html();

				if (StringUtils.isEmpty(lotteryStr)) {
					logger.info("重庆福利彩票获取重庆时时彩开奖数据为空");
					return;
				}

				
				String resultstr = LottoUtil.getXjAndCqNumberStrByNone(lotteryStr);

				if (!StringUtils.isNumeric(resultstr)) {
					logger.info("重庆福利彩票获取重庆时时彩开奖数据不为数字");
					return;
				}

				Date openTime = DateUtil.parse(DateUtil.YY_MM_DD_HH_MM, time);
				
				if (timeZone.intValue() == TimeZone.美东时间.getKey().intValue()) {
					//北京时间-12
					openTime = DateUtils.addHours(openTime, -12);
				}
				
				
				Date closeTime = DateUtils.addSeconds(openTime, -30);

				Date dateB = DateUtils.addMinutes(new Date(), GameTypeTime.重庆二八.getValue());
				if (openTime.getTime() < dateB.getTime() || openTime.getTime() > System.currentTimeMillis()) {
					logger.info("重庆福利彩票拉取{}期开奖数据开奖时间{}错误", termStr, openTime);
					return;
				}

				Long term = Long.valueOf(termStr);
				
				LotteryResult firstLottery = lotteryResultInfoRepository.findFirstOneByGameType(GameType.重庆二八.getKey(),new Date());
				if(null != firstLottery){
					String calCloseTime = LottoUtil.getCloseDate(term, firstLottery.getTerm()+"", DateUtil.format(DateUtil.YY_MM_DD_HH_MM_SS, firstLottery.getOpenTime()), Float.valueOf(LottoUtil.getMins(GameType.重庆二八.getKey(), timeZone)));
					Date calCloseTimeD = DateUtil.parse(DateUtil.YY_MM_DD_HH_MM_SS, calCloseTime);
					logger.info("计算的封盘时间：{}",calCloseTimeD);
					logger.info("获取的封盘时间：{},奖期：{},ID：{}",closeTime,term,firstLottery.getId());
					if(calCloseTimeD.compareTo(closeTime) != 0 ){
						logger.info("计算的封盘时间{}和获取的封盘时间{}出现错误!",calCloseTimeD,closeTime);
						return;
					}
				}

				LotteryResult lotteryResult = lotteryResultInfoRepository.findByGameTypeAndTerm(GameType.重庆二八.getKey(),
						term);
				if (null != lotteryResult) {
					logger.info("{}期的开奖数据已经存在", term);
					return;
				}

				LotteryResult entity = new LotteryResult();

				entity.setGameType(GameType.重庆二八.getKey());
				entity.setTerm(term);
				entity.setCloseTime(closeTime);
				entity.setOpenTime(openTime);
				entity.setOriginalNum(resultstr);
				entity.setOpenUrl(url);
				entity.setLuckyNum(LottoUtil.getNumberSum(resultstr));
				entity.setCreateTime(new Date());
				
				lotteryResultInfoRepository.save(entity);
				
				
				logger.info("{}期的开奖数据插入成功", term);
				redisService.set(KeyConfig.KEY_LOTTERY + GameType.重庆二八.getKey(), JSONUtils.bean2Json(lotteryResultInfoRepository.findLastest10ByGameType(GameType.重庆二八.getKey())));				
				
			} catch (Exception e) {
				logger.error("重庆福利彩票拉取" + GameType.重庆二八.getValue() + "开奖数据开奖错误", e);
			}
		}

	}

}
