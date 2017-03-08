package com.ds.entity;

import java.io.Serializable;
import javax.persistence.*;
import java.util.Date;


/**
 * The persistent class for the pc_site_config database table.
 * 
 */
@Entity
@Table(name="pc_site_config")
@NamedQuery(name="SiteConfig.findAll", query="SELECT s FROM SiteConfig s")
public class SiteConfig implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private Integer id;

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name="create_time")
	private Date createTime;

	private String keyb;

	private String memo;

	@Column(name="money_key")
	private String moneyKey;

	@Column(name="money_url")
	private String moneyUrl;

	@Column(name="site_id")
	private Integer siteId;

	private Integer state;

	@Column(name="transfer_hash_code")
	private String transferHashCode;

	@Column(name="transfer_keyb")
	private String transferKeyb;

	@Column(name="transfer_url")
	private String transferUrl;

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name="update_time")
	private Date updateTime;

	public SiteConfig() {
	}

	public Integer getId() {
		return this.id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public Date getCreateTime() {
		return this.createTime;
	}

	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}

	public String getKeyb() {
		return this.keyb;
	}

	public void setKeyb(String keyb) {
		this.keyb = keyb;
	}

	public String getMemo() {
		return this.memo;
	}

	public void setMemo(String memo) {
		this.memo = memo;
	}

	public String getMoneyKey() {
		return this.moneyKey;
	}

	public void setMoneyKey(String moneyKey) {
		this.moneyKey = moneyKey;
	}

	public String getMoneyUrl() {
		return this.moneyUrl;
	}

	public void setMoneyUrl(String moneyUrl) {
		this.moneyUrl = moneyUrl;
	}

	public Integer getSiteId() {
		return this.siteId;
	}

	public void setSiteId(Integer siteId) {
		this.siteId = siteId;
	}

	public Integer getState() {
		return this.state;
	}

	public void setState(Integer state) {
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

	public Date getUpdateTime() {
		return this.updateTime;
	}

	public void setUpdateTime(Date updateTime) {
		this.updateTime = updateTime;
	}

}