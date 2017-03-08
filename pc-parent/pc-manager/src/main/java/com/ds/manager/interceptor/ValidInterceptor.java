package com.ds.manager.interceptor;

import java.io.BufferedWriter;
import java.io.IOException;
import java.io.OutputStreamWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.context.support.WebApplicationContextUtils;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import com.ds.common.controller.base.BaseController;
import com.ds.common.task.UrlConfigVo;
import com.ds.common.util.EncUtil;
import com.ds.common.util.JSONUtils;
import com.ds.common.util.StringUtil;
import com.ds.redis.api.RedisService;
import com.ds.redis.api.impl.RedisServiceImpl;
import com.ds.redis.key.KeyConfig;

import io.swagger.models.HttpMethod;

public class ValidInterceptor extends BaseController implements HandlerInterceptor, KeyConfig {

	private Logger logger = LoggerFactory.getLogger(this.getClass());

	private RedisService redisService;

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
		logger.info("method = {}, uri = {}, url = {}", request.getMethod(), request.getRequestURI(), request.getRequestURL().toString());
		if (HttpMethod.GET.name().equals(request.getMethod()) || request.getRequestURI().contains("swagger")) {
			return true;
		}
		String timestamp = request.getHeader("timestamp");
		String siteId = request.getHeader("siteId");
		String encrypt = request.getHeader("encrypt");
		if (StringUtil.isNull(timestamp) || StringUtil.isNull(encrypt)) {
			md5Process(request, response, timestamp, siteId, encrypt, MD5_IS_ERROR, "md5 param is null");
			return false;
		}
		if (this.redisService == null) {
			redisService = WebApplicationContextUtils.getRequiredWebApplicationContext(request.getServletContext()).getBean(RedisServiceImpl.class);
		}
		//		UrlConfigVo urlConfigVo = this.commonTask.getSiteIdUrlMap().get(Integer.valueOf(siteId));
		String urlConfigStr = this.redisService.get(KEY_URL_CONFIG_SITE_ID + siteId);
		if (StringUtil.isNull(urlConfigStr)) {
			logger.info("siteId = {}, 不存在urlconfig", siteId);
			md5Process(request, response, timestamp, siteId, encrypt, SITEID_OR_LIVE_NOEXIST, "siteId is null or no exist");
			return false;
		}
		UrlConfigVo urlConfigVo = JSONUtils.json2Bean(urlConfigStr, UrlConfigVo.class);
		if (urlConfigVo == null) {
			md5Process(request, response, timestamp, siteId, encrypt, SITEID_OR_LIVE_NOEXIST, "siteId is null or no exist");
			return false;
		}
		if (!encrypt.equalsIgnoreCase(EncUtil.toMD5(timestamp + urlConfigVo.getKeyb()))) {
			logger.info("明文 = {}", (timestamp + urlConfigVo.getKeyb()));
			md5Process(request, response, timestamp, siteId, encrypt, MD5_IS_ERROR, "md5 is error");
			return false;
		}
		return true;
	}

	private void md5Process(HttpServletRequest request, HttpServletResponse response, String timestamp, String siteId, String encrypt, String status, Object msg) throws IOException {
		String ip = this.getIpAddr(request);
		logger.info("ip = {}, timestamp = {}, siteId = {}, encrypt = {}", timestamp, siteId, encrypt, ip);
		BufferedWriter writer = new BufferedWriter(new OutputStreamWriter(response.getOutputStream()));
		writer.write(JSONUtils.map2Json(result(status, msg)));
		writer.flush();
		writer.close();
	}

	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler, ModelAndView modelAndView) throws Exception {
		logger.info("postHandle");
		modelAndView = new ModelAndView();
		modelAndView.addAllObjects(result(ERROR, "md5 is error"));
	}

	@Override
	public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex) throws Exception {
		logger.info("afterCompletion");
	}

}
