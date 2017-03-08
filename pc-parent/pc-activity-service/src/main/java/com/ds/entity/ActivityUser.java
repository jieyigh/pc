package com.ds.entity;

import java.io.Serializable;
import javax.persistence.*;
import java.math.BigDecimal;
import java.util.Date;


/**
 * The persistent class for the pc_activity_user database table.
 * 
 */
@Entity
@Table(name="pc_activity_user")
@NamedQuery(name="ActivityUser.findAll", query="SELECT a FROM ActivityUser a")
public class ActivityUser implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private Long id;

	@Column(name="activity_id")
	private Long activityId;

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name="create_time")
	private Date createTime;

	@Column(name="loss_money")
	private BigDecimal lossMoney;

	@Column(name="loss_money_bonus")
	private BigDecimal lossMoneyBonus;

	private String operator;

	@Column(name="original_username")
	private String originalUsername;

	@Column(name="site_id")
	private Integer siteId;

	private Integer state;

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name="update_time")
	private Date updateTime;

	private String username;

	public ActivityUser() {
	}

	public Long getId() {
		return this.id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public Long getActivityId() {
		return this.activityId;
	}

	public void setActivityId(Long activityId) {
		this.activityId = activityId;
	}

	public Date getCreateTime() {
		return this.createTime;
	}

	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}

	public BigDecimal getLossMoney() {
		return this.lossMoney;
	}

	public void setLossMoney(BigDecimal lossMoney) {
		this.lossMoney = lossMoney;
	}

	public BigDecimal getLossMoneyBonus() {
		return this.lossMoneyBonus;
	}

	public void setLossMoneyBonus(BigDecimal lossMoneyBonus) {
		this.lossMoneyBonus = lossMoneyBonus;
	}

	public String getOperator() {
		return this.operator;
	}

	public void setOperator(String operator) {
		this.operator = operator;
	}

	public String getOriginalUsername() {
		return this.originalUsername;
	}

	public void setOriginalUsername(String originalUsername) {
		this.originalUsername = originalUsername;
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

	public Date getUpdateTime() {
		return this.updateTime;
	}

	public void setUpdateTime(Date updateTime) {
		this.updateTime = updateTime;
	}

	public String getUsername() {
		return this.username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

}