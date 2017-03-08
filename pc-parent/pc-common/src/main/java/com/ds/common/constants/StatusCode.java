package com.ds.common.constants;

public interface StatusCode {

	final String SUCCESS = "10000"; // 成功
	final String PART_OF_SUCCESS = "10001"; // 部分成功 -- > 针对批量而言
	final String ERROR = "100020"; // 失败
	final String TABLE_ID_NOT_EXIST = "100077"; // tableId不存在或没生效
	final String MAYBE = "100099"; // 异常

	final String BET_NOT_IN_CUR_TERM = "100086"; // 不再当前销售奖期下注
	final String MD5_IS_ERROR = "100087"; // md5 is error
	final String LESS_OR_MORE_LIMIT_MONEY = "100088"; // 不再限额范围内
	final String BET_INFO_FORMAT_ERROR = "100089"; // 注单格式错误
	final String BET_GAME_TYPE_NOT_EXISTS = "100090"; // 下注游戏类型不存在

	final String TRANS_NO_MONEY = "110012"; // 余额不足
	final String IP_NOT_ALLOW = "110004"; // ip不允许
	final String PARAM_FORMAT_ERROR = "110009"; // 参数格式错误
	final String SITEID_OR_LIVE_NOEXIST = "110020"; // siteId不存在

	final String STATUS = "status";
	final String MESSAGE = "message";

	final String SYSTEM_ERROR = "system error";

	final String OK = "ok";

	final Integer NORMAL_STATE = 50;

	final String DT_MD5_KEY = "ds!@#$%^";
}
