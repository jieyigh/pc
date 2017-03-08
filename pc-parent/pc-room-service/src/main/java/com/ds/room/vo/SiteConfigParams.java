package com.ds.room.vo;

import javax.validation.constraints.Pattern;

import org.hibernate.validator.constraints.NotEmpty;

public class SiteConfigParams {

	public interface SiteConfigParamsQuery {
	};

	public interface SiteConfigParamsAdd {
	};

	public interface SiteConfigParamsUpdate {
	};

	private Integer id;

	private String memo;

	private String moneyUrl;

	@NotEmpty(groups = { SiteConfigParamsAdd.class, SiteConfigParamsQuery.class }, message = "siteId must not be null")
	@Pattern(groups = { SiteConfigParamsAdd.class, SiteConfigParamsQuery.class,SiteConfigParamsUpdate.class }, regexp = "\\d*", message = "siteId must be a number")
	private String siteId;

	@Pattern(groups={SiteConfigParamsUpdate.class},regexp = "^-?\\d+$", message = "state must be a number")
	private String state;

	private String transferHashCode;

	private String transferKeyb;

	private String transferUrl;
	
	private String keyb;

	private String moneyKey;
	
	@NotEmpty(groups = { SiteConfigParamsAdd.class, SiteConfigParamsUpdate.class }, message = "operator must not be null")
	private String operator;
	
	

	public String getOperator() {
		return operator;
	}

	public void setOperator(String operator) {
		this.operator = operator;
	}

	public Integer getId() {
		return this.id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getMemo() {
		return this.memo;
	}

	public void setMemo(String memo) {
		this.memo = memo;
	}

	public String getMoneyUrl() {
		return this.moneyUrl;
	}

	public void setMoneyUrl(String moneyUrl) {
		this.moneyUrl = moneyUrl;
	}

	public String getSiteId() {
		return this.siteId;
	}

	public void setSiteId(String siteId) {
		this.siteId = siteId;
	}

	public String getState() {
		return this.state;
	}

	public void setState(String state) {
		this.state = state;
	}

	public String getTransferHashCode() {
		return this.transferHashCode;
	}

	public void setTransferHashCode(String transferHashCode) {
		this.transferHashCode = transferHashCode;
	}

	public String getTransferKeyb() {
		return this.transferKeyb;
	}

	public void setTransferKeyb(String transferKeyb) {
		this.transferKeyb = transferKeyb;
	}

	public String getTransferUrl() {
		return this.transferUrl;
	}

	public void setTransferUrl(String transferUrl) {
		this.transferUrl = transferUrl;
	}

	public String getKeyb() {
		return keyb;
	}

	public void setKeyb(String keyb) {
		this.keyb = keyb;
	}

	public String getMoneyKey() {
		return moneyKey;
	}

	public void setMoneyKey(String moneyKey) {
		this.moneyKey = moneyKey;
	}

	
}
