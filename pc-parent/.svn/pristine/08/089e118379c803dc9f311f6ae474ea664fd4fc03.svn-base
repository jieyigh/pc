package com.ds.common.util;

import java.util.Iterator;
import java.util.List;
import java.util.Set;

import org.apache.commons.lang.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;

import javax.validation.ConstraintViolation;
import javax.validation.Validation;
import javax.validation.Validator;

public class ValidateUtil {
	private static final Logger logger = LoggerFactory.getLogger(ValidateUtil.class);

	public static String getErrors(BindingResult result) {
		StringBuilder sb = new StringBuilder();
		List<FieldError> list = result.getFieldErrors();
		int i = 0;
		for (FieldError error : list) {
			logger.info("error.getField():" + error.getField());
			logger.info("error.getDefaultMessage():" + error.getDefaultMessage());
			sb.append(error.getDefaultMessage());
			if (i != list.size() - 1) {
				sb.append(",");
			}
			i++;
		}
		return sb.toString();
	}

	public static String validateModel(Object obj, Class<?>... groups) { // 验证某一个对象
		StringBuffer buffer = new StringBuffer(); // 用于存储验证后的错误信息
		Validator validator = Validation.buildDefaultValidatorFactory().getValidator();
		Set<ConstraintViolation<Object>> constraintViolations = validator.validate(obj, groups);// 验证某个对象,，其实也可以只验证其中的某一个属性的
		Iterator<ConstraintViolation<Object>> iter = constraintViolations.iterator();
		while (iter.hasNext()) {
			String message = iter.next().getMessage();
			buffer.append(message);
			buffer.append(",");
		}
		String str = buffer.toString();
		if (StringUtils.isEmpty(str)) {
			return null;
		}
		return buffer.toString().substring(0, buffer.length() - 1);
	}

	public static String validateProperty(Object obj, String propertyName, Class<?>... groups) { // 验证某一个对象
		StringBuffer buffer = new StringBuffer(); // 用于存储验证后的错误信息
		Validator validator = Validation.buildDefaultValidatorFactory().getValidator();
		Set<ConstraintViolation<Object>> constraintViolations = validator.validateProperty(obj, propertyName, groups);// 验证某个对象,，其实也可以只验证其中的某一个属性的
		Iterator<ConstraintViolation<Object>> iter = constraintViolations.iterator();
		while (iter.hasNext()) {
			String message = iter.next().getMessage();
			buffer.append(message);
			buffer.append(",");
		}
		String str = buffer.toString();
		if (StringUtils.isEmpty(str)) {
			return null;
		}
		return buffer.toString().substring(0, buffer.length() - 1);
	}
}
