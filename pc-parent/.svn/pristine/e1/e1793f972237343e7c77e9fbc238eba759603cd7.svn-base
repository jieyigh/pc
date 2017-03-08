package com.ds.common.util;

import java.util.Arrays;
import java.util.Date;
import java.util.List;

import org.apache.commons.lang.StringUtils;
import org.apache.commons.lang.time.DateUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.ds.common.constants.Constants.GameType;
import com.ds.common.constants.Constants.TimeZone;

public class LottoUtil {

	private final static Logger logger = LoggerFactory.getLogger(LottoUtil.class);

	private static List<Integer> redList = Arrays.asList(1, 2, 7, 8, 12, 13, 18, 19, 23, 24);
	private static List<Integer> blueList = Arrays.asList(3, 4, 9, 10, 14, 15, 20, 25, 26);
	private static List<Integer> greenList = Arrays.asList(0, 5, 6, 11, 16, 17, 21, 22, 27);

	public static String getGameTypeByTableName(String tableName) {
		int i = tableName.indexOf("_", "pc_bet_info".length());
		int j = tableName.indexOf("_", i + 1);
		return tableName.substring(i + 1, j);
	}

	public static Date getCqOpenTime(Integer timeZone) {
		Date nowDate = new Date();
		if (timeZone.intValue() == TimeZone.美东时间.getKey()) {
			int hour = nowDate.getHours();
			if (hour >= 22) {
				//当天的22:00
				return DateUtil.parse(DateUtil.YY_MM_DD_HH_MM_SS, DateUtil.format(DateUtil.YY_MM_DD, nowDate) + " 22:00:00");
			}
			if (hour >= 0 && hour < 15) {
				//昨天的22:00
				return DateUtil.parse(DateUtil.YY_MM_DD_HH_MM_SS, DateUtil.format(DateUtil.YY_MM_DD, DateUtils.addDays(nowDate, -1)) + " 22:00:00");
			}
		}
		if (timeZone.intValue() == TimeZone.北京时间.getKey()) {
			Date nowDate12 = DateUtils.addHours(nowDate, 12);
			int hour = nowDate12.getHours();

			if (hour >= 10 && hour < 24) {
				return DateUtil.parse(DateUtil.YY_MM_DD_HH_MM_SS, DateUtil.format(DateUtil.YY_MM_DD, nowDate12) + " 10:00:00");
			}
			if (hour < 10) {
				return DateUtil.parse(DateUtil.YY_MM_DD_HH_MM_SS, DateUtil.format(DateUtil.YY_MM_DD, DateUtils.addDays(nowDate12, -1)) + " 10:00:00");
			}
		}
		return null;
	}

	public static String getMins(String gameType, Integer timeZone) {
		String mins = "0";
		switch (gameType) {
		case "xy28":
			mins = "5";
			break;
		case "keno28":
			mins = "3.5";
			break;
		case "cq28":
			Date nowDate = new Date();
			Date bjDate = nowDate;
			if (timeZone.intValue() == TimeZone.美东时间.getKey().intValue()) {
				bjDate = DateUtils.addHours(nowDate, 12);
			}
			int hour = bjDate.getHours();
			int min = bjDate.getMinutes();
			if (hour >= 10 && hour < 22) {
				mins = "10";
			} else {
				mins = "5";
				if(hour==22){
					if(min<4){
						mins="10";
					}
				}
			}
			break;
		case "xj28":
			mins = "10";
			break;
		default:
			break;
		}
		return mins;
	}

	public static String getCloseDate(long term, String initterm, String time, float mins) {
		try {
			term -= 1;
			Date dateA = DateUtil.parse(DateUtil.YY_MM_DD_HH_MM_SS, time);
			Long inittermB = Long.valueOf(initterm);
			Long between = term - inittermB;
			float termSeconds = Float.valueOf(mins * 60 + "");
			int termSecondsl = (int) termSeconds;
			Long seconds = between * termSecondsl;
			String dates = DateUtil.format(DateUtil.YY_MM_DD_HH_MM_SS, DateUtils.addSeconds(dateA, seconds.intValue() - 30 + termSecondsl));
			return dates;
		} catch (Exception e) {
			logger.error("getCloseDate() 出错 : ", e);
			return null;
		}
	}

	public static String getCloseDateByTerm(long term, String initterm, String time, String gameType) {
		if (gameType.equals(GameType.幸运二八.getKey())) {
			return getXyCloseDateByTerm(term, initterm, time);
		}
		if (gameType.equals(GameType.加拿大二八.getKey())) {
			return getKenoCloseDateByTerm(term, initterm, time);
		}
		return null;
	}

	private static String getXyCloseDateByTerm(long term, String initterm, String time) {
		try {
			term -= 1;
			Date dateA = DateUtil.parse(DateUtil.YY_MM_DD_HH_MM_SS, time);
			Long inittermB = Long.valueOf(initterm);
			Long between = term - inittermB;
			Long seconds = between * 300;
			String dates = DateUtil.format(DateUtil.YY_MM_DD_HH_MM_SS, DateUtils.addSeconds(dateA, seconds.intValue() - 30 + 300));
			return dates;
		} catch (Exception e) {
			logger.error("xy28 getCloseDateByTerm() 出错 : ", e);
			return null;
		}

	}

	private static String getKenoCloseDateByTerm(long term, String initterm, String time) {
		try {
			term -= 1;
			Date dateA = DateUtil.parse(DateUtil.YY_MM_DD_HH_MM_SS, time);
			Long inittermB = Long.valueOf(initterm);
			Long between = term - inittermB;
			Long seconds = between * 210;
			String dates = DateUtil.format(DateUtil.YY_MM_DD_HH_MM_SS, DateUtils.addSeconds(dateA, seconds.intValue() - 30 + 210));
			return dates;
		} catch (Exception e) {
			logger.error("keno28 getCloseDateByTerm() 出错 : ", e);
			return null;
		}

	}

	public static String getNumberStrByNone(String lotteryNumber, String gameType) {
		if (gameType.equals(GameType.幸运二八.getKey())) {
			return getLuckyNumberStrByNone(lotteryNumber);
		}
		if (gameType.equals(GameType.加拿大二八.getKey())) {
			return getKenoNumberStrByNone(lotteryNumber);
		}
		if (gameType.equals(GameType.新疆二八.getKey()) || gameType.equals(GameType.重庆二八.getKey())) {
			return getXjAndCqNumberStrByNone(lotteryNumber);
		}
		return null;
	}
	
	public static String getNumberStr(String lotteryNumber) {
		String num = StringUtil.getNumeric(lotteryNumber);
		String numBefore3 = StringUtils.substring(num, 0, 3);
		return numBefore3;
	}

	public static String getXjAndCqNumberStrByNone(String lotteryNumber) {
		String num = StringUtil.getNumeric(lotteryNumber);
		String numBefore3 = StringUtils.substring(num, 0, 3);
		return numBefore3;
	}

	public static String getKenoNumberStrByNone(String lotteryNumber) {
		String[] split = lotteryNumber.split(",");
		Integer num = null;
		for (int i = 0; i < split.length; i++) {
			num = Integer.valueOf(split[i]);
			if (num > 0 && num < 10) {
				split[i] = "0" + num;
			}
		}
		Arrays.sort(split);
		int s1 = 0, s2 = 0, s3 = 0;

		s1 = Integer.valueOf(split[1]) + Integer.valueOf(split[4]) + Integer.valueOf(split[7]) + Integer.valueOf(split[10]) + Integer.valueOf(split[13]) + Integer.valueOf(split[16]);
		s2 = Integer.valueOf(split[2]) + Integer.valueOf(split[5]) + Integer.valueOf(split[8]) + Integer.valueOf(split[11]) + Integer.valueOf(split[14]) + Integer.valueOf(split[17]);
		s3 = Integer.valueOf(split[3]) + Integer.valueOf(split[6]) + Integer.valueOf(split[9]) + Integer.valueOf(split[12]) + Integer.valueOf(split[15]) + Integer.valueOf(split[18]);
		return s1 % 10 + "" + s2 % 10 + "" + s3 % 10;
	}

	public static String getLuckyNumberStrByNone(String lotteryNumber) {
		String[] split = lotteryNumber.split(",");
		Integer num = null;
		for (int i = 0; i < split.length; i++) {
			num = Integer.valueOf(split[i]);
			if (num > 0 && num < 10) {
				split[i] = "0" + num;
			}
		}
		Arrays.sort(split);
		int s1 = 0, s2 = 0, s3 = 0;
		for (int i = 0; i < split.length; i++) {
			if (i < 6) {
				s1 += Integer.valueOf(split[i]);
			}
			if (i >= 6 && i < 12) {
				s2 += Integer.valueOf(split[i]);
			}
			if (i >= 12 && i < 18) {
				s3 += Integer.valueOf(split[i]);
			}
		}
		return s1 % 10 + "" + s2 % 10 + "" + s3 % 10;
	}

	public static String getNumber(int[] arr) {
		Arrays.sort(arr);
		int sum1 = 0;
		int sum2 = 0;
		int sum3 = 0;
		int n = 6;
		for (int i = 0; i <= n - 1; i++) {
			sum1 += arr[i];
		}
		sum1 = sum1 % 10;
		for (int i = 6; i <= n * 2 - 1; i++) {
			sum2 += arr[i];
		}
		sum2 = sum2 % 10;
		for (int i = 12; i <= n * 3 - 1; i++) {
			sum3 += arr[i];
		}
		sum3 = sum3 % 10;
		String result = sum1 + "" + sum2 + "" + sum3;

		return result;
	}

	public static int getNumberSum(String result) {
		int b = Integer.valueOf(result) / 100; // 百位
		int s = Integer.valueOf(result) % 100 / 10; // 十位
		int g = Integer.valueOf(result) % 10; // 个位
		int LuckNum = b + s + g;
		return LuckNum;
	}

	public static boolean isStraight(String formatNumber) {
		if (StringUtil.isNull(formatNumber)) {
			return false;
		}
		int firstNumber = Integer.valueOf(formatNumber.charAt(0));
		int secondNumber = Integer.valueOf(formatNumber.charAt(1));
		int threeNumber = Integer.valueOf(formatNumber.charAt(2));
		if ((secondNumber == firstNumber + 1) && (threeNumber == secondNumber + 1)) {
			return true;
		}
		if ((secondNumber == firstNumber - 1) && (threeNumber == secondNumber - 1)) {
			return true;
		}
		return false;
	}

	public static boolean isLeopard(String formatNumber) {
		if (StringUtil.isNull(formatNumber)) {
			return false;
		}
		int firstNumber = Integer.valueOf(formatNumber.charAt(0));
		int secondNumber = Integer.valueOf(formatNumber.charAt(1));
		int threeNumber = Integer.valueOf(formatNumber.charAt(2));
		if ((firstNumber == secondNumber) && (secondNumber == threeNumber)) {
			return true;
		}
		return false;
	}

	public static boolean isPair(String formatNumber) {
		if (StringUtil.isNull(formatNumber)) {
			return false;
		}
		int firstNumber = Integer.valueOf(formatNumber.charAt(0));
		int secondNumber = Integer.valueOf(formatNumber.charAt(1));
		int threeNumber = Integer.valueOf(formatNumber.charAt(2));
		return firstNumber == secondNumber || secondNumber == threeNumber || firstNumber == threeNumber;
	}

	public static boolean isRed(Integer num) {
		return redList.contains(num);
	}

	public static boolean isBlue(Integer num) {
		return blueList.contains(num);
	}

	public static boolean isGreen(Integer num) {
		return greenList.contains(num);
	}
}
