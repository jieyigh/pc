package com.ds.common.bet;

import com.ds.common.util.StringUtil;

/**
 * 所有类型下注玩法
 * 
 * @author jackson
 *
 */
public enum BetType {

	// 基础玩法
	ODD("odd", "单"), //
	EVEN("even", "双"), //
	BIG("big", "大"), //
	SMALL("small", "小"), //

	// 28玩法
	BIG_ODD("big_odd", "大单"), //
	SMALL_ODD("small_odd", "小单"), //
	BIG_EVEN("big_even", "大双"), //
	SMALL_EVEN("small_even", "小双"), //
	CAO("cao", "草"), //
	MAX("max", "极大"), //
	MIN("min", "极小"), //
	STRAIGHT("straight", "顺子"), //
	LEOPARD("leopard", "豹子"), //
	PAIR("pair", "对子"), //
	RED("red", "红波"), //
	BLUE("blue", "蓝波"), //
	GREEN("green", "绿波"), //

	// ssc玩法
	DRAGON("dragon", "龙"), //
	TIGER("tiger", "虎"), //
	EQUAL("equal", "和");

	private String type;

	private String name;

	private BetType(String type, String name) {
		this.type = type;
		this.name = name;
	}

	public String getType() {
		return type;
	}

	public String getName() {
		return name;
	}

	public static String getNameByType(String type) {
		if (!StringUtil.isNull(type)) {
			for (BetType typeName : values()) {
				if (type.equals(typeName.getType())) {
					return typeName.getName();
				}
			}
		}
		return null;
	}
}
