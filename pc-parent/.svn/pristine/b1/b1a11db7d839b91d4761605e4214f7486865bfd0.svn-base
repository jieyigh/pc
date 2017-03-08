package com.ds.play.repository;

import java.io.Serializable;
import java.util.List;

import org.springframework.data.jpa.repository.Query;

import com.ds.common.repository.BaseRepository;
import com.ds.entity.BetPlay;

public interface PlayRepository extends BaseRepository<BetPlay, Serializable> {

	@Query(value = "SELECT DISTINCT(CONCAT(game_type, '_', type)) FROM pc_bet_play", nativeQuery = true)
	List<String> getDistinctPlay();

	List<BetPlay> findByGameType(String gameType);

}
