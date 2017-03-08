package com.ds.limit.vo;

import javax.validation.constraints.Pattern;

import org.hibernate.validator.constraints.NotEmpty;

public class BetLimitParams {

	public interface BetLimitParamsAdd {
	};

	public interface BetLimitParamsUpdate {
	};

	public interface BetLimitParamsSingle {
	};

	private Long id;

	@Pattern(groups = { BetLimitParamsUpdate.class,
			BetLimitParamsSingle.class }, regexp = "^-?\\d+$", message = "enabled must be a number")
	private String enabled;

	@NotEmpty(groups = { BetLimitParamsAdd.class, BetLimitParamsSingle.class }, message = "name must not be null")
	private String name;

	/*
	 * @NotEmpty(groups={BetLimitParamsAdd.class,BetLimitParamsSingle.class},
	 * message = "play must not be null")
	 * 
	 * @Pattern(groups={BetLimitParamsAdd.class,BetLimitParamsUpdate.class,
	 * BetLimitParamsSingle.class},regexp = "\\d*", message =
	 * "play must be a positive number") private String play;
	 */

	@NotEmpty(groups = { BetLimitParamsAdd.class, BetLimitParamsSingle.class }, message = "tableId must not be null")
	@Pattern(groups = { BetLimitParamsAdd.class, BetLimitParamsUpdate.class,
			BetLimitParamsSingle.class }, regexp = "\\d*", message = "tableId must be a positive number")
	private String tableId;

	@NotEmpty(groups = { BetLimitParamsAdd.class, BetLimitParamsSingle.class }, message = "type must not be null")
	private String type;

	@NotEmpty(groups = { BetLimitParamsAdd.class, BetLimitParamsSingle.class }, message = "gameType must not be null")
	private String gameType;

	@NotEmpty(groups = { BetLimitParamsAdd.class, BetLimitParamsSingle.class }, message = "max must not be null")
	@Pattern(groups = { BetLimitParamsAdd.class, BetLimitParamsUpdate.class,
			BetLimitParamsSingle.class }, regexp = "\\d*", message = "max must be a positive number")
	private String max;

	@NotEmpty(groups = { BetLimitParamsAdd.class, BetLimitParamsSingle.class }, message = "min must not be null")
	@Pattern(groups = { BetLimitParamsAdd.class, BetLimitParamsUpdate.class,
			BetLimitParamsSingle.class }, regexp = "\\d*", message = "min must be a positive number")
	private String min;

	@NotEmpty(groups = { BetLimitParamsSingle.class }, message = "singPlayLimit must not be null")
	private String singPlayLimit;

	@NotEmpty(groups = { BetLimitParamsAdd.class, BetLimitParamsUpdate.class,
			BetLimitParamsSingle.class }, message = "operator must not be null")
	private String operator;
	
	

	public String getOperator() {
		return operator;
	}

	public void setOperator(String operator) {
		this.operator = operator;
	}

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public String getEnabled() {
		return enabled;
	}

	public void setEnabled(String enabled) {
		this.enabled = enabled;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getTableId() {
		return tableId;
	}

	public void setTableId(String tableId) {
		this.tableId = tableId;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public String getGameType() {
		return gameType;
	}

	public void setGameType(String gameType) {
		this.gameType = gameType;
	}

	public String getMax() {
		return max;
	}

	public void setMax(String max) {
		this.max = max;
	}

	public String getMin() {
		return min;
	}

	public void setMin(String min) {
		this.min = min;
	}

	public String getSingPlayLimit() {
		return singPlayLimit;
	}

	public void setSingPlayLimit(String singPlayLimit) {
		this.singPlayLimit = singPlayLimit;
	}

}
