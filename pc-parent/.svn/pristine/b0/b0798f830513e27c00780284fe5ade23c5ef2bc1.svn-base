package com.ds.common.controller.base;

import java.io.BufferedWriter;
import java.io.IOException;
import java.io.OutputStreamWriter;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.ds.common.constants.StatusCode;
import com.ds.common.util.JSONUtils;

public class BaseController implements StatusCode {

	private static final Logger logger = LoggerFactory.getLogger(BaseController.class);
	
	/**
	 * 获取json串参数
	 */
	protected String getParams(HttpServletRequest request) {
		Enumeration<String> enums = request.getParameterNames();
		String param = null;
		while (enums.hasMoreElements()) {
			Object o = enums.nextElement();
			param = (o == null ? "" : o.toString());
		}
		return param;
	}
	
	protected void md5Process(HttpServletRequest request, HttpServletResponse response, String timestamp, String encrypt,
			String status, Object msg) throws IOException {
		String ip = this.getIpAddr(request);
		logger.info("ip = {}, timestamp = {}, encrypt = {}", ip, timestamp, encrypt);
		BufferedWriter writer = new BufferedWriter(new OutputStreamWriter(response.getOutputStream()));
		writer.write(JSONUtils.map2Json(result(status, msg)));
		writer.flush();
		writer.close();
	}

	/**
	 * 获取真实ip
	 */
	protected String getIpAddr(HttpServletRequest request) {
		String ip = request.getHeader("x-forwarded-for");
		if (ip == null) {
			if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
				ip = request.getHeader("Proxy-Client-IP");
			}
			if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
				ip = request.getHeader("WL-Proxy-Client-IP");
			}
			if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
				ip = request.getHeader("HTTP_CLIENT_IP");
			}
			if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
				ip = request.getHeader("HTTP_X_FORWARDED_FOR");
			}
			if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
				ip = request.getRemoteAddr();
			}
		}
		return ip;
	}

	protected Map<String, Object> result(String code, Object msg) {
		Map<String, Object> resultMap = new HashMap<>();
		resultMap.put(STATUS, code);
		resultMap.put(MESSAGE, msg);
		return resultMap;
	}

}
