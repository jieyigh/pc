package com.ds.room.vo;

import javax.validation.constraints.Pattern;

import org.hibernate.validator.constraints.NotEmpty;

public class RoomConfigParams {
	
	public interface RoomConfigParamsEdit{};
	
	public interface RoomConfigParamsAdd{};
	
	public interface RoomConfigParamsUpdate{};

	private Integer id;

	@NotEmpty(groups={RoomConfigParamsAdd.class},message = "gameType must not be null")
	private String gameType;

	@NotEmpty(groups={RoomConfigParamsAdd.class},message = "memo must not be null")
	private String memo;
	
	@NotEmpty(groups={RoomConfigParamsAdd.class},message = "memo2 must not be null")
	private String memo2;
	
	@Pattern(groups={RoomConfigParamsUpdate.class},regexp = "^-?\\d+$", message = "state must be a number")
	private String state;

	@NotEmpty(groups={RoomConfigParamsAdd.class},message = "siteId must not be null")
	@Pattern(groups={RoomConfigParamsAdd.class,RoomConfigParamsUpdate.class},regexp = "\\d*", message = "siteId must be a positive number")
	private String siteId;
	
	@NotEmpty(groups = { RoomConfigParamsAdd.class, RoomConfigParamsUpdate.class }, message = "operator must not be null")
	private String operator;
	
	

	public String getOperator() {
		return operator;
	}

	public void setOperator(String operator) {
		this.operator = operator;
	}

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getGameType() {
		return gameType;
	}

	public void setGameType(String gameType) {
		this.gameType = gameType;
	}

	public String getMemo() {
		return memo;
	}

	public void setMemo(String memo) {
		this.memo = memo;
	}

	public String getSiteId() {
		return siteId;
	}

	public void setSiteId(String siteId) {
		this.siteId = siteId;
	}

	public String getState() {
		return state;
	}

	public void setState(String state) {
		this.state = state;
	}

	public String getMemo2() {
		return memo2;
	}

	public void setMemo2(String memo2) {
		this.memo2 = memo2;
	}
	
	

}
