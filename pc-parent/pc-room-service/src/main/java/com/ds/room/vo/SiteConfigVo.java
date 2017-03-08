package com.ds.room.vo;

import java.util.Date;
import java.util.List;

public class SiteConfigVo {

	private Integer id;

	private Date createTime;

	private String memo;

	private int siteId;

	private Integer state;

	private List<RoomConfigVo> rooms;

	public List<RoomConfigVo> getRooms() {
		return rooms;
	}

	public void setRooms(List<RoomConfigVo> rooms) {
		this.rooms = rooms;
	}

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public Date getCreateTime() {
		return createTime;
	}

	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}

	public String getMemo() {
		return memo;
	}

	public void setMemo(String memo) {
		this.memo = memo;
	}

	public int getSiteId() {
		return siteId;
	}

	public void setSiteId(int siteId) {
		this.siteId = siteId;
	}

	public Integer getState() {
		return state;
	}

	public void setState(Integer state) {
		this.state = state;
	}

}
