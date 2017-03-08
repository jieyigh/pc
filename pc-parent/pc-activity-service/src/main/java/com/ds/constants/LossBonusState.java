package com.ds.constants;

/**
 * 亏损送状态
 * 
 * @author jackson
 *
 */
public enum LossBonusState {

	will_send(1), sended(2);

	private Integer key;

	public Integer getKey() {
		return key;
	}

	private LossBonusState(Integer key) {
		this.key = key;
	}

}
