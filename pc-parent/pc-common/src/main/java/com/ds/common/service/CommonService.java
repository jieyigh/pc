package com.ds.common.service;

import java.util.HashMap;
import java.util.Map;

import com.ds.common.constants.StatusCode;

public class CommonService implements StatusCode {

	protected static final String IN = "IN";//转入
	protected static final String OUT = "OUT";//转出

	protected Map<String, Object> success(Object msg) {
		Map<String, Object> resultMap = new HashMap<String, Object>();
		return this.success(resultMap, msg);
	}

	protected Map<String, Object> failure(String msg) {
		Map<String, Object> resultMap = new HashMap<String, Object>();
		return this.failure(resultMap, msg);
	}

	protected Map<String, Object> maybe(String msg) {
		Map<String, Object> resultMap = new HashMap<String, Object>();
		return this.maybe(resultMap, msg);
	}

	protected Map<String, Object> success(Map<String, Object> resultMap, Object msg) {
		resultMap.put(STATUS, SUCCESS);
		resultMap.put(MESSAGE, msg);
		return resultMap;
	}

	protected Map<String, Object> failure(Map<String, Object> resultMap, String msg) {
		resultMap.put(STATUS, ERROR);
		resultMap.put(MESSAGE, msg);
		return resultMap;
	}

	protected Map<String, Object> maybe(Map<String, Object> resultMap, String msg) {
		resultMap.put(STATUS, MAYBE);
		resultMap.put(MESSAGE, msg);
		return resultMap;
	}
	
	protected Map<String, Object> result(String code, Object msg){
		Map<String, Object> resultMap = new HashMap<>();
		resultMap.put(STATUS, code);
		resultMap.put(MESSAGE, msg);
		return resultMap;
	}

}
