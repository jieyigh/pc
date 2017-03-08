package com.ds.common.constants;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.StringUtils;

public class Constants {

	public static final String TABLE_CONCAT = "_";
	
	public static enum GameTypeOriginal {
		重庆时时彩("cqssc", "重庆时时彩"), 新疆时时彩("xjssc", "新疆时时彩");

		private final String key;
		private final String value;

		private GameTypeOriginal(String key, String value) {
			this.key = key;
			this.value = value;
		}

		public String getKey() {
			return key;
		}

		public String getValue() {
			return value;
		}

	}

	public static enum GameTypeTime {
		幸运二八("xy28", -10), 加拿大二八("keno28", -7), 重庆二八("cq28", -20), 新疆二八("xj28", -20);

		private final String key;
		private final Integer value;

		private GameTypeTime(String key, Integer value) {
			this.key = key;
			this.value = value;
		}

		public String getKey() {
			return key;
		}

		public Integer getValue() {
			return value;
		}

		public static GameTypeTime getValue(String key) {
			for (GameTypeTime inst : values()) {
				if (key == inst.key || key.equals(inst.key))
					return inst;
			}
			throw new IllegalArgumentException("不支持的常量：" + key);
		}

	}

	public static enum GameType {
		幸运二八("xy28", "北京28"), 加拿大二八("keno28", "加拿大28"), 重庆二八("cq28", "重庆28"), 新疆二八("xj28", "新疆28");

		private final String key;
		private final String value;

		private GameType(String key, String value) {
			this.key = key;
			this.value = value;
		}

		public String getKey() {
			return key;
		}

		public String getValue() {
			return value;
		}

		public static String getKeyByValue(String v) {
			if (StringUtils.isEmpty(v)) {
				throw new RuntimeException("value为空!");
			}
			String key = null;
			GameType[] values = GameType.values();
			for (GameType combobox : values) {
				if (combobox.getValue().equals(v)) {
					key = combobox.getKey();
					break;
				}
			}

			if (StringUtils.isEmpty(key)) {
				throw new RuntimeException("传入的value不存在!");
			}
			return key;
		}

		public static GameType getValue(String key) {
			for (GameType inst : values()) {
				if (key == inst.key || key.equals(inst.key))
					return inst;
			}
			throw new IllegalArgumentException("不支持的常量：" + key);
		}

		public static List<Map<String, String>> toMapList() {
			List<Map<String, String>> lists = new ArrayList<Map<String, String>>();
			GameType[] values = GameType.values();
			for (GameType v : values) {
				Map<String, String> map = new HashMap<String, String>();
				map.put("type", v.getKey());
				map.put("name", v.getValue());
				lists.add(map);
			}
			return lists;
		}

		public static Map<String, String> toMap() {
			Map<String, String> map = new HashMap<String, String>();
			GameType[] values = GameType.values();
			for (GameType v : values) {
				map.put(v.getKey(), v.getValue());
			}
			return map;
		}

	}

	public static enum GameTypeToUrl {
		幸运二八("bjkuaile8", "北京28"), 加拿大二八("cnd28", "加拿大28");

		private final String key;
		private final String value;

		private GameTypeToUrl(String key, String value) {
			this.key = key;
			this.value = value;
		}

		public String getKey() {
			return key;
		}

		public String getValue() {
			return value;
		}

		public static String getKeyByValue(String v) {
			if (StringUtils.isEmpty(v)) {
				throw new RuntimeException("value为空!");
			}
			String key = null;
			GameTypeToUrl[] values = GameTypeToUrl.values();
			for (GameTypeToUrl combobox : values) {
				if (combobox.getValue().equals(v)) {
					key = combobox.getKey();
					break;
				}
			}

			if (StringUtils.isEmpty(key)) {
				throw new RuntimeException("传入的value不存在!");
			}
			return key;
		}

		public static GameTypeToUrl getValue(String key) {
			for (GameTypeToUrl inst : values()) {
				if (key == inst.key || key.equals(inst.key))
					return inst;
			}
			throw new IllegalArgumentException("不支持的常量：" + key);
		}

	}

	public static enum GameTypeToPC588 {
		幸运二八("pc28", "北京28"), 加拿大二八("jnd28", "加拿大28");

		private final String key;
		private final String value;

		private GameTypeToPC588(String key, String value) {
			this.key = key;
			this.value = value;
		}

		public String getKey() {
			return key;
		}

		public String getValue() {
			return value;
		}

		public static String getKeyByValue(String v) {
			if (StringUtils.isEmpty(v)) {
				throw new RuntimeException("value为空!");
			}
			String key = null;
			GameTypeToPC588[] values = GameTypeToPC588.values();
			for (GameTypeToPC588 combobox : values) {
				if (combobox.getValue().equals(v)) {
					key = combobox.getKey();
					break;
				}
			}

			if (StringUtils.isEmpty(key)) {
				throw new RuntimeException("传入的value不存在!");
			}
			return key;
		}

		public static GameTypeToPC588 getValue(String key) {
			for (GameTypeToPC588 inst : values()) {
				if (key == inst.key || key.equals(inst.key))
					return inst;
			}
			throw new IllegalArgumentException("不支持的常量：" + key);
		}

	}
	
	
	
	public static enum GameTypeToAG {
		幸运二八("32", "北京28"), 加拿大二八("33", "加拿大28");

		private final String key;
		private final String value;

		private GameTypeToAG(String key, String value) {
			this.key = key;
			this.value = value;
		}

		public String getKey() {
			return key;
		}

		public String getValue() {
			return value;
		}

		public static String getKeyByValue(String v) {
			if (StringUtils.isEmpty(v)) {
				throw new RuntimeException("value为空!");
			}
			String key = null;
			GameTypeToAG[] values = GameTypeToAG.values();
			for (GameTypeToAG combobox : values) {
				if (combobox.getValue().equals(v)) {
					key = combobox.getKey();
					break;
				}
			}

			if (StringUtils.isEmpty(key)) {
				throw new RuntimeException("传入的value不存在!");
			}
			return key;
		}

		public static GameTypeToAG getValue(String key) {
			for (GameTypeToAG inst : values()) {
				if (key == inst.key || key.equals(inst.key))
					return inst;
			}
			throw new IllegalArgumentException("不支持的常量：" + key);
		}

	}
	
	

	public static enum GameTypeToZAO {
		北京二八("xy28", "北京28"), 加拿大二八("jnd28", "加拿大28"), 重庆时时彩("cqssc", "重庆时时彩");

		private final String key;
		private final String value;

		private GameTypeToZAO(String key, String value) {
			this.key = key;
			this.value = value;
		}

		public String getKey() {
			return key;
		}

		public String getValue() {
			return value;
		}

		public static String getKeyByValue(String v) {
			if (StringUtils.isEmpty(v)) {
				throw new RuntimeException("value为空!");
			}
			String key = null;
			GameTypeToZAO[] values = GameTypeToZAO.values();
			for (GameTypeToZAO combobox : values) {
				if (combobox.getValue().equals(v)) {
					key = combobox.getKey();
					break;
				}
			}

			if (StringUtils.isEmpty(key)) {
				throw new RuntimeException("传入的value不存在!");
			}
			return key;
		}

		public static GameTypeToZAO getValue(String key) {
			for (GameTypeToZAO inst : values()) {
				if (key == inst.key || key.equals(inst.key))
					return inst;
			}
			throw new IllegalArgumentException("不支持的常量：" + key);
		}

	}

	public static enum GameTypeTo168 {
		幸运二八("10014", "北京28"), 加拿大二八("10041", "加拿大28"), 重庆二八("10011", "重庆28"), 新疆二八("10022", "新疆28");

		private final String key;
		private final String value;

		private GameTypeTo168(String key, String value) {
			this.key = key;
			this.value = value;
		}

		public String getKey() {
			return key;
		}

		public String getValue() {
			return value;
		}

		public static String getKeyByValue(String v) {
			if (StringUtils.isEmpty(v)) {
				throw new RuntimeException("value为空!");
			}
			String key = null;
			GameTypeTo168[] values = GameTypeTo168.values();
			for (GameTypeTo168 combobox : values) {
				if (combobox.getValue().equals(v)) {
					key = combobox.getKey();
					break;
				}
			}

			if (StringUtils.isEmpty(key)) {
				throw new RuntimeException("传入的value不存在!");
			}
			return key;
		}

		public static GameTypeTo168 getValue(String key) {
			for (GameTypeTo168 inst : values()) {
				if (key == inst.key || key.equals(inst.key))
					return inst;
			}
			throw new IllegalArgumentException("不支持的常量：" + key);
		}

	}
	
	
	
	public static enum GameTypeToCQShiCai {
		重庆二八("10002", "重庆28"), 新疆二八("10004", "新疆28");

		private final String key;
		private final String value;

		private GameTypeToCQShiCai(String key, String value) {
			this.key = key;
			this.value = value;
		}

		public String getKey() {
			return key;
		}

		public String getValue() {
			return value;
		}

		public static String getKeyByValue(String v) {
			if (StringUtils.isEmpty(v)) {
				throw new RuntimeException("value为空!");
			}
			String key = null;
			GameTypeToCQShiCai[] values = GameTypeToCQShiCai.values();
			for (GameTypeToCQShiCai combobox : values) {
				if (combobox.getValue().equals(v)) {
					key = combobox.getKey();
					break;
				}
			}

			if (StringUtils.isEmpty(key)) {
				throw new RuntimeException("传入的value不存在!");
			}
			return key;
		}

		public static GameTypeToCQShiCai getValue(String key) {
			for (GameTypeToCQShiCai inst : values()) {
				if (key == inst.key || key.equals(inst.key))
					return inst;
			}
			throw new IllegalArgumentException("不支持的常量：" + key);
		}

	}
	

	public static enum GameTypeInt {
		幸运二八(1, "xy28"), 加拿大二八(2, "keno28");

		private final Integer key;
		private final String value;

		private GameTypeInt(Integer key, String value) {
			this.key = key;
			this.value = value;
		}

		public Integer getKey() {
			return key;
		}

		public String getValue() {
			return value;
		}

		public static Integer getKeyByValue(String v) {
			if (StringUtils.isEmpty(v)) {
				throw new RuntimeException("value为空!");
			}
			Integer key = null;
			GameTypeInt[] values = GameTypeInt.values();
			for (GameTypeInt combobox : values) {
				if (combobox.getValue().equals(v)) {
					key = combobox.getKey();
					break;
				}
			}

			if (key == null) {
				throw new RuntimeException("传入的value不存在!");
			}
			return key;
		}

		public static GameTypeInt getValue(Integer key) {
			for (GameTypeInt inst : values()) {
				if (key == inst.key || key.equals(inst.key))
					return inst;
			}
			throw new IllegalArgumentException("不支持的常量：" + key);
		}

	}

	public static enum NormalState {
		启用(50, "启用"), 停用(-50, "停用");

		private final Integer key;
		private final String value;

		private NormalState(Integer key, String value) {
			this.key = key;
			this.value = value;
		}

		public Integer getKey() {
			return key;
		}

		public String getValue() {
			return value;
		}

		public static Integer getKeyByValue(String v) {
			if (StringUtils.isEmpty(v)) {
				throw new RuntimeException("value为空!");
			}
			Integer key = null;
			NormalState[] values = NormalState.values();
			for (NormalState combobox : values) {
				if (combobox.getValue().equals(v)) {
					key = combobox.getKey();
					break;
				}
			}

			if (key == null) {
				throw new RuntimeException("传入的value不存在!");
			}
			return key;
		}

		public static NormalState getValue(Integer key) {
			for (NormalState inst : values()) {
				if (key == inst.key || key.equals(inst.key))
					return inst;
			}
			throw new IllegalArgumentException("不支持的常量：" + key);
		}

		public static Map<String, String> toMap() {
			Map<String, String> map = new HashMap<String, String>();
			NormalState[] values = NormalState.values();
			for (NormalState v : values) {
				map.put(v.getKey() + "", v.getValue());
			}
			return map;
		}

	}

	public static enum RoomLevel {
		普通房(1, "普通房"), 高级房(2, "高级房"), VIP房(3, "VIP房");

		private final Integer key;
		private final String value;

		private RoomLevel(Integer key, String value) {
			this.key = key;
			this.value = value;
		}

		public Integer getKey() {
			return key;
		}

		public String getValue() {
			return value;
		}

		public static Integer getKeyByValue(String v) {
			if (StringUtils.isEmpty(v)) {
				throw new RuntimeException("value为空!");
			}
			Integer key = null;
			RoomLevel[] values = RoomLevel.values();
			for (RoomLevel combobox : values) {
				if (combobox.getValue().equals(v)) {
					key = combobox.getKey();
					break;
				}
			}

			if (key == null) {
				throw new RuntimeException("传入的value不存在!");
			}
			return key;
		}

		public static RoomLevel getValue(Integer key) {
			for (RoomLevel inst : values()) {
				if (key == inst.key || key.equals(inst.key))
					return inst;
			}
			throw new IllegalArgumentException("不支持的常量：" + key);
		}

		public static Map<String, String> toMap() {
			Map<String, String> map = new HashMap<String, String>();
			RoomLevel[] values = RoomLevel.values();
			for (RoomLevel v : values) {
				map.put(v.getKey() + "", v.getValue());
			}
			return map;
		}

	}

	public static enum TimeZone {
		北京时间(8, "北京时间"), 美东时间(4, "美东时间");

		private final Integer key;
		private final String value;

		private TimeZone(Integer key, String value) {
			this.key = key;
			this.value = value;
		}

		public Integer getKey() {
			return key;
		}

		public String getValue() {
			return value;
		}

		public static Integer getKeyByValue(String v) {
			if (StringUtils.isEmpty(v)) {
				throw new RuntimeException("value为空!");
			}
			Integer key = null;
			TimeZone[] values = TimeZone.values();
			for (TimeZone combobox : values) {
				if (combobox.getValue().equals(v)) {
					key = combobox.getKey();
					break;
				}
			}

			if (key == null) {
				throw new RuntimeException("传入的value不存在!");
			}
			return key;
		}

		public static TimeZone getValue(Integer key) {
			for (TimeZone inst : values()) {
				if (key == inst.key || key.equals(inst.key))
					return inst;
			}
			throw new IllegalArgumentException("不支持的常量：" + key);
		}

		public static Map<String, String> toMap() {
			Map<String, String> map = new HashMap<String, String>();
			TimeZone[] values = TimeZone.values();
			for (TimeZone v : values) {
				map.put(v.getKey() + "", v.getValue());
			}
			return map;
		}

	}

	public static enum LimitType {
		单注最高投注限额("every_max", "单注最高投注限额"), 单注最低投注限额("every_min", "单注最低投注限额");

		private final String key;
		private final String value;

		private LimitType(String key, String value) {
			this.key = key;
			this.value = value;
		}

		public String getKey() {
			return key;
		}

		public String getValue() {
			return value;
		}

		public static String getKeyByValue(String v) {
			if (StringUtils.isEmpty(v)) {
				throw new RuntimeException("value为空!");
			}
			String key = null;
			LimitType[] values = LimitType.values();
			for (LimitType combobox : values) {
				if (combobox.getValue().equals(v)) {
					key = combobox.getKey();
					break;
				}
			}

			if (key == null) {
				throw new RuntimeException("传入的value不存在!");
			}
			return key;
		}

		public static LimitType getValue(String key) {
			for (LimitType inst : values()) {
				if (key == inst.key || key.equals(inst.key))
					return inst;
			}
			throw new IllegalArgumentException("不支持的常量：" + key);
		}

		public static Map<String, String> toMap() {
			Map<String, String> map = new HashMap<String, String>();
			LimitType[] values = LimitType.values();
			for (LimitType v : values) {
				map.put(v.getKey() + "", v.getValue());
			}
			return map;
		}

	}
}
