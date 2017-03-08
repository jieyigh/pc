package com.ds.manager.odds.controller;

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
import com.ds.entity.BetOdd;
import com.ds.manager.odds.service.OddsManagerService;
import com.ds.odds.service.BetOddService;
import com.ds.odds.vo.BetOddParams;
import com.ds.odds.vo.BetOddParams.BetOddParamsAdd;
import com.ds.odds.vo.BetOddParams.BetOddParamsQuery;
import com.ds.odds.vo.BetOddParams.BetOddParamsTypeAdd;
import com.ds.odds.vo.BetOddParams.BetOddParamsTypeUpdate;
import com.ds.odds.vo.BetOddParams.BetOddParamsUpdate;
import com.ds.redis.key.KeyConfig;

import io.swagger.annotations.ApiImplicitParam;
import io.swagger.annotations.ApiImplicitParams;
import io.swagger.annotations.ApiOperation;

@RestController
@RequestMapping("/odd")
public class BetOddController extends BaseController implements KeyConfig {

	private static final Logger logger = LoggerFactory.getLogger(BetOddController.class);

	@Autowired
	private BetOddService betOddService;

	@Autowired
	private OddsManagerService oddsManagerService;

	@ApiOperation(value = "通过tableId（房间ID）查询赔率")
	@ApiImplicitParams({ //
			@ApiImplicitParam(name = "timestamp", value = "时间戳", dataType = "long", required = true, paramType = "header"), //
			@ApiImplicitParam(name = "siteId", value = "网站ID", dataType = "int", required = true, paramType = "header"), //
			@ApiImplicitParam(name = "encrypt", value = "encrypt", dataType = "string", required = true, paramType = "header")//
	})
	@RequestMapping(value = "/findByTableId", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	public @ResponseBody Object findByTableId(@RequestBody String params) {
		try {
			logger.info("findByTableId : params = {}", params);
			BetOddParams betOddParams = JSONObject.parseObject(params, BetOddParams.class);

			String valid = ValidateUtil.validateModel(betOddParams, BetOddParamsQuery.class);

			if (StringUtils.isNotEmpty(valid)) {
				return result(MAYBE, valid);
			}

			String tableId = betOddParams.getTableId();
			List<BetOdd> odds = betOddService.findByTableId(Integer.valueOf(tableId));
			return result(SUCCESS, odds);
		} catch (Exception e) {
			logger.error("系统错误 findByTableId : ", e);
			return result(MAYBE, "system error maybe cause param format is error");
		}
	}

	@ApiOperation(value = "编辑赔率（增加&修改）")
	@ApiImplicitParams({ //
			@ApiImplicitParam(name = "timestamp", value = "时间戳", dataType = "long", required = true, paramType = "header"), //
			@ApiImplicitParam(name = "siteId", value = "网站ID", dataType = "int", required = true, paramType = "header"), //
			@ApiImplicitParam(name = "encrypt", value = "encrypt", dataType = "string", required = true, paramType = "header")//
	})
	@RequestMapping(value = "/edit", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	public @ResponseBody Object edit(@RequestBody String params) {
		try {
			logger.info("edit : params = {}", params);
			BetOddParams betOddParams = JSONObject.parseObject(params, BetOddParams.class);

			if (null == betOddParams) {
				return result(MAYBE, "param format is error");
			}
			String valid = null;

			if (null == betOddParams.getId()) {
				valid = ValidateUtil.validateModel(betOddParams, BetOddParamsAdd.class);
			} else {
				valid = ValidateUtil.validateModel(betOddParams, BetOddParamsUpdate.class);
			}

			if (StringUtils.isNotEmpty(valid)) {
				return result(MAYBE, valid);
			}

			BetOdd result = this.oddsManagerService.edit(betOddParams);

			if (null == result) {
				return result(ERROR, "data is null maybe id is error");
			}

			/*Map<Integer, Map<Long, Map<String, BetOdd>>> tableIdBetOddsMap = this.betOddService.getTableIdBetOddsMap();
			Set<Entry<Integer, Map<Long, Map<String, BetOdd>>>> oddEntrySet = tableIdBetOddsMap.entrySet();
			for (Entry<Integer, Map<Long, Map<String, BetOdd>>> entry : oddEntrySet) {
				this.redisService.set(KEY_PREFIX_ODDS + entry.getKey(), JSONUtils.map2Json(entry.getValue()));
			}*/

			return result(SUCCESS, result);
		} catch (Exception e) {
			logger.error("系统错误 edit : ", e);
			return result(MAYBE, "system error maybe cause param format is error");
		}
	}

	@ApiOperation(value = "编辑赔率种类（增加&修改）")
	@ApiImplicitParams({ //
			@ApiImplicitParam(name = "timestamp", value = "时间戳", dataType = "long", required = true, paramType = "header"), //
			@ApiImplicitParam(name = "siteId", value = "网站ID", dataType = "int", required = true, paramType = "header"), //
			@ApiImplicitParam(name = "encrypt", value = "encrypt", dataType = "string", required = true, paramType = "header")//
	})
	@RequestMapping(value = "/editType", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	public @ResponseBody Object editType(@RequestBody String params) {
		try {
			logger.info("editType : params = {}", params);
			BetOddParams betOddParams = JSONObject.parseObject(params, BetOddParams.class);

			if (null == betOddParams) {
				return result(MAYBE, "param format is error");
			}
			String valid = null;

			if (null == betOddParams.getId()) {
				valid = ValidateUtil.validateModel(betOddParams, BetOddParamsTypeAdd.class);
			} else {
				valid = ValidateUtil.validateModel(betOddParams, BetOddParamsTypeUpdate.class);
			}

			if (StringUtils.isNotEmpty(valid)) {
				return result(MAYBE, valid);
			}

			BetOdd result = betOddService.editType(betOddParams);

			if (null == result) {
				return result(ERROR, "data is null maybe id is error");
			}

			return result(SUCCESS, result);
		} catch (Exception e) {
			logger.error("系统错误 editType : ", e);
			return result(MAYBE, "system error maybe cause param format is error");
		}
	}

	@ApiOperation(value = "获取所有赔率种类")
	@ApiImplicitParams({ //
			@ApiImplicitParam(name = "timestamp", value = "时间戳", dataType = "long", required = true, paramType = "header"), //
			@ApiImplicitParam(name = "siteId", value = "网站ID", dataType = "int", required = true, paramType = "header"), //
			@ApiImplicitParam(name = "encrypt", value = "encrypt", dataType = "string", required = true, paramType = "header")//
	})
	@RequestMapping(value = "/getType", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	public @ResponseBody Object getType() {
		try {
			List<BetOdd> result = betOddService.findByParentIdIsNull();
			if (null == result || result.isEmpty()) {
				return result(ERROR, "data is null maybe id is error");
			}

			return result(SUCCESS, result);
		} catch (Exception e) {
			logger.error("系统错误 getType : ", e);
			return result(MAYBE, "system error maybe cause param format is error");
		}
	}

}
