package com.ds.play.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.EnableScheduling;
import org.springframework.stereotype.Service;

import com.ds.entity.BetPlay;
import com.ds.play.repository.PlayRepository;

@Service
@EnableScheduling
public class PlayService {

	@Autowired
	private PlayRepository playRepository;

	public List<String> getDistinctPlay() {
		return this.playRepository.getDistinctPlay();
	}

	public List<BetPlay> getPlaysByGameType(String gameType) {
		return this.playRepository.findByGameType(gameType);
	}

	public List<BetPlay> findAll() {
		return this.playRepository.findAll();
	}

}
