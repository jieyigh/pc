package com.ds.room.vo;

import java.util.List;

import com.ds.entity.RoomConfig;

public class RoomConfigVo extends RoomConfig {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	private List<TableConfigVo> tables;

	public List<TableConfigVo> getTables() {
		return tables;
	}

	public void setTables(List<TableConfigVo> tables) {
		this.tables = tables;
	}

}
