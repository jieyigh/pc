package com.ds.lottery.result.task.thread;

import java.text.MessageFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.transaction.Transactional;

import org.apache.commons.lang.StringUtils;
import org.apache.commons.lang.time.DateUtils;
import org.dom4j.Attribute;
import org.dom4j.Document;
import org.dom4j.Element;
import org.dom4j.io.SAXReader;
import org.jsoup.Jsoup;
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

public class Thread_KJ500 implements Runnable {

	private final Logger logger = LoggerFactory.getLogger(this.getClass());
	private RestTemplate restTemplate;

	private LotteryResultRepository lotteryResultInfoRepository;

	private String url;

	private String lock;
	
	private RedisService redisService;
	
	private Integer timeZone;
	
	private String gameType;

	public Thread_KJ500(LotteryResultRepository lotteryResultInfoRepository, String gameType,RestTemplate restTemplate,
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
			SAXReader reader = new SAXReader();
			Date now = new Date();
			if (timeZone.intValue() == TimeZone.美东时间.getKey().intValue()) {
				now = DateUtils.addHours(now, 12);
			}
			
			String xml = DateUtil.format(DateUtil.YYMMDD, now);
			try {
				url = MessageFormat.format(url, xml);
				Document document = reader.read(url);
				Element rows = document.getRootElement();
				Iterator it = rows.elementIterator();
				
				Map<String,String> map = new HashMap<>();
				
				while (it.hasNext()) {
					Element row = (Element) it.next();
					List<Attribute> rowAttrs = row.attributes();
			        for (Attribute attr : rowAttrs) {
			        	String key = attr.getName();
			        	String value = attr.getValue();
			        	map.put(key, value);
					}
			        break;
				}
				
				if (map.isEmpty()) {
					logger.info("KJ500获取新疆28开奖数据为空");
					return;
				}
				
				String termStr = map.get("expect");//20170222044
				String time  = map.get("opentime");
				String lotteryStr = map.get("opencode");

				if (StringUtils.isEmpty(lotteryStr)) {
					logger.info("KJ500获取新疆28开奖数据为空");
					return;
				}
				
				String resultstr = LottoUtil.getNumberStr(lotteryStr);

				if (!StringUtils.isNumeric(resultstr)) {
					logger.info("KJ500获取新疆28开奖数据不为数字");
					return;
				}

				Date openTime = DateUtil.parse(DateUtil.YY_MM_DD_HH_MM_SS, time);
				
				if (timeZone.intValue() == TimeZone.美东时间.getKey().intValue()) {
					//美东时间
					openTime = DateUtils.addHours(openTime, -12);
				}
				
				Date closeTime = DateUtils.addSeconds(openTime, -30);

				Date dateB = DateUtils.addMinutes(new Date(), GameTypeTime.getValue(gameType).getValue());
				if (openTime.getTime() < dateB.getTime() || openTime.getTime() > System.currentTimeMillis()) {
					logger.info("KJ500拉取{}期开奖数据开奖时间{}错误", termStr, openTime);
					return;
				}

				int len = termStr.length();
				termStr = termStr.substring(0, 8)+termStr.substring(len-2,len);
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
				redisService.set(KeyConfig.KEY_LOTTERY + gameType, JSONUtils.bean2Json(lotteryResultInfoRepository.findLastest10ByGameType(GameType.新疆二八.getKey())));
				
			} catch (Exception e) {
				logger.error("KJ500拉取" + GameType.新疆二八.getValue() + "开奖网站出现异常", e);
			}
		}

	}

}
