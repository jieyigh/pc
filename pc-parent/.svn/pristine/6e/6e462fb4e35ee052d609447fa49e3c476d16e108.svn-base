package com.ds.common.util;

import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class StringUtil {

	public static boolean isNull(String msg) {
		return msg == null || "".equals(msg) || "null".equals(msg);
	}

	public static boolean isNumeric(String msg) {
		if (isNull(msg)) {
			return false;
		}
		int length = msg.length();
		for (int i = 0; i < length; i++) {
			if (!Character.isDigit(msg.charAt(i))) {
				return false;
			}
		}
		return true;
	}
	
	
	public static String getNumeric (String s){
		String regEx="[^0-9]";   
		Pattern p = Pattern.compile(regEx);   
		Matcher m = p.matcher(s);   
		return m.replaceAll("").trim();
	}
	
}
