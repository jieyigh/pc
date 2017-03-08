package com.ds.entity;

import java.io.Serializable;
import javax.persistence.*;
import java.util.Date;


/**
 * The persistent class for the pc_lottery_result database table.
 * 
 */
@Entity
@Table(name="pc_lottery_result")
@NamedQuery(name="LotteryResult.findAll", query="SELECT l FROM LotteryResult l")
public class LotteryResult implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private Long id;

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name="close_time")
	private Date closeTime;

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name="create_time")
	private Date createTime;

	@Column(name="game_type")
	private String gameType;

	@Column(name="lucky_num")
	private Integer luckyNum;

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name="open_time")
	private Date openTime;

	@Column(name="open_url")
	private String openUrl;

	@Column(name="original_num")
	private String originalNum;

	private Long term;

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name="update_time")
	private Date updateTime;

	public LotteryResult() {
	}

	public Long getId() {
		return this.id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public Date getCloseTime() {
		return this.closeTime;
	}

	public void setCloseTime(Date closeTime) {
		this.closeTime = closeTime;
	}

	public Date getCreateTime() {
		return this.createTime;
	}

	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}

	public String getGameType() {
		return this.gameType;
	}

	public void setGameType(String gameType) {
		this.gameType = gameType;
	}

	public Integer getLuckyNum() {
		return this.luckyNum;
	}

	public void setLuckyNum(Integer luckyNum) {
		this.luckyNum = luckyNum;
	}

	public Date getOpenTime() {
		return this.openTime;
	}

	public void setOpenTime(Date openTime) {
		this.openTime = openTime;
	}

	public String getOpenUrl() {
		return this.openUrl;
	}

	public void setOpenUrl(String openUrl) {
		this.openUrl = openUrl;
	}

	public String getOriginalNum() {
		return this.originalNum;
	}

	public void setOriginalNum(String originalNum) {
		this.originalNum = originalNum;
	}

	public Long getTerm() {
		return this.term;
	}

	public void setTerm(Long term) {
		this.term = term;
	}

	public Date getUpdateTime() {
		return this.updateTime;
	}

	public void setUpdateTime(Date updateTime) {
		this.updateTime = updateTime;
	}

}