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
import com.ds.common.util.DateUtil;
import com.ds.common.util.JSONUtils;
import com.ds.common.util.LottoUtil;
import com.ds.entity.LotteryResult;
import com.ds.lottery.result.repository.LotteryResultRepository;
import com.ds.redis.api.RedisService;
import com.ds.redis.key.KeyConfig;

public class XjsscThread_Offical implements Runnable {

	private final Logger logger = LoggerFactory.getLogger(this.getClass());
	private RestTemplate restTemplate;

	private LotteryResultRepository lotteryResultInfoRepository;

	private String url;

	private String lock;
	
	private RedisService redisService;
	
	private Integer timeZone;

	public XjsscThread_Offical(LotteryResultRepository lotteryResultInfoRepository, RestTemplate restTemplate,
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
					logger.info("新疆福利彩票获取新疆时时彩开奖数据为空");
					return;
				}

				Document parse = Jsoup.parse(result);
				Element divElement = parse.getElementById("kj_code_tab");
				Elements tabElement = divElement.getElementsByTag("table");
				Element trElement = tabElement.select("tr").get(1);
				
				/**
				 * 
				 * <tr> 
					 <td class="bold">2017010510</td> 
					 <td class="kj_codes">1,5,6,0,3</td> 
					 <td> 小单 小双 组六</td> 
					</tr>					
				 * 
				 * 
				 */
				Element tdElementA = trElement.select("td").get(0);
				Element tdElementB = trElement.select("td").get(1);
				
				String termStr = tdElementA.html();
				String lotteryStr = tdElementB.html();

				if (StringUtils.isEmpty(lotteryStr)) {
					logger.info("新疆福利彩票获取新疆时时彩开奖数据为空");
					return;
				}
				
				if (!StringUtils.isNumeric(termStr)) {
					logger.info("新疆福利彩票获取新疆时时彩开奖数据(奖期)不为数字");
					return;
				}

				Integer dayterm = Integer.valueOf(StringUtils.substring(termStr, 8));
				
				String resultstr = LottoUtil.getXjAndCqNumberStrByNone(lotteryStr);

				if (!StringUtils.isNumeric(resultstr)) {
					logger.info("新疆福利彩票获取新疆时时彩开奖数据不为数字");
					return;
				}
				
				Date timeZoneDate = LottoUtil.getCqOpenTime(timeZone);
				if(null == timeZoneDate){
					logger.info("新疆福利彩票获取新疆时时彩初始奖期为空,当前时间{}",new Date());
					return;
				}
				Date openTime = DateUtils.addMinutes(timeZoneDate,dayterm*Integer.valueOf(LottoUtil.getMins(GameType.新疆二八.getKey(), timeZone)));
				
				Date closeTime = DateUtils.addSeconds(openTime, -30);

				Date dateB = DateUtils.addMinutes(new Date(), GameTypeTime.新疆二八.getValue());
				if (openTime.getTime() < dateB.getTime() || openTime.getTime() > System.currentTimeMillis()) {
					logger.info("新疆福利彩票拉取{}期开奖数据开奖时间{}错误", termStr, openTime);
					return;
				}

				Long term = Long.valueOf(termStr);
				
				LotteryResult firstLottery = lotteryResultInfoRepository.findFirstOneByGameType(GameType.新疆二八.getKey(),new Date());
				if(null != firstLottery){
					String calCloseTime = LottoUtil.getCloseDate(term, firstLottery.getTerm()+"", DateUtil.format(DateUtil.YY_MM_DD_HH_MM_SS, firstLottery.getOpenTime()), Float.valueOf(LottoUtil.getMins(GameType.新疆二八.getKey(), timeZone)));
					Date calCloseTimeD = DateUtil.parse(DateUtil.YY_MM_DD_HH_MM_SS, calCloseTime);
					logger.info("计算的封盘时间：{}",calCloseTimeD);
					logger.info("获取的封盘时间：{}",closeTime);
					if(calCloseTimeD.compareTo(closeTime) != 0 ){
						logger.info("计算的封盘时间{}和获取的封盘时间{}出现错误!",calCloseTimeD,closeTime);
						return;
					}
				}
				

				LotteryResult lotteryResult = lotteryResultInfoRepository.findByGameTypeAndTerm(GameType.新疆二八.getKey(),
						term);
				if (null != lotteryResult) {
					logger.info("{}期的开奖数据已经存在", term);
					return;
				}

				LotteryResult entity = new LotteryResult();

				entity.setGameType(GameType.新疆二八.getKey());
				entity.setTerm(term);
				entity.setCloseTime(closeTime);
				entity.setOpenTime(openTime);
				entity.setOriginalNum(resultstr);
				entity.setOpenUrl("http://www.xjflcp.com/");
				entity.setLuckyNum(LottoUtil.getNumberSum(resultstr));
				entity.setCreateTime(new Date());

				lotteryResultInfoRepository.save(entity);
				
				
				logger.info("{}期的开奖数据插入成功", term);
				redisService.set(KeyConfig.KEY_LOTTERY + GameType.新疆二八.getKey(), JSONUtils.bean2Json(lotteryResultInfoRepository.findLastest10ByGameType(GameType.新疆二八.getKey())));				
				
			} catch (Exception e) {
				logger.error("新疆福利彩票拉取" + GameType.新疆二八.getValue() + "开奖数据开奖错误", e);
			}
		}

	}

}
