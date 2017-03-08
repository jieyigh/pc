package com.ds.common.util;

import java.util.Date;

import org.apache.commons.lang.time.DateUtils;

import com.ds.common.constants.Constants.GameType;

public class LottoUtilTest {

	public static void main(String[] args) {
		float f = 3.5f;
		System.out.println(f*60);
		
		
		//xy28	800947	2017-01-02 11:52:30	2017-01-02 11:53:00
		String s = LottoUtil.getCloseDateByTerm(800948, "800947", "2017-01-02 11:55:00", "xy28");
		System.out.println(s);
		
		String ss = LottoUtil.getCloseDate(800948, "800947", "2017-01-02 11:55:00", Float.valueOf("3.5"));
		System.out.println(ss);
		
		
		Date openTime = DateUtils.addMinutes(LottoUtil.getCqOpenTime(4),74*Integer.valueOf(LottoUtil.getMins(GameType.新疆二八.getKey(), 4)));
		
		System.out.println("openTime:"+openTime);
		System.out.println(LottoUtil.getCqOpenTime(4));
		System.out.println(LottoUtil.getCqOpenTime(8));
		
		
		System.out.println(testGetMins("cq28", 4));
		
		
		
		System.out.println(LottoUtil.getCloseDate(20170213097L, "20170213024", "2017-02-12 22:00:00", Float.valueOf(LottoUtil.getMins(GameType.重庆二八.getKey(), 4))));
		
		
		System.out.println(LottoUtil.getCloseDate(20170213119L, "20170213024", "2017-02-13 22:00:00", Float.valueOf(LottoUtil.getMins(GameType.重庆二八.getKey(), 4))));
	}
	
	
	public static String testGetMins(String gameType, Integer timeZone) {
		return LottoUtil.getMins(gameType, timeZone);
	}

}
