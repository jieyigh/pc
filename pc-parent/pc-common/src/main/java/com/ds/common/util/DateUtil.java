package com.ds.common.util;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.Locale;
import java.util.SimpleTimeZone;
import java.util.TimeZone;

public class DateUtil {

	public static String YY_MM_DD_HH_MM_SS = "yyyy-MM-dd HH:mm:ss";
	public static String YY_MM_DD_HH_MM = "yyyy-MM-dd HH:mm";
	public static String YY_MM_DD = "yyyy-MM-dd";
	public static String YYMMDDHH = "yyyyMMdd";
	public static String YYMMDD = "yyyyMMdd";
	public static String MM_DD_HH_MM = "MM-dd HH:mm";
	public static String YY_MM_DD_HH_MM_SS_2 = "yyyy/MM/dd HH:mm:ss";
	public static String YY_MM_DD_HH_MM_2 = "yyyy/MM/dd HH:mm";

	public static SimpleDateFormat sdf1 = new SimpleDateFormat("yyyyMMdd");

	public static SimpleDateFormat englishSdf = new SimpleDateFormat("MMM d, yyyy h:m:s aa", Locale.ENGLISH);
	
	public static Date changeTimeZone(Date date, TimeZone oldZone, TimeZone newZone) {  
	    Date dateTmp = null;  
	    if (date != null) {  
	        int timeOffset = oldZone.getRawOffset() - newZone.getRawOffset();  
	        dateTmp = new Date(date.getTime() - timeOffset);  
	    }  
	    return dateTmp;  
	}  

	public static Date getDateByEngString(String source) throws Exception {
		return englishSdf.parse(source);
	}

	// 获取当前时间
	public static String getCurDate() {
		return sdf1.format(new Date(System.currentTimeMillis()));
	}

	public static String format(String format, Date date) {
		return new SimpleDateFormat(format).format(date);
	}

	public static Date parse(String format, String date) {
		try {
			return new SimpleDateFormat(format).parse(date);
		} catch (ParseException e) {
			e.printStackTrace();
		}
		return null;
	}

	/**
	 * 根据连接符join 连接日期
	 *
	 * @param differDay
	 *            相差的天数
	 * @param join
	 *            2016-05-31
	 */
	public static String getDaysAgo(int interval, String join) {
		Date date = new Date();
		long time = (date.getTime() / 1000) - interval * 60 * 60 * 24;
		date.setTime(time * 1000);
		SimpleDateFormat format = new SimpleDateFormat("yyyy" + join + "MM" + join + "dd");
		try {
			return format.format(date);
		} catch (Exception ex) {
			System.out.println(ex.getMessage());
		}
		return "";
	}
	
	public static String getFormatedDateString(float timeZoneOffset){
        if (timeZoneOffset > 13 || timeZoneOffset < -12) {
            timeZoneOffset = 0;
        }
        
        int newTime=(int)(timeZoneOffset * 60 * 60 * 1000);
        TimeZone timeZone;
        String[] ids = TimeZone.getAvailableIDs(newTime);
        if (ids.length == 0) {
            timeZone = TimeZone.getDefault();
        } else {
            timeZone = new SimpleTimeZone(newTime, ids[0]);
        }
    
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        sdf.setTimeZone(timeZone);
        return sdf.format(new Date());
    }

	/**
	 * 根据连接符join 连接日期
	 *
	 * @param differDay
	 *            相差的天数
	 * @param join
	 *            2016-05-31
	 */
	public static String getTodayDateDifferDay(int differDay, String join) {
		Calendar c = Calendar.getInstance();
		int year = c.get(Calendar.YEAR);
		int month = c.get(Calendar.MONTH) + 1;
		int day = c.get(Calendar.DAY_OF_MONTH) + differDay;
		return year + join + (month < 10 ? "0" + month : month) + join + (day < 10 ? "0" + day : day);
	}

}
