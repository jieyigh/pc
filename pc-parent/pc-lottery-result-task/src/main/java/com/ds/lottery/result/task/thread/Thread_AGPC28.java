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
import com.ds.common.util.StringUtil;
import com.ds.entity.LotteryResult;
import com.ds.lottery.result.repository.LotteryResultRepository;
import com.ds.redis.api.RedisService;
import com.ds.redis.key.KeyConfig;

public class Thread_AGPC28 implements Runnable {

	private final Logger logger = LoggerFactory.getLogger(this.getClass());
	private RestTemplate restTemplate;

	private LotteryResultRepository lotteryResultInfoRepository;

	private String url;

	private String lock;
	
	private RedisService redisService;
	
	private Integer timeZone;
	
	private String gameType;

	public Thread_AGPC28(LotteryResultRepository lotteryResultInfoRepository, String gameType,RestTemplate restTemplate,
			String url, String lock,RedisService redisService,Integer timeZone) {
		this.lotteryResultInfoRepository = lotteryResultInfoRepository;
		this.restTemplate = restTemplate;
		this.url = url;
		this.lock = lock;
		this.redisService=redisService;
		this.timeZone=timeZone;
		this.gameType = gameType;
	}

	@Transactional
	@Override
	public void run() {
		synchronized (lock) {
			try {
				String result = restTemplate.getForObject(url, String.class);
				if (StringUtils.isEmpty(result)) {
					logger.info("AGPC28获取开奖数据为空");
					return;
				}

				Document parse = Jsoup.parse(result);
				Elements tableElement = parse.getElementsByTag("table");
				
				//1重庆时时彩  3幸运28 4加拿大28
				Integer i = 0;
				if(gameType.equals(GameType.加拿大二八.getKey())){
					i = 4;
				}
				if(gameType.equals(GameType.幸运二八.getKey())){
					i = 3;			
				}
				if(gameType.equals(GameType.重庆二八.getKey())){
					i = 1;
				}
				if(i==0){
					return;
				}
				
				Element trElement = tableElement.select("tr").get(i);
				
				Element tdElementA = trElement.select("td").get(1);
				Element tdElementB = trElement.select("td").get(2);
				Element tdElementC = trElement.select("td").get(3);
				String termStr = tdElementA.html(); //20170218-056
				String time  = tdElementB.html();
				String lotteryStr = tdElementC.html(); //<b>3</b> <b>6</b> <b>3</b> <b>6</b> <b>3</b>

				if (StringUtils.isEmpty(lotteryStr)) {
					logger.info("AGPC28获取PC开奖数据为空");
					return;
				}
				
				String resultstr = LottoUtil.getNumberStr(lotteryStr);

				if (!StringUtils.isNumeric(resultstr)) {
					logger.info("AGPC28获取PC开奖数据不为数字");
					return;
				}

				Date openTime = DateUtil.parse(DateUtil.YY_MM_DD_HH_MM, time);
				
				if (timeZone.intValue() == TimeZone.美东时间.getKey().intValue()) {
					//美东时间
					openTime = DateUtils.addHours(openTime, -12);
				}
				
				Date closeTime = DateUtils.addSeconds(openTime, -30);

				Date dateB = DateUtils.addMinutes(new Date(), GameTypeTime.getValue(gameType).getValue());
				if (openTime.getTime() < dateB.getTime() || openTime.getTime() > System.currentTimeMillis()) {
					logger.info("AGPC28拉取{}期开奖数据开奖时间{}错误", termStr, openTime);
					return;
				}

				Long term = Long.valueOf(StringUtil.getNumeric(termStr));
				
				LotteryResult lotteryResult = lotteryResultInfoRepository.findByGameTypeAndTerm(gameType,term);
				if (null != lotteryResult) {
					logger.info("{}期的开奖数据已经存在", term);
					return;
				}

				LotteryResult entity = new LotteryResult();

				entity.setGameType(gameType);
				entity.setTerm(term);
				entity.setCloseTime(closeTime);
				entity.setOpenTime(openTime);
				entity.setOriginalNum(resultstr);
				entity.setOpenUrl(url);
				entity.setLuckyNum(LottoUtil.getNumberSum(resultstr));
				entity.setCreateTime(new Date());
				
				lotteryResultInfoRepository.save(entity);
				logger.info("{}期的开奖数据插入成功", term);
				redisService.set(KeyConfig.KEY_LOTTERY + gameType, JSONUtils.bean2Json(lotteryResultInfoRepository.findLastest10ByGameType(gameType)));				
				
			} catch (Exception e) {
				logger.error("AGPC28拉取" + gameType + "开奖网站出现异常", e);
			}
		}

	}

}
