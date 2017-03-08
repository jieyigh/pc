package com.ds.common.util;

public class EncUtilTest {

	public static void main(String[] args) {

		Long timestamp = 1478874192135L;
				
		String keyb = "qqqq";
		
		String enc = EncUtil.toMD5(timestamp + keyb);
		
		System.out.println(enc);
	}

}
