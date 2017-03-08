package com.ds.common.util;

import java.math.BigDecimal;

import org.apache.commons.lang.StringUtils;

public class StringUtilTest {

	public static void main(String[] args){
		System.out.println(StringUtil.getNumeric("0,6,9,6,5"));
		
		System.out.println(StringUtil.getNumeric("20170120-053"));
		
		System.out.println(StringUtils.substring("2017010510", 8));
		
		Long term = 201L;
		Long newOpenTerm = 200L;
		if (new BigDecimal(term).compareTo(new BigDecimal(newOpenTerm)) <= 0) {
			System.out.println("1");
		}else{
			System.out.println("2");
		}
	}
}
