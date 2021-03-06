package com.ds.record.controller;

import java.util.List;

import org.apache.commons.lang.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.alibaba.fastjson.JSONObject;
import com.ds.common.controller.base.BaseController;
import com.ds.common.util.ValidateUtil;
import com.ds.record.entity.BetInfoRecord;
import com.ds.record.service.BetInfoRecordService;
import com.ds.record.vo.BetInfoParams;
import com.ds.record.vo.BetInfoParams.BetInfoSiteParams;
import com.ds.record.vo.BetInfoParams.BetInfoTableParams;

@RestController
@RequestMapping("/bet")
public class BetInfoController extends BaseController {

	private static final Logger logger = LoggerFactory.getLogger(BetInfoController.class);

	@Autowired
	private BetInfoRecordService betInfoRecordService;

	@RequestMapping(value = "/get", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	public @ResponseBody Object get(@RequestBody String params) {

		BetInfoParams betInfoParams = JSONObject.parseObject(params, BetInfoParams.class);
		String valid = ValidateUtil.validateModel(betInfoParams, BetInfoTableParams.class);

		if (StringUtils.isNotEmpty(valid)) {
			return result(MAYBE, valid);
		}
		try {
			Integer tableId = Integer.valueOf(betInfoParams.getTableId());
			Long id = Long.valueOf(betInfoParams.getId());
			Integer num = Integer.valueOf(betInfoParams.getNum());
			List<BetInfoRecord> lists = betInfoRecordService.get100BetInfoRecords(tableId, id, num);
			if (null == lists || lists.isEmpty()) {
				logger.info("数据为空");
				return result(ERROR, "data is null");
			}
			return result(SUCCESS, lists);
		} catch (Exception e) {
			logger.info(SYSTEM_ERROR);
			return result(ERROR, SYSTEM_ERROR);
		}
	}

	@RequestMapping(value = "/getBySiteId", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	public @ResponseBody Object getBySiteId(@RequestBody String params) {
		logger.info("获取参数：{}",params);
		BetInfoParams betInfoParams = JSONObject.parseObject(params, BetInfoParams.class);
		String valid = ValidateUtil.validateModel(betInfoParams, BetInfoSiteParams.class);

		if (StringUtils.isNotEmpty(valid)) {
			return result(MAYBE, valid);
		}

		try {
			Integer siteId = Integer.valueOf(betInfoParams.getSiteId());
			List<Integer> tableIds = betInfoRecordService.getTableIdsBySiteId(siteId);
			if (null == tableIds || tableIds.isEmpty()) {
				logger.info("数据为空");
				return result(ERROR, "data is null");
			}
			Long id = Long.valueOf(betInfoParams.getId());
			Integer num = Integer.valueOf(betInfoParams.getNum());
			List<BetInfoRecord> lists = betInfoRecordService.getBetInfoRecords(tableIds, id, num);
			if (null == lists || lists.isEmpty()) {
				logger.info("数据为空");
				return result(ERROR, "data is null");
			}
			return result(SUCCESS, lists);
		} catch (Exception e) {
			logger.info(SYSTEM_ERROR);
			return result(ERROR, SYSTEM_ERROR);
		}
	}

}
