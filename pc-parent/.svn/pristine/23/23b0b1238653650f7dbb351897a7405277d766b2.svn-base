package com.ds.odds.vo;

import javax.validation.constraints.Pattern;

import org.hibernate.validator.constraints.NotEmpty;

public class BetOddParams {

	@NotEmpty(message = "tableId must not be null")
	@Pattern(regexp = "\\d*", message = "tableId must be a number")
	private String tableId;

	public String getTableId() {
		return tableId;
	}

	public void setTableId(String tableId) {
		this.tableId = tableId;
	}

}
