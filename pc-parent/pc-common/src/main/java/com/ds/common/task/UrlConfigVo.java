package com.ds.common.task;

import java.io.Serializable;

public class UrlConfigVo implements Serializable {

	private static final long serialVersionUID = 7212123965552661062L;

	private Integer tableId;
	private Integer siteId;
	private String moneyUrl;
	private String moneyKey;
	private String transferUrl;
	private String transferHashCode;
	private String transferKeyb;
	private String keyb;
	private String gameType;

	public Integer getTableId() {
		return tableId;
	}

	public void setTableId(Integer tableId) {
		this.tableId = tableId;
	}

	public Integer getSiteId() {
		return siteId;
	}

	public void setSiteId(Integer siteId) {
		this.siteId = siteId;
	}

	public String getMoneyUrl() {
		return moneyUrl;
	}

	public void setMoneyUrl(String moneyUrl) {
		this.moneyUrl = moneyUrl;
	}

	public String getMoneyKey() {
		return moneyKey;
	}

	public void setMoneyKey(String moneyKey) {
		this.moneyKey = moneyKey;
	}

	public String getTransferUrl() {
		return transferUrl;
	}

	public void setTransferUrl(String transferUrl) {
		this.transferUrl = transferUrl;
	}

	public String getTransferHashCode() {
		return transferHashCode;
	}

	public void setTransferHashCode(String transferHashCode) {
		this.transferHashCode = transferHashCode;
	}

	public String getTransferKeyb() {
		return transferKeyb;
	}

	public void setTransferKeyb(String transferKeyb) {
		this.transferKeyb = transferKeyb;
	}

	public String getKeyb() {
		return keyb;
	}

	public void setKeyb(String keyb) {
		this.keyb = keyb;
	}

	public String getGameType() {
		return gameType;
	}

	public void setGameType(String gameType) {
		this.gameType = gameType;
	}

}
