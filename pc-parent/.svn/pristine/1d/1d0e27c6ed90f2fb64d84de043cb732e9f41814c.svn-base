package com.ds.payoff.test;

import java.math.BigDecimal;
import java.util.HashMap;
import java.util.Map;

import org.junit.Test;

import com.ds.common.util.EncUtil;
import com.ds.common.util.HttpUtil;
import com.ds.common.util.JSONUtils;

public class TransferTest {
	
	private static final String transfer_10 = "http://10.0.1.129:19007/dsapi/index";

	@Test
	public void testPcTransfer() throws Exception {

		String username = "TyzcTTK10000";
		String type = "IN";
		Integer money = 1;

		String billno = String.valueOf(System.currentTimeMillis());
		//secret=a878624d&agent=3r01&username=csgame1234&action=deposit&serial=1414443942811487403&amount=6
		//agent=3r01&secret=a878624d&amount=5&serial=1414443942811487403&action=deposit&username=csgame1234
		String url = transfer_10;
		//		String password = "20IuNngjW675ZMfamwnsr";
		String key = "1234" + EncUtil.toMD5(username + "qqqq" + "20161020") + "5";

		//		String live = "13";//DS主账户 <==> H8 互转

		//		String type = "IN";//IN or OUT
		String credit = money + "";
		String cur = "CNY";

		Map<String, Object> map = new HashMap<String, Object>();
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("username", username);
		paramMap.put("key", key);
		paramMap.put("fromLive", 22);
		paramMap.put("billno", billno);
		paramMap.put("type", type);
		paramMap.put("credit", new BigDecimal(money));
		paramMap.put("cur", cur);
		map.put("params", paramMap);
		map.put("hashCode", "dsggtgjhjk");
		map.put("command", "transfer");

		String param = JSONUtils.map2Json(map);

		System.out.println(param);

		String returnTransfer = HttpUtil.sendPost(url, param);
		System.out.println("OG 返回值:" + returnTransfer);

	}

}
