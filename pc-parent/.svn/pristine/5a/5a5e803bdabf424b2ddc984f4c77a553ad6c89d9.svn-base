package com.ds.odds.vo;

import java.io.Serializable;

import javax.validation.constraints.Pattern;

import org.hibernate.validator.constraints.NotEmpty;

/**
 * The persistent class for the pc_bet_odds database table.
 * 
 */
public class BetOddParams implements Serializable {
	private static final long serialVersionUID = 1L;

	public interface BetOddParamsQuery {
	};

	public interface BetOddParamsTypeAdd {
	};

	public interface BetOddParamsTypeUpdate {
	};

	public interface BetOddParamsAdd {
	};

	public interface BetOddParamsUpdate {
	};

	private Long id;

	@Pattern(groups = { BetOddParamsTypeUpdate.class,
			BetOddParamsUpdate.class }, regexp = "^-?\\d+$", message = "enabled must be a number")
	private String enabled;

	@NotEmpty(groups = { BetOddParamsTypeAdd.class, BetOddParamsAdd.class }, message = "name must not be null")
	private String name;

	@NotEmpty(groups = { BetOddParamsAdd.class }, message = "parentId must not be null")
	@Pattern(groups = { BetOddParamsAdd.class,
			BetOddParamsUpdate.class }, regexp = "\\d*", message = "parentId must be a positive number")
	private String parentId;

	@NotEmpty(groups = { BetOddParamsAdd.class }, message = "play must not be null")
	private String play;

	@NotEmpty(groups = { BetOddParamsAdd.class, BetOddParamsQuery.class }, message = "tableId must not be null")
	@Pattern(groups = { BetOddParamsAdd.class, BetOddParamsUpdate.class,
			BetOddParamsQuery.class }, regexp = "\\d*", message = "tableId must be a positive number")
	private String tableId;

	@NotEmpty(groups = { BetOddParamsTypeAdd.class, BetOddParamsAdd.class }, message = "type must not be null")
	private String type;

	@NotEmpty(groups = { BetOddParamsTypeAdd.class, BetOddParamsTypeUpdate.class, BetOddParamsAdd.class,
			BetOddParamsUpdate.class }, message = "operator must not be null")
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

	public String getParentId() {
		return parentId;
	}

	public void setParentId(String parentId) {
		this.parentId = parentId;
	}

	public String getPlay() {
		return play;
	}

	public void setPlay(String play) {
		this.play = play;
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

}