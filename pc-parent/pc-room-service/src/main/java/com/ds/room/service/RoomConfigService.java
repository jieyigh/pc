package com.ds.room.service;

import java.util.List;

import com.ds.entity.RoomConfig;
import com.ds.room.vo.RoomConfigParams;

public interface RoomConfigService {

	public List<RoomConfig> findBySiteIdAndGameType(Integer siteId,String gameType);
	
	public List<RoomConfig> findBySiteId(Integer siteId);
	
	
	public List<RoomConfig> findByGameType(String gameType);
	
	public RoomConfig update(RoomConfig room);
	
	public RoomConfig save(RoomConfig room);
	
	public RoomConfig edit(RoomConfigParams params);
}
