package com.ds.loss.bonus.task;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.annotation.PostConstruct;
import javax.transaction.Transactional;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.EnableScheduling;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import com.alibaba.fastjson.JSONArray;
import com.ds.bet.loss.vo.LossBonusVo;
import com.ds.bet.service.BetInfoService;
import com.ds.common.service.CommonService;
import com.ds.common.util.DateUtil;
import com.ds.constants.LossBonusState;
import com.ds.entity.Activity;
import com.ds.entity.ActivityUser;
import com.ds.loss.bonus.vo.LossBonusCondition;
import com.ds.service.ActivityService;
import com.ds.service.ActivityUserService;

/**
 * 亏损送任务
 * 
 * @author jackson
 *
 */
@Component
@EnableScheduling
public class LossBonusTask extends CommonService {

	private Logger logger = LoggerFactory.getLogger(this.getClass());

	//	private static String threadName = "lossBonus";

	private boolean processing = false;

	@Autowired
	private ActivityService activityService;

	@Autowired
	private ActivityUserService activityUserService;

	@Autowired
	private BetInfoService betInfoService;

	private Integer num = 1; // 每次反水网站数量

	//	private ExecutorService executor = new ThreadPoolExecutor(10, 10, 0, TimeUnit.MILLISECONDS, //
	//			new LinkedBlockingQueue<Runnable>(10), // 工作队列
	//			new NamedThreadFactory(threadName, false), // 命名线程池名称
	//			new AbortPolicyWithReport(threadName) // 拒绝日志收集
	//	); // 每次10家网站反水

	/**
	 * 每5分钟执行一次
	 */
	@Transactional
	@PostConstruct
	@Scheduled(fixedDelay = 5 * 60 * 1000)
	public void bonus() {
		try {
			if (!processing) {
				processing = true;
				String todayStr = DateUtil.getDaysAgo(0, "-");
				String yesterdayStr = DateUtil.getDaysAgo(1, "-");
				// 1. 查询已经反水过的网站 
				
				List<Integer> siteIdList = this.activityUserService.queryLossBonusSiteId(todayStr);
				// 2. 查询待反水的网站
				List<Integer> todoLossBonusSiteIdList = this.betInfoService.todoLossBonusSiteIdList(yesterdayStr, siteIdList, num);
				if (todoLossBonusSiteIdList == null || todoLossBonusSiteIdList.size() <= 0) {
					logger.info("无需反水的网站");
					return;
				}
				Date now = new Date();
				// TODO: 暂时每次只反水一个网站
				//				for (Integer siteId : todoLossBonusSiteIdList) { // 遍历每个网站
				Integer siteId = todoLossBonusSiteIdList.get(0);
				logger.info("反水网站 = {}, 日期 = {}", siteId, now);
				List<LossBonusVo> lossBonusList = this.betInfoService.totalLossBonusInfosBySiteId(siteId, yesterdayStr);
				if (lossBonusList == null || lossBonusList.size() <= 0) {
					return;
				}
				// 4. 查询网站活动
				Map<Integer, Activity> activityBySiteId = this.activityService.queryActivityBySiteId();
				Activity activity = activityBySiteId.get(siteId);
				// 5.对每个网站的用户进行反水
				List<LossBonusCondition> conditionList = null;
				BigDecimal lossMoney = null;
				// 用来统计反水用户
				List<ActivityUser> activityUsers = new ArrayList<>();
				for (LossBonusVo lossBonusVo : lossBonusList) { // 网站中的每个用户
					ActivityUser activityUser = new ActivityUser();
					if (lossBonusVo.getTotalBetMoney().compareTo(lossBonusVo.getTotalPayOff()) <= 0) { // 赢钱
						continue;
					}
					lossMoney = lossBonusVo.getTotalBetMoney().subtract(lossBonusVo.getTotalPayOff()).abs();
					conditionList = JSONArray.parseArray(activity.getContent(), LossBonusCondition.class);
					Collections.sort(conditionList, new ActivitySortComparotr());
					for (LossBonusCondition lossBonusCondition : conditionList) {
						if (lossMoney.compareTo(lossBonusCondition.getLossMoney()) >= 0) {
							activityUser.setLossMoneyBonus(lossMoney.multiply(lossBonusCondition.getBonusPercent()).divide(new BigDecimal(100)));
							break;
						}
					}
					activityUser.setActivityId(activity.getId());
					activityUser.setCreateTime(now);
					activityUser.setLossMoney(lossMoney);
					activityUser.setSiteId(siteId);
					activityUser.setState(LossBonusState.will_send.getKey());
					activityUser.setUsername(lossBonusVo.getUsername());
					activityUser.setOriginalUsername(lossBonusVo.getOriginalUsername());
					activityUsers.add(activityUser);
				}
				// 反水成功
				this.activityUserService.insertBatch(activityUsers);
			}
		} catch (Exception e) {
			logger.error("亏损送出错 : ", e);
		} finally {
			processing = false;
		}
	}

	class ActivitySortComparotr implements Comparator<LossBonusCondition> {
		@Override
		public int compare(LossBonusCondition o1, LossBonusCondition o2) {
			return o2.getLossMoney().compareTo(o1.getLossMoney());
		}

	}

}
