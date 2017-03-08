package com.ds.common.limit;

/**
 * 限额枚举类
 * 
 * @author jackson
 *
 */
public enum LimitType {

	SING_MAX_MONEY("sing_max_money"), //单点数字最高限额
	SING_MIN_MONEY("sing_min_money"), //单点数字最低限额
	DXDS_MAX_MONEY("dxds_max_money"), //大小单双单注最高限额
	COMPUSE_MAX_MONEY("compuse_max_money"), //组合单注最高限额
	MAX_MIN_MAX_MONEY("max_min_max_money"), //极大极小单注最高限额
	STRAIGHT_MAX_MONEY("straight_max_money"), //顺子单注限额
	LEOPARD_MAX_MONEY("leopard_max_money"), //豹子单注限额
	SING_MAX_MONEY_SINGLE("sing_max_money_single"), //单点数字单局最高限额
	DXDS_MAX_MONEY_SINGLE("dxds_max_money_single"), //大小单双单局最高限额
	COMPUSE_MAX_MONEY_SINGLE("compuse_max_money_single"), //组合单局限额
	STRAIGHT_MAX_MONEY_SINGLE("straight_max_money_single"), //顺子单局限额
	LEOPARD_MAX_MONEY_SINGLE("leopard_max_money_single"), // 豹子单局限额
	MAX_MIN_MAX_MONEY_SINGLE("max_min_max_money_single"), // 极大极小单注限额
	COLOR_MAX_MONEY("color_max_money"), //红绿蓝波最高限额
	COLOR_MIN_MONEY("color_min_money"), //红绿蓝波最低限额
	EVERY_MAX("every_max"), //单注最高投注限额
	EVERY_MIN("every_min"), //单注最低投注限额
	TOTAL_MAX("total_max"); // 总注最高投注限额

	private String type;

	private LimitType(String type) {
		this.type = type;
	}

	public String getType() {
		return type;
	}

}
