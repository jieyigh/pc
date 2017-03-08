package com.ds.room.vo;

import javax.validation.constraints.Pattern;

import org.hibernate.validator.constraints.NotEmpty;

public class RoomParams {

	@NotEmpty(message = "code must not be null")
	@Pattern(regexp = "\\d*", message = "code must be a number")
	private String code;

	public String getCode() {
		return code;
	}

	public void setCode(String code) {
		this.code = code;
	}

}
