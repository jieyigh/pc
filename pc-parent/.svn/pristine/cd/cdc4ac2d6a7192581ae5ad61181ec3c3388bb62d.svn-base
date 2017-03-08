package com.ds.lottery.result.task.job;

import java.util.concurrent.ExecutorService;
import java.util.concurrent.LinkedBlockingQueue;
import java.util.concurrent.ThreadPoolExecutor;
import java.util.concurrent.TimeUnit;

import javax.transaction.Transactional;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.scheduling.annotation.EnableScheduling;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;
import org.springframework.web.client.RestTemplate;

import com.ds.common.constants.Constants.GameType;
import com.ds.lottery.result.config.RestTemplateConfig;
import com.ds.lottery.result.repository.LotteryResultRepository;
import com.ds.lottery.result.task.thread.CqsscThread_16cp;
import com.ds.lottery.result.task.thread.KenoThread_Bclc;
import com.ds.lottery.result.task.thread.KenoThread_Offical;
import com.ds.lottery.result.task.thread.LuckyThread_360;
import com.ds.lottery.result.task.thread.LuckyThread_BeijingWelfare;
import com.ds.lottery.result.task.thread.Thread_168;
import com.ds.lottery.result.task.thread.Thread_AG;
import com.ds.lottery.result.task.thread.Thread_AGPC28;
import com.ds.lottery.result.task.thread.Thread_CQShiCai;
import com.ds.lottery.result.task.thread.Thread_KJ500;
import com.ds.lottery.result.task.thread.Thread_ZAO;
import com.ds.lottery.result.task.thread.Thread_ZAO_CQSSC;
import com.ds.lottery.result.task.thread.XjsscThread_Offical;
import com.ds.redis.api.RedisService;

@Component
@EnableScheduling
public class GetLotteryResultTask {

	private final Logger logger = LoggerFactory.getLogger(this.getClass());

	private boolean processing = false;

	@Value("${beijing.welfare.lottery}")
	private String beijing_welfare;

	@Value("${keno.offical.lottery}")
	private String keno_offical;

	@Value("${ourself.server.lottery}")
	private String ourself_server;

	@Value("${lucky360.lottery}")
	private String lucky360;

	@Value("${kai168.lottery}")
	private String kai168;

	@Value("${pc588.lottery}")
	private String pc588;

	@Value("${ag.lottery}")
	private String ag;
	
	
	@Value("${agpc28.lottery}")
	private String agpc28;
	
	
	@Value("${cp16.lottery}")
	private String cp16;
	
	@Value("${xjssc.lottery}")
	private String xjssc;
	
	@Value("${zao.lottery}")
	private String zao;
	
	@Value("${kai168new.lottery}")
	private String kai168new;

	@Value("${kj500.lottery}")
	private String kj500;
	
	//kenobclc
	@Value("${kenobclc.lottery}")
	private String kenobclc;
	
	@Value("${time.zone}")
	private Integer timeZone;

	@Autowired
	private LotteryResultRepository lotteryResultInfoRepository;

	@Autowired
	private RedisService redisService;

	private ExecutorService executor_keno = new ThreadPoolExecutor(6, 6, 0L, TimeUnit.MILLISECONDS, new LinkedBlockingQueue<Runnable>());

	private ExecutorService executor_lucky = new ThreadPoolExecutor(6, 6, 0L, TimeUnit.MILLISECONDS, new LinkedBlockingQueue<Runnable>());
	
	private ExecutorService executor_cq = new ThreadPoolExecutor(5, 5, 0L, TimeUnit.MILLISECONDS, new LinkedBlockingQueue<Runnable>());
	
	private ExecutorService executor_xj = new ThreadPoolExecutor(5, 5, 0L, TimeUnit.MILLISECONDS, new LinkedBlockingQueue<Runnable>());

	/**
	 * 每10秒执行一次
	 */
	@Transactional
	@Scheduled(fixedDelay = 10 * 1000)
	public void getLotteryResult() {
		logger.info("拉取幸运28，加拿大28，重庆28，新疆28数据");
		try {
			if (!processing) {
				processing = true;
				RestTemplate restTemplate = RestTemplateConfig.restTemplate(RestTemplateConfig.simpleClientHttpRequestFactory());
				
				String kenolock = new String("kenolock");
				executor_keno.submit(new KenoThread_Bclc(lotteryResultInfoRepository, restTemplate, kenobclc, kenolock, redisService, timeZone));
				executor_keno.submit(new Thread_ZAO(lotteryResultInfoRepository, GameType.加拿大二八.getKey(), restTemplate, zao, kenolock, redisService, timeZone));
				executor_keno.submit(new KenoThread_Offical(lotteryResultInfoRepository, restTemplate, keno_offical, kenolock, redisService, timeZone));
				executor_keno.submit(new Thread_AG(lotteryResultInfoRepository, GameType.加拿大二八.getKey(), restTemplate, ag, kenolock, redisService, timeZone));
				executor_keno.submit(new Thread_AGPC28(lotteryResultInfoRepository, GameType.加拿大二八.getKey(),restTemplate, agpc28, kenolock, redisService, timeZone));

				String luckylock = new String("luckylock");
				executor_lucky.submit(new LuckyThread_360(lotteryResultInfoRepository, restTemplate, lucky360, luckylock, redisService, timeZone));
				executor_lucky.submit(new LuckyThread_BeijingWelfare(lotteryResultInfoRepository, restTemplate, beijing_welfare, luckylock, redisService, timeZone));
				executor_lucky.submit(new Thread_AG(lotteryResultInfoRepository, GameType.幸运二八.getKey(), restTemplate, ag, luckylock, redisService, timeZone));
				executor_lucky.submit(new Thread_ZAO(lotteryResultInfoRepository, GameType.幸运二八.getKey(), restTemplate, zao, luckylock, redisService, timeZone));
				executor_lucky.submit(new Thread_AGPC28(lotteryResultInfoRepository, GameType.幸运二八.getKey(),restTemplate, agpc28, luckylock, redisService, timeZone));
			
				String cqlock = new String("cqlock");
				executor_cq.submit(new Thread_CQShiCai(lotteryResultInfoRepository, GameType.重庆二八.getKey(),restTemplate, kai168new, cqlock, redisService, timeZone));
				executor_cq.submit(new CqsscThread_16cp(lotteryResultInfoRepository, restTemplate, cp16, cqlock, redisService, timeZone));
				executor_cq.submit(new Thread_ZAO_CQSSC(lotteryResultInfoRepository, GameType.重庆二八.getKey(), restTemplate, zao, cqlock, redisService, timeZone));
				executor_cq.submit(new Thread_AGPC28(lotteryResultInfoRepository, GameType.重庆二八.getKey(),restTemplate, agpc28, cqlock, redisService, timeZone));
				
				String xjlock = new String("xjlock");
				executor_xj.submit(new Thread_CQShiCai(lotteryResultInfoRepository, GameType.新疆二八.getKey(),restTemplate, kai168new, xjlock, redisService, timeZone));
				executor_xj.submit(new XjsscThread_Offical(lotteryResultInfoRepository, restTemplate, xjssc, xjlock, redisService, timeZone));
				executor_xj.submit(new Thread_168(lotteryResultInfoRepository, GameType.新疆二八.getKey(),restTemplate, kai168, xjlock, redisService, timeZone));
				executor_xj.submit(new Thread_KJ500(lotteryResultInfoRepository, GameType.新疆二八.getKey(),restTemplate, kj500, xjlock, redisService, timeZone));
			}
		} catch (Exception e) {
			logger.error("拉取出错 : ", e);
		} finally {
			processing = false;
		}
	}

}
