package com.ds.bet.repository;

import java.io.Serializable;

import org.springframework.data.jpa.repository.Query;

import com.ds.bet.entity.BetInfo;
import com.ds.common.repository.BaseRepository;

public interface BetInfoRepository extends BaseRepository<BetInfo, Serializable> {

	@Query(value = "SELECT COUNT(1) FROM pc_bet_info_yesterday WHERE DATE_FORMAT(create_time, '%Y-%m-%d') = ?1", nativeQuery = true)
	public Long queryCountLossToday(String now);

}
