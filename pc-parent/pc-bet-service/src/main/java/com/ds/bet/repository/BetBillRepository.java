package com.ds.bet.repository;

import java.io.Serializable;
import java.util.Date;
import java.util.List;

import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;

import com.ds.bet.entity.BetBill;
import com.ds.common.repository.BaseRepository;

public interface BetBillRepository extends BaseRepository<BetBill, Serializable> {

	BetBill findByTermAndUsernameAndTableId(Long term, String username, Integer tableId);

	@Query(value = "SELECT DISTINCT term FROM pc_bet_bill WHERE state = ?1", nativeQuery = true)
	List<Long> findTermByState(Integer state);

	@Modifying
	@Query(value = "UPDATE pc_bet_bill SET state = ?3, update_time = ?4 WHERE game_type = ?1 AND term = ?2", nativeQuery = true)
	void updateStateByTerm(String gameType, Long term, Integer state, Date now);

	@Query(value = "SELECT COUNT(1) FROM pc_bet_bill WHERE game_type = ?1 AND term = ?2 AND state = ?3", nativeQuery = true)
	Long isPayoff(String gameType, Long term, Integer state);

} 
