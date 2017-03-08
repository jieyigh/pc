package com.ds.bet.entity;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.NamedQuery;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;


/**
 * The persistent class for the pc_bet_info database table.
 * 
 */
@Entity
@Table(name="pc_bet_info")
@NamedQuery(name="BetInfo.findAll", query="SELECT b FROM BetInfo b")
public class BetInfo implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private Long id;

	@Column(name="after_balance")
	private BigDecimal afterBalance;

	@Column(name="bet_money")
	private BigDecimal betMoney;

	@Column(name="bet_msg")
	private String betMsg;

	@Column(name="bet_num")
	private Integer betNum;

	@Column(name="bet_odds_expected")
	private BigDecimal betOddsExpected;

	@Column(name="bet_odds1314")
	private BigDecimal betOdds1314;

	@Column(name="bet_type")
	private String betType;

	@Column(name="bill_no")
	private String billNo;

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name="create_time")
	private Date createTime;

	@Column(name="game_type")
	private String gameType;

	@Column(name="original_username")
	private String originalUsername;

	@Column(name="pay_off")
	private BigDecimal payOff;

	@Column(name="site_id")
	private Integer siteId;

	private Integer state;

	@Column(name="table_id")
	private Integer tableId;

	private Long term;

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name="update_time")
	private Date updateTime;

	private String username;

	@Column(name="win_money_expected")
	private BigDecimal winMoneyExpected;

	@Column(name="win_money_valid")
	private BigDecimal winMoneyValid;

	@Column(name="win_money1314")
	private BigDecimal winMoney1314;

	public BetInfo() {
	}

	public Long getId() {
		return this.id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public BigDecimal getAfterBalance() {
		return this.afterBalance;
	}

	public void setAfterBalance(BigDecimal afterBalance) {
		this.afterBalance = afterBalance;
	}

	public BigDecimal getBetMoney() {
		return this.betMoney;
	}

	public void setBetMoney(BigDecimal betMoney) {
		this.betMoney = betMoney;
	}

	public String getBetMsg() {
		return this.betMsg;
	}

	public void setBetMsg(String betMsg) {
		this.betMsg = betMsg;
	}

	public Integer getBetNum() {
		return this.betNum;
	}

	public void setBetNum(Integer betNum) {
		this.betNum = betNum;
	}

	public BigDecimal getBetOddsExpected() {
		return this.betOddsExpected;
	}

	public void setBetOddsExpected(BigDecimal betOddsExpected) {
		this.betOddsExpected = betOddsExpected;
	}

	public BigDecimal getBetOdds1314() {
		return this.betOdds1314;
	}

	public void setBetOdds1314(BigDecimal betOdds1314) {
		this.betOdds1314 = betOdds1314;
	}

	public String getBetType() {
		return this.betType;
	}

	public void setBetType(String betType) {
		this.betType = betType;
	}

	public String getBillNo() {
		return this.billNo;
	}

	public void setBillNo(String billNo) {
		this.billNo = billNo;
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

	public String getOriginalUsername() {
		return this.originalUsername;
	}

	public void setOriginalUsername(String originalUsername) {
		this.originalUsername = originalUsername;
	}

	public BigDecimal getPayOff() {
		return this.payOff;
	}

	public void setPayOff(BigDecimal payOff) {
		this.payOff = payOff;
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

	public Integer getTableId() {
		return this.tableId;
	}

	public void setTableId(Integer tableId) {
		this.tableId = tableId;
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

	public String getUsername() {
		return this.username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public BigDecimal getWinMoneyExpected() {
		return this.winMoneyExpected;
	}

	public void setWinMoneyExpected(BigDecimal winMoneyExpected) {
		this.winMoneyExpected = winMoneyExpected;
	}

	public BigDecimal getWinMoneyValid() {
		return this.winMoneyValid;
	}

	public void setWinMoneyValid(BigDecimal winMoneyValid) {
		this.winMoneyValid = winMoneyValid;
	}

	public BigDecimal getWinMoney1314() {
		return this.winMoney1314;
	}

	public void setWinMoney1314(BigDecimal winMoney1314) {
		this.winMoney1314 = winMoney1314;
	}

}