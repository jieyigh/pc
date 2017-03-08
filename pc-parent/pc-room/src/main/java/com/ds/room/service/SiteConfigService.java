package com.ds.room.service;

public interface SiteConfigService {

	public String findBySiteId(Integer siteId);
	
	public String findRoomsBySiteId(Integer siteId);

}
