package com.ds.service;

import java.util.List;
import java.util.Set;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

import com.ds.entity.ActivityUser;

public interface ActivityUserService {

	/** 查询反水过的用户 */
	List<Integer> queryLossBonusSiteId(String today);

	int insertBatch(List<ActivityUser> activityUsers);

	List<ActivityUser> queryLossBonusBySiteIdAndStateAndDate(Integer siteId, Integer state, String fromDate,
			String toDate);

	List<ActivityUser> getActivityUserBySiteIdAndDateOrUsernames(Integer siteId, Integer state, String date,
			String... usernames);

	int updateBonusByState(Integer siteId, String date, Integer state, String operator, Set<String> usernameSet,
			boolean include);

	Page<ActivityUser> findBySiteIdAndStateAndCreateTime(Integer siteId, Integer state, String fromDate, String toDate,
			String username, Pageable pageable);

	Page<ActivityUser> findAll(Integer siteId, Integer state, String fromDate, String toDate, String username,
			Pageable pageable);

}
