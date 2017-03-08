package com.ds.room.repository;

import java.io.Serializable;
import java.util.List;

import com.ds.common.repository.BaseRepository;
import com.ds.entity.RoomConfig;

public interface RoomConfigRepository extends BaseRepository<RoomConfig, Serializable> {

	public List<RoomConfig> findBySiteId(Integer siteId);
	
	public List<RoomConfig> findBySiteIdAndState(Integer siteId,Integer state);

	public List<RoomConfig> findBySiteIdAndGameType(Integer siteId,String gameType);
	
	public List<RoomConfig> findByGameType(String gameType);
}