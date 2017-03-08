package com.ds.lottery.result.task.thread;

import java.util.Date;

import javax.transaction.Transactional;

import org.apache.commons.lang.StringUtils;
import org.apache.commons.lang.time.DateUtils;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;
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

public class LuckyThread_BeijingWelfare implements Runnable {

	private final Logger logger = LoggerFactory.getLogger(this.getClass());
	private RestTemplate restTemplate;

	private LotteryResultRepository lotteryResultInfoRepository;

	private String url;

	private String lock;
	
	private RedisService redisService;
	
	private Integer timeZone;

	public LuckyThread_BeijingWelfare(LotteryResultRepository lotteryResultInfoRepository, RestTemplate restTemplate,
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
				if (StringUtils.isEmpty(result)) {
					logger.info("北京福利彩票获取幸运28开奖数据为空");
					return;
				}

				Document parse = Jsoup.parse(result);
				Elements tableElement = parse.getElementsByTag("table");
				Element trElement = tableElement.select("tr").get(2);
				/**
				 * <tr class="">
				 * <td>779128</td>
				 * <td>61,52,06,41,59,72,27,53,47,76,32,54,42,79,26,45,38,70
				 * ,58,10</td>
				 * <td>01</td>
				 * <td>2016-09-03 10:35</td>
				 * </tr>
				 */
				Element tdElementA = trElement.select("td").get(0);
				Element tdElementB = trElement.select("td").get(1);
				Element tdElementC = trElement.select("td").get(3);
				String termStr = tdElementA.html();
				String lotteryStr = tdElementB.html();
				String time = tdElementC.html();

				if (StringUtils.isEmpty(lotteryStr)) {
					logger.info("北京福利彩票获取幸运28开奖数据为空");
					return;
				}

				// 将开奖号码转换成数组，计算得到结果
				String[] strarr = lotteryStr.split(",");
				int[] arr = new int[strarr.length];
				for (int i = 0; i < strarr.length; i++) {
					arr[i] = Integer.parseInt(strarr[i]);
				}
				String resultstr = LottoUtil.getNumber(arr);

				if (!StringUtils.isNumeric(resultstr)) {
					logger.info("北京福利彩票获取幸运28开奖数据不为数字");
					return;
				}

				Date openTime = DateUtil.parse(DateUtil.YY_MM_DD_HH_MM, time);
				
				if (timeZone.intValue() == TimeZone.美东时间.getKey().intValue()) {
					//美东时间
					openTime = DateUtils.addHours(openTime, -12);
				}
				
				Date closeTime = DateUtils.addSeconds(openTime, -30);

				Date dateB = DateUtils.addMinutes(new Date(), GameTypeTime.幸运二八.getValue());
				if (openTime.getTime() < dateB.getTime() || openTime.getTime() > System.currentTimeMillis()) {
					logger.info("北京福利彩票拉取{}期开奖数据开奖时间{}错误", termStr, openTime);
					return;
				}

				Long term = Long.valueOf(termStr);
				
				
				LotteryResult firstLottery = lotteryResultInfoRepository.findFirstOneByGameType(GameType.幸运二八.getKey(),new Date());
				if(null != firstLottery){
					String calCloseTime = LottoUtil.getCloseDate(term, firstLottery.getTerm()+"", DateUtil.format(DateUtil.YY_MM_DD_HH_MM_SS, firstLottery.getOpenTime()), Float.valueOf(LottoUtil.getMins(GameType.幸运二八.getKey(), timeZone)));
					Date calCloseTimeD = DateUtil.parse(DateUtil.YY_MM_DD_HH_MM_SS, calCloseTime);
					logger.info("计算的封盘时间：{}",calCloseTimeD);
					logger.info("获取的封盘时间：{}",closeTime);
					if(calCloseTimeD.compareTo(closeTime) != 0 ){
						logger.info("计算的封盘时间{}和获取的封盘时间{}出现错误!",calCloseTimeD,closeTime);
						return;
					}
				}
				
				LotteryResult lotteryResult = lotteryResultInfoRepository.findByGameTypeAndTerm(GameType.幸运二八.getKey(),
						term);
				if (null != lotteryResult) {
					logger.info("{}期的开奖数据已经存在", term);
					return;
				}

				LotteryResult entity = new LotteryResult();

				entity.setGameType(GameType.幸运二八.getKey());
				entity.setTerm(term);
				entity.setCloseTime(closeTime);
				entity.setOpenTime(openTime);
				entity.setOriginalNum(resultstr);
				entity.setOpenUrl(url);
				entity.setLuckyNum(LottoUtil.getNumberSum(resultstr));
				entity.setCreateTime(new Date());
				
				lotteryResultInfoRepository.save(entity);
				logger.info("{}期的开奖数据插入成功", term);
				redisService.set(KeyConfig.KEY_LOTTERY + GameType.幸运二八.getKey(), JSONUtils.bean2Json(lotteryResultInfoRepository.findLastest10ByGameType(GameType.幸运二八.getKey())));				
				
			} catch (Exception e) {
				logger.error("北京福利彩票拉取" + GameType.幸运二八.getValue() + "开奖网站出现异常", e);
			}
		}

	}

}
