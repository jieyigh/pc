package com.ds.lottery.result.repository;

import java.io.Serializable;
import java.util.Date;
import java.util.List;

import org.springframework.data.jpa.repository.Query;

import com.ds.common.repository.BaseRepository;
import com.ds.entity.LotteryResult;

public interface LotteryResultRepository extends BaseRepository<LotteryResult, Serializable> {

	LotteryResult findByGameTypeAndTerm(String gameType, Long term);

	@Query(value = "SELECT * FROM pc_lottery_result WHERE game_type = ?1 ORDER BY id DESC LIMIT 1", nativeQuery = true)
	public LotteryResult findLastestOneByGameType(String GameType);
	
	@Query(value = "SELECT * FROM pc_lottery_result WHERE game_type = ?1 ORDER BY term DESC LIMIT 10", nativeQuery = true)
	public List<LotteryResult> findLastest10ByGameType(String gameType);
	
	@Query(value = "SELECT * FROM pc_lottery_result WHERE DATE(DATE_ADD(open_time,INTERVAL 12 HOUR))=DATE(DATE_ADD(?2,INTERVAL 12 HOUR)) "
			+ "AND game_type=?1 "
			+ "AND DATE_FORMAT(DATE_ADD(open_time,INTERVAL 12 HOUR),'%Y-%m-%d %H:%i:%S')>DATE_FORMAT(DATE_ADD(?2,INTERVAL 12 HOUR),'%Y-%m-%d 03:00:00') LIMIT 1", nativeQuery = true)
	public LotteryResult findFirstOneByGameType(String gameType,Date now);

	LotteryResult findByTerm(Long term);

}
