package com.ds.entity;

import java.io.Serializable;
import javax.persistence.*;


/**
 * The persistent class for the pc_bet_play database table.
 * 
 */
@Entity
@Table(name="pc_bet_play")
@NamedQuery(name="BetPlay.findAll", query="SELECT b FROM BetPlay b")
public class BetPlay implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private Long id;

	@Column(name="game_type")
	private String gameType;

	private Integer max;

	private Integer min;

	private String name;

	private String type;

	public BetPlay() {
	}

	public Long getId() {
		return this.id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public String getGameType() {
		return this.gameType;
	}

	public void setGameType(String gameType) {
		this.gameType = gameType;
	}

	public Integer getMax() {
		return this.max;
	}

	public void setMax(Integer max) {
		this.max = max;
	}

	public Integer getMin() {
		return this.min;
	}

	public void setMin(Integer min) {
		this.min = min;
	}

	public String getName() {
		return this.name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getType() {
		return this.type;
	}

	public void setType(String type) {
		this.type = type;
	}

}