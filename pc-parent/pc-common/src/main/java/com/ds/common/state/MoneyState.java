package com.ds.common.state;

import com.ds.common.util.StringUtil;

public enum MoneyState {

	BET(1, "下注"), //
	PATCH(-1, "补单"), //
	PAY_OFF_WIN(2, "派彩赢"), //
	PAY_OFF_LOSS(3, "派彩输"), //
	CANCEL(4, "撤销");

	private Integer state;

	private String value;

	private MoneyState(Integer state, String value) {
		this.state = state;
		this.value = value;
	}

	public Integer getState() {
		return state;
	}

	public String getValue() {
		return value;
	}

	public static String getValueByKey(Integer key) {
		String value = null;
		MoneyState[] values = MoneyState.values();
		for (MoneyState combobox : values) {
			if (combobox.state.intValue() == key.intValue()) {
				value = combobox.getValue();
				break;
			}
		}
		return value;
	}

	public static Integer getKeyByValue(String v) {
		if (StringUtil.isNull(v)) {
			throw new RuntimeException("value为空!");
		}
		Integer key = null;
		MoneyState[] values = MoneyState.values();
		for (MoneyState combobox : values) {
			if (combobox.getValue().equals(v)) {
				key = combobox.getState();
				break;
			}
		}

		if (key == null) {
			throw new RuntimeException("传入的value不存在!");
		}
		return key;
	}

}
