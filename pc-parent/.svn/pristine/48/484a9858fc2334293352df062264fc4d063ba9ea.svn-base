package com.ds.redis.provider.play;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ds.entity.BetPlay;
import com.ds.play.service.PlayService;

@Service
public class PlayCache {

	@Autowired
	private PlayService playService;

	// key = gameType, value = play集合
	public Map<String, List<BetPlay>> cachePlay() {
		Map<String, List<BetPlay>> playMap = new HashMap<>();
		List<BetPlay> allBetPlay = this.playService.findAll();
		for (BetPlay betPlay : allBetPlay) {
			List<BetPlay> list = playMap.get(betPlay.getGameType());
			if (list == null) {
				list = new ArrayList<>();
				playMap.put(betPlay.getGameType(), list);
			}
			list.add(betPlay);
		}
		return playMap;
	}

}
