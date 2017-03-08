package com.ds.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ds.constants.ActivityType;
import com.ds.entity.Activity;
import com.ds.repository.ActivityRepository;
import com.ds.service.ActivityService;

/**
 * 活动业务类
 * 
 * @author jackson
 *
 */
@Service
public class ActivityServiceImpl implements ActivityService {

	@Autowired
	private ActivityRepository activityRepository;

	@Override
	public Map<Integer, Activity> findAllGroupBySiteId() {
		Map<Integer, Activity> resultMap = new HashMap<>();
		List<Activity> activities = this.activityRepository.findAll();
		if (activities == null || activities.size() <= 0) {
			return resultMap;
		}
		for (Activity activity : activities) {
			resultMap.put(activity.getSiteId(), activity);
		}
		return resultMap;
	}

	@Override
	public Map<Integer, Activity> queryActivityBySiteId() {
		List<Activity> activityList = this.activityRepository.findByType(ActivityType.LOSS_BONUS.getKey());
		if (activityList == null || activityList.size() <= 0) {
			return null;
		}
		Map<Integer, Activity> siteIdActivityMap = new HashMap<>();
		for (Activity activity : activityList) {
			siteIdActivityMap.put(activity.getSiteId(), activity);
		}
		return siteIdActivityMap;
	}

	@Override
	public List<Activity> findBySiteId(Integer siteId) {
		return this.activityRepository.findBySiteId(siteId);
	}

	@Override
	public void updateById(Activity activity) {
		Activity newActivity = this.activityRepository.findById(activity.getId());
		newActivity.setContent(activity.getContent());
		newActivity.setMemo(activity.getMemo());
		newActivity.setName(activity.getName());
		this.activityRepository.saveAndFlush(newActivity);
	}

}
