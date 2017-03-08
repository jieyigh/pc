package com.ds.lottery.result.task.thread;

import java.text.MessageFormat;
import java.util.Date;

import javax.transaction.Transactional;

import org.apache.commons.lang.time.DateUtils;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.client.RestTemplate;

import com.ds.common.constants.Constants.GameType;
import com.ds.common.constants.Constants.GameTypeToPC588;
import com.ds.common.constants.Constants.TimeZone;
import com.ds.common.util.DateUtil;
import com.ds.common.util.JSONUtils;
import com.ds.common.util.StringUtil;
import com.ds.entity.LotteryResult;
import com.ds.lottery.result.repository.LotteryResultRepository;
import com.ds.redis.api.RedisService;
import com.ds.redis.key.KeyConfig;

public class Thread_PC588 implements Runnable {

	private final Logger logger = LoggerFactory.getLogger(this.getClass());
	private RestTemplate restTemplate;

	private LotteryResultRepository lotteryResultInfoRepository;
	private String gameType;

	private String lock;

	private String url;
	
	private RedisService redisService;
	
	private Integer timeZone;

	public Thread_PC588(LotteryResultRepository lotteryResultInfoRepository, String gameType, RestTemplate restTemplate,
			String url, String lock,RedisService redisService,Integer timeZone) {
		this.lotteryResultInfoRepository = lotteryResultInfoRepository;
		this.gameType = gameType;
		this.restTemplate = restTemplate;
		this.lock = lock;
		this.url = url;
		this.redisService=redisService;
		this.timeZone = timeZone;
	}

	@Transactional
	@Override
	public void run() {

		synchronized (lock) {
			try {
				
				if (gameType.equals(GameType.加拿大二八.getKey())) {
					url = MessageFormat.format(url, GameTypeToPC588.加拿大二八.getKey());
				} else {
					url = MessageFormat.format(url, GameTypeToPC588.幸运二八.getKey());
				}
				
				String result = restTemplate.getForObject(url, String.class);
				if (result == null) {
					logger.info("获取的开奖数据为空");
					return;
				}
				Document parse = Jsoup.parse(result);
				Elements ulElement = parse.getElementsByTag("ul");
				Element liElement = ulElement.select("li").get(1);
				// <li
				// class="kj_white_line">2066358æ&nbsp;&nbsp;[14:20:00]&nbsp;&nbsp;<b>5+6+4
				// = <span style="color:red">15</span></b></li>
				Elements bs = liElement.select("b");// <b>1+1+4 = <span
													// style="color:red">06</span></b>
				String b = bs.text(); // 1+1+4 = 06
				String sum = bs.select("span").text(); // 06
				String html = liElement.text();// 2066369æ  [14:58:30]  1+5+3
												// = 09

				String[] resultNs = b.split("=");
				String resultN = resultNs[0];
				resultN = StringUtil.getNumeric(resultN);

				String term = html.substring(0, html.indexOf("["));
				term = StringUtil.getNumeric(term);
				String time = html.substring(html.indexOf("[") + 1, html.indexOf("]"));

				Date openTime = DateUtil.parse(gameType.equals(GameType.幸运二八.getKey())?DateUtil.YY_MM_DD_HH_MM:DateUtil.YY_MM_DD_HH_MM_SS,
						DateUtil.format(DateUtil.YY_MM_DD, new Date()) + " " + time);
				
				if (timeZone.intValue() == TimeZone.美东时间.getKey().intValue()) {
					//美东时间
					openTime = DateUtils.addHours(openTime, -12);
				}
				
				Date closeTime = DateUtils.addSeconds(openTime, -30);

				Date dateB = DateUtils.addMinutes(new Date(), gameType.equals(GameType.幸运二八.getKey())?-10:-7);
				if (openTime.getTime() < dateB.getTime() || openTime.getTime() > System.currentTimeMillis()) {
					logger.info("PC588拉取{},{}开奖数据开奖时间{}错误", gameType, term, openTime);
					return;
				}

				LotteryResult lotteryResult = lotteryResultInfoRepository.findByGameTypeAndTerm(gameType,
						Long.valueOf(term));
				if (null != lotteryResult) {
					logger.info("{}期的开奖数据已经存在", term);
					return;
				}

				LotteryResult entity = new LotteryResult();

				entity.setGameType(gameType);
				entity.setTerm(Long.valueOf(term));
				entity.setCloseTime(closeTime);
				entity.setOpenTime(openTime);
				entity.setOriginalNum(resultN);
				entity.setOpenUrl("http://pc588.com");
				entity.setLuckyNum(Integer.valueOf(sum));
				entity.setCreateTime(new Date());

				
				lotteryResultInfoRepository.save(entity);
				logger.info("{},{}期的开奖数据插入成功", gameType, term);

				redisService.set(KeyConfig.KEY_LOTTERY + gameType, JSONUtils.bean2Json(lotteryResultInfoRepository.findLastest10ByGameType(gameType)));				
				
			} catch (Exception e) {
				logger.error("PC588拉取" + gameType + "开奖数据开奖错误", e);
			}
		}

	}

}
