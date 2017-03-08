package com.ds.lottery.result.vo;

import javax.validation.constraints.Pattern;

import org.hibernate.validator.constraints.NotEmpty;

public class LotteryResultParams {

	public interface LotteryResultParamsAdd {
	};

	@NotEmpty(groups = { LotteryResultParamsAdd.class }, message = "gameType must not be null")
	private String gameType;

	@NotEmpty(groups = { LotteryResultParamsAdd.class }, message = "term must not be null")
	@Pattern(groups = { LotteryResultParamsAdd.class }, regexp = "\\d*", message = "term must be a positive number")
	private String term;

	@NotEmpty(groups = { LotteryResultParamsAdd.class }, message = "originalNum must not be null")
	@Pattern(groups = {
			LotteryResultParamsAdd.class }, regexp = "\\d*", message = "originalNum must be a positive number")
	private String originalNum;

	@NotEmpty(groups = { LotteryResultParamsAdd.class }, message = "operator must not be null")
	private String operator;
	
	private String openTime;

	public String getGameType() {
		return gameType;
	}

	public void setGameType(String gameType) {
		this.gameType = gameType;
	}

	public String getTerm() {
		return term;
	}

	public void setTerm(String term) {
		this.term = term;
	}

	public String getOriginalNum() {
		return originalNum;
	}

	public void setOriginalNum(String originalNum) {
		this.originalNum = originalNum;
	}

	public String getOperator() {
		return operator;
	}

	public void setOperator(String operator) {
		this.operator = operator;
	}

	public String getOpenTime() {
		return openTime;
	}

	public void setOpenTime(String openTime) {
		this.openTime = openTime;
	}

	
}
