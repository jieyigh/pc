package com.ds.odds.vo;

public enum BetOddsType {

	dxds(1), // 大小单双
	jdjx(2), // 极大极小
	sing(3), // 单点数字
	compuse(4), // 组合
	dxds_1314(5), // 1314 大小单双
	compuse_1314(6), // 1314组合
	special(7), // 特殊玩法, 顺子|豹子
	color(8); // 红绿蓝波玩法

	private Integer type;

	private BetOddsType(Integer type) {
		this.type = type;
	}

	public Integer getType() {
		return type;
	}

}
