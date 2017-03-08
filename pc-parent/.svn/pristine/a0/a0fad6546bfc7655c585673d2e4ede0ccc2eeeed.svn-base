package com.ds.room.vo;

import java.io.Serializable;
import java.util.List;

import javax.validation.constraints.Pattern;

import org.hibernate.validator.constraints.NotEmpty;

import com.ds.limit.vo.BetLimitParams;
import com.ds.odds.vo.BetOddParams;
import com.ds.room.vo.RoomConfigParams.RoomConfigParamsAdd;
import com.ds.room.vo.RoomConfigParams.RoomConfigParamsUpdate;


/**
 * The persistent class for the pc_table_config database table.
 * 
 */
public class TableConfigParams implements Serializable {
	private static final long serialVersionUID = 1L;
	
	public interface TableConfigParamsAdd{};
	public interface TableConfigParamsUpdate{};

	private Integer id;

	@NotEmpty(groups={TableConfigParamsAdd.class},message = "gameType must not be null")
	private String gameType;

	@NotEmpty(groups={TableConfigParamsAdd.class},message = "level must not be null")
	@Pattern(groups={TableConfigParamsAdd.class,TableConfigParamsUpdate.class},regexp = "\\d*", message = "level must be a number")
	private String level;

	@NotEmpty(groups={TableConfigParamsAdd.class},message = "memo1 must not be null")
	private String memo1;
	
	@NotEmpty(groups={TableConfigParamsAdd.class},message = "memo2 must not be null")
	private String memo2;
	
	@NotEmpty(groups={TableConfigParamsAdd.class},message = "name must not be null")
	private String name;

	@NotEmpty(groups={TableConfigParamsAdd.class},message = "roomId must not be null")
	@Pattern(groups={TableConfigParamsAdd.class,TableConfigParamsUpdate.class},regexp = "\\d*", message = "roomId must be a number")
	private String roomId;

	@Pattern(groups={TableConfigParamsUpdate.class},regexp = "^-?\\d+$", message = "state must be a number")
	private String state;
	
	private List<BetOddParams> odds;
	
	private List<BetLimitParams> limits;
	
	
	@NotEmpty(groups = { TableConfigParamsAdd.class, TableConfigParamsUpdate.class }, message = "operator must not be null")
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

	public String getLevel() {
		return level;
	}

	public void setLevel(String level) {
		this.level = level;
	}

	
	public String getMemo1() {
		return memo1;
	}

	public void setMemo1(String memo1) {
		this.memo1 = memo1;
	}

	public String getMemo2() {
		return memo2;
	}

	public void setMemo2(String memo2) {
		this.memo2 = memo2;
	}

	public String getRoomId() {
		return roomId;
	}

	public void setRoomId(String roomId) {
		this.roomId = roomId;
	}

	public String getState() {
		return state;
	}

	public void setState(String state) {
		this.state = state;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public List<BetOddParams> getOdds() {
		return odds;
	}

	public void setOdds(List<BetOddParams> odds) {
		this.odds = odds;
	}

	public List<BetLimitParams> getLimits() {
		return limits;
	}

	public void setLimits(List<BetLimitParams> limits) {
		this.limits = limits;
	}

}