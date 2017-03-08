package com.ds.repository;

import java.io.Serializable;
import java.util.List;

import org.springframework.data.jpa.repository.Query;

import com.ds.common.repository.BaseRepository;
import com.ds.entity.ActivityUser;

public interface ActivityUserRepository extends BaseRepository<ActivityUser, Serializable> {

	@Query(value = "SELECT DISTINCT(a.site_id) FROM pc_activity_user a WHERE DATE_FORMAT(a.create_time, '%Y-%m-%d') = ?1", nativeQuery = true)
	List<Integer> queryLossBonusSiteId(String today);

	List<ActivityUser> findBySiteIdAndState(Integer siteId, Integer state);

	@Query(value = "SELECT * FROM pc_activity_user WHERE site_id = ?1 " //
			+ "AND state = ?2 "//
			+ "AND DATE_FORMAT(create_time, '%Y-%m-%d') >= ?3 "//
			+ "AND DATE_FORMAT(create_time, '%Y-%m-%d') <= ?4 "//
			+ "AND loss_money_bonus IS NOT NULL", nativeQuery = true) //
	List<ActivityUser> findBySiteIdAndStateAndCreateTime(Integer siteId, Integer state, String fromDate, String toDate);

}
