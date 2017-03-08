package com.ds.repository;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.PagingAndSortingRepository;
import org.springframework.stereotype.Repository;

import com.ds.entity.ActivityUser;

@Repository
public interface ActivityUserPagingRepository
		extends JpaSpecificationExecutor<ActivityUser>, PagingAndSortingRepository<ActivityUser, String> {

	@Query(value = "SELECT a FROM ActivityUser a WHERE a.siteId = ?1 " //
			+ "AND a.state = ?2 "//
			+ "AND DATE_FORMAT(a.createTime, '%Y-%m-%d') >= ?3 "//
			+ "AND DATE_FORMAT(a.createTime, '%Y-%m-%d') <= ?4 "//
			+ "AND a.lossMoneyBonus IS NOT NULL "//
			+ "AND a.username = ?5") //
	Page<ActivityUser> findBySiteIdAndStateAndCreateTime(Integer siteId, Integer state, String fromDate, String toDate,
			String username, Pageable pageable);

}
