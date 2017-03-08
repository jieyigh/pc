package com.ds.manager.aspect;

import java.util.Arrays;
import java.util.Date;
import java.util.Enumeration;

import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.Logger;
import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.annotation.AfterReturning;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Before;
import org.aspectj.lang.annotation.Pointcut;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.annotation.Order;
import org.springframework.stereotype.Component;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import com.alibaba.fastjson.JSONObject;
import com.ds.common.controller.base.BaseController;
import com.ds.entity.Log;
import com.ds.log.service.LogService;

@Aspect
@Order(5)
@Component
public class WebLogAspect extends BaseController{
	private Logger logger = Logger.getLogger(getClass());
	
	@Autowired
	private LogService logService;

	@Pointcut("execution(* com.ds.manager..*.*.*Controller.edit*(..))")
	public void webLog() {
		System.out.println("in ......");
	}

	@Before("webLog()")
	public void doBefore(JoinPoint joinPoint) throws Throwable {
		/*// 接收到请求，记录请求内容
		ServletRequestAttributes attributes = (ServletRequestAttributes) RequestContextHolder.getRequestAttributes();
		HttpServletRequest request = attributes.getRequest();
		// 记录下请求内容
		logger.info("URL : " + request.getRequestURL().toString());
		logger.info("HTTP_METHOD : " + request.getMethod());
		logger.info("IP : " + request.getRemoteAddr());
		logger.info("CLASS_METHOD : " + joinPoint.getSignature().getDeclaringTypeName() + "."
				+ joinPoint.getSignature().getName());
		logger.info("ARGS : " + Arrays.toString(joinPoint.getArgs()));
		//获取所有参数方法一：
        Enumeration<String> enu=request.getParameterNames(); 
        while(enu.hasMoreElements()){ 
            String paraName=(String)enu.nextElement(); 
            logger.info(paraName+": "+request.getParameter(paraName)); 
        } */
	}

	@AfterReturning(returning = "ret", pointcut = "webLog()")
	public void doAfterReturning(JoinPoint joinPoint,Object ret) throws Throwable {
		
		// 接收到请求，记录请求内容
		ServletRequestAttributes attributes = (ServletRequestAttributes) RequestContextHolder.getRequestAttributes();
		HttpServletRequest request = attributes.getRequest();
		
		String url = request.getRequestURL().toString();
		String httpMethod = request.getMethod();
		String ip = request.getRemoteAddr();
		String classMethod = joinPoint.getSignature().getDeclaringTypeName() + "."
				+ joinPoint.getSignature().getName();
		String args = Arrays.toString(joinPoint.getArgs());
		String response = JSONObject.toJSONString(ret);
		
		// 记录下请求内容
		logger.info("URL : " + url);
		logger.info("HTTP_METHOD : " + httpMethod);
		logger.info("IP : " + ip);
		logger.info("CLASS_METHOD : " + classMethod);
		logger.info("ARGS : " + args);
				
		// 处理完请求，返回内容
		logger.info("RESPONSE : " + response);
		
		Log log = new Log();
		log.setArgs(args);
		log.setClassMethod(classMethod);
		log.setCreateTime(new Date());
		log.setHttpMethod(httpMethod);
		log.setIp(ip);
		log.setResponse(response);
		log.setUrl(url);
		logService.edit(log);
	}
	
}
