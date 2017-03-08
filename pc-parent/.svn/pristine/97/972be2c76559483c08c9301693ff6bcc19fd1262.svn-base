package com.ds.service;

import java.util.List;
import java.util.Map;

import com.ds.entity.Activity;

/**
 * 活动业务
 * 
 * @author jackson
 *
 */
public interface ActivityService {

	/**
	 * 根据siteId查询活动
	 */
	Map<Integer, Activity> findAllGroupBySiteId();

	/** 查询网站反水的活动 */
	Map<Integer, Activity> queryActivityBySiteId();

	List<Activity> findBySiteId(Integer siteId);

	void updateById(Activity activity);

}
