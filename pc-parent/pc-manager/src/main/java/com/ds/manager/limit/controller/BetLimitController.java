package com.ds.manager.limit.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

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
import com.ds.common.bet.BetType;
import com.ds.common.controller.base.BaseController;
import com.ds.common.util.ValidateUtil;
import com.ds.entity.BetLimit;
import com.ds.limit.service.BetLimitService;
import com.ds.limit.vo.BetLimitParams;
import com.ds.limit.vo.BetLimitParams.BetLimitParamsAdd;
import com.ds.limit.vo.BetLimitParams.BetLimitParamsSingle;
import com.ds.limit.vo.BetLimitParams.BetLimitParamsUpdate;
import com.ds.manager.limit.service.LimitManagerService;
import com.ds.redis.key.KeyConfig;
import com.ds.room.vo.SiteConfigParams;
import com.ds.room.vo.SiteConfigParams.SiteConfigParamsQuery;

import io.swagger.annotations.ApiImplicitParam;
import io.swagger.annotations.ApiImplicitParams;
import io.swagger.annotations.ApiOperation;

@RestController
@RequestMapping("/limit")
public class BetLimitController extends BaseController implements KeyConfig {

	private static final Logger logger = LoggerFactory.getLogger(BetLimitController.class);

	@Autowired
	private BetLimitService betLimitService;

	@Autowired
	private LimitManagerService limitManagerService;

	@RequestMapping(value = "/findByTableId", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	public @ResponseBody Object findByTableId(HttpServletRequest request) {
		try {
			String params = this.getParams(request);
			logger.info("findByTableId : params = {}", params);
			JSONObject jsonObj = JSONObject.parseObject(params);
			String tableId = jsonObj.getString("tableId");
			List<BetLimit> limits = betLimitService.findByTableId(Integer.valueOf(tableId));
			return result(SUCCESS, limits);
		} catch (Exception e) {
			logger.error("系统错误 findByTableId : ", e);
			return result(MAYBE, "system error maybe cause param format is error");
		}
	}

	@ApiOperation(value = "通过siteId查询限额")
	@ApiImplicitParams({ //
			@ApiImplicitParam(name = "timestamp", value = "时间戳", dataType = "long", required = true, paramType = "header"), //
			@ApiImplicitParam(name = "siteId", value = "网站ID", dataType = "int", required = true, paramType = "header"), //
			@ApiImplicitParam(name = "encrypt", value = "encrypt", dataType = "string", required = true, paramType = "header")//
	})
	@RequestMapping(value = "/findBySiteId", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	public @ResponseBody Object findBySiteId(@RequestBody String params) {
		try {
			logger.info("findBySiteId : params = {}", params);

			SiteConfigParams siteConfigParams = JSONObject.parseObject(params, SiteConfigParams.class);

			if (null == siteConfigParams) {
				return result(ERROR, "param format is error");
			}
			String valid = ValidateUtil.validateProperty(siteConfigParams, "siteId", SiteConfigParamsQuery.class);

			if (StringUtils.isNotEmpty(valid)) {
				return result(ERROR, valid);
			}
			Integer siteId = Integer.valueOf(siteConfigParams.getSiteId());

			List<BetLimit> limits = betLimitService.findBySiteId(Integer.valueOf(siteId));
			return result(SUCCESS, limits);
		} catch (Exception e) {
			logger.error("系统错误 findBySiteId : ", e);
			return result(MAYBE, "system error maybe cause param format is error");
		}
	}

	@ApiOperation(value = "编辑限额（增加&修改）")
	@ApiImplicitParams({ //
			@ApiImplicitParam(name = "timestamp", value = "时间戳", dataType = "long", required = true, paramType = "header"), //
			@ApiImplicitParam(name = "siteId", value = "网站ID", dataType = "int", required = true, paramType = "header"), //
			@ApiImplicitParam(name = "encrypt", value = "encrypt", dataType = "string", required = true, paramType = "header")//
	})
	@RequestMapping(value = "/edit", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	public @ResponseBody Object edit(@RequestBody String params) {
		try {
			logger.info("edit : params = {}", params);
			BetLimitParams betLimitParams = JSONObject.parseObject(params, BetLimitParams.class);

			if (null == betLimitParams) {
				return result(MAYBE, "param format is error");
			}

			String valid = null;

			if (null == betLimitParams.getId()) {
				if (null != betLimitParams.getType() && betLimitParams.getType().equals(BetType.CAO.getType())) {
					valid = ValidateUtil.validateModel(betLimitParams, BetLimitParamsSingle.class);
				} else {
					valid = ValidateUtil.validateModel(betLimitParams, BetLimitParamsAdd.class);
				}
			} else {
				if (null != betLimitParams.getType() && betLimitParams.getType().equals(BetType.CAO.getType())) {
					valid = ValidateUtil.validateModel(betLimitParams, BetLimitParamsSingle.class);
				} else {
					valid = ValidateUtil.validateModel(betLimitParams, BetLimitParamsUpdate.class);
				}
			}

			String singleLimits = betLimitParams.getSingPlayLimit();
			if (null != singleLimits) {
				Object o = JSONObject.parseObject(singleLimits, Object.class);
				if (null == o) {
					return result(MAYBE, "param format is error");
				}
			}

			if (StringUtils.isNotEmpty(valid)) {
				return result(MAYBE, valid);
			}

			BetLimit result = this.limitManagerService.edit(betLimitParams);

			if (null == result) {
				return result(ERROR, "data is null maybe id is error");
			}

			// 限额
			/*
			 * Map<Integer, Map<String, BetLimit>> betLimitMap =
			 * this.betLimitService.getBetLimitMap(); Set<Entry<Integer,
			 * Map<String, BetLimit>>> limitEntrySet = betLimitMap.entrySet();
			 * for (Entry<Integer, Map<String, BetLimit>> entry : limitEntrySet)
			 * { this.redisService.set(KEY_PREFIX_LIMIT + entry.getKey(),
			 * JSONUtils.map2Json(entry.getValue())); }
			 */

			return result(SUCCESS, result);
		} catch (Exception e) {
			logger.error("系统错误 edit : ", e);
			return result(MAYBE, "system error maybe cause param format is error");
		}
	}

}
