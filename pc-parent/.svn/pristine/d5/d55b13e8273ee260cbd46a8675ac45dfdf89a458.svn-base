package com.ds.manager.loss.bonus.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.ds.common.controller.base.BaseController;
import com.ds.common.util.JSONUtils;
import com.ds.common.util.QueryToolUtil;
import com.ds.common.util.StringUtil;
import com.ds.entity.ActivityUser;
import com.ds.manager.loss.bonus.service.LossBonusService;
import com.ds.service.ActivityUserService;

import io.swagger.annotations.ApiImplicitParam;
import io.swagger.annotations.ApiImplicitParams;
import io.swagger.annotations.ApiOperation;

/**
 * 亏损送
 * 
 * @author jackson
 *
 */
@RestController
@RequestMapping("/lossBonus")
public class LossBonusController extends BaseController {

	private Logger logger = LoggerFactory.getLogger(this.getClass());

	@Autowired
	private ActivityUserService activityUserService;

	@Autowired
	private LossBonusService lossBonusService;

	/**
	 * 查询反水和未反水数据
	 * 
	 * @param siteId
	 *            网站id
	 * @param state
	 *            1:未发送, 2:已发送
	 * @param fromDate
	 *            开始日期
	 * @param toDate
	 *            结束日期
	 * @return
	 */
	@ApiOperation(value = "查询反水和未反水数据")
	@ApiImplicitParams({ //
		@ApiImplicitParam(name = "timestamp", value = "时间戳", dataType = "long", required = true, paramType = "header"), //
		@ApiImplicitParam(name = "siteId", value = "网站ID", dataType = "int", required = true, paramType = "header"), //
		@ApiImplicitParam(name = "encrypt", value = "encrypt", dataType = "string", required = true, paramType = "header")//
	})
	@RequestMapping(value = "/getData", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	public @ResponseBody String getDataBySiteId(@RequestBody String params) {
		logger.info("getDataBySiteId : params = {}", params);
		try {
			JSONObject jsonObj = JSONObject.parseObject(params);
			Integer siteId = jsonObj.getInteger("siteId");
			Integer state = jsonObj.getInteger("state");
			String fromDate = jsonObj.getString("fromDate");
			String toDate = jsonObj.getString("toDate");
			
			String username = jsonObj.getString("username");
			
			Integer pageNumber = jsonObj.getInteger("pageNumber");
			
			if(null == pageNumber){
				return JSONUtils.map2Json(result(ERROR, "pageNumber is null"));
			}
			
			Integer pageSize = jsonObj.getInteger("pageSize");
			
			if(null == pageSize){
				return JSONUtils.map2Json(result(ERROR, "pageSize is null"));
			}
			
			PageRequest pageRequest = QueryToolUtil.buildPageRequest(pageNumber-1, pageSize, "");
			
			
			if (StringUtil.isNull(fromDate) || StringUtil.isNull(toDate)) {
				return JSONUtils.map2Json(result(ERROR, "fromDate or toDate is null"));
			}
			
			
			/*Page<ActivityUser> page = activityUserService.findBySiteIdAndStateAndCreateTime(siteId, state, fromDate,
					toDate,  username ,pageRequest);*/
			
			Page<ActivityUser> page = activityUserService.findAll(siteId, state, fromDate,
					toDate,  username ,pageRequest);
			
			return JSONUtils.map2Json(result(SUCCESS, page));
		} catch (Exception e) {
			logger.error("getDataBySiteId 系统错误 : ", e);
			return JSONUtils.map2Json(result(MAYBE, "system is error"));
		}
	}
	
	
	@ApiOperation(value = "查询反水和未反水数据备份")
	@ApiImplicitParams({ //
		@ApiImplicitParam(name = "timestamp", value = "时间戳", dataType = "long", required = true, paramType = "header"), //
		@ApiImplicitParam(name = "siteId", value = "网站ID", dataType = "int", required = true, paramType = "header"), //
		@ApiImplicitParam(name = "encrypt", value = "encrypt", dataType = "string", required = true, paramType = "header")//
	})
	@RequestMapping(value = "/getData2", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	public @ResponseBody String getDataBySiteId2(@RequestBody String params) {
		logger.info("getDataBySiteId : params = {}", params);
		try {
			JSONObject jsonObj = JSONObject.parseObject(params);
			Integer siteId = jsonObj.getInteger("siteId");
			Integer state = jsonObj.getInteger("state");
			String fromDate = jsonObj.getString("fromDate");
			String toDate = jsonObj.getString("toDate");
			if (StringUtil.isNull(fromDate) || StringUtil.isNull(toDate)) {
				return JSONUtils.map2Json(result(ERROR, "fromDate or toDate is null"));
			}
			return JSONUtils.map2Json(result(SUCCESS, this.activityUserService.queryLossBonusBySiteIdAndStateAndDate(siteId, state, fromDate, toDate)));
		} catch (Exception e) {
			logger.error("getDataBySiteId 系统错误 : ", e);
			return JSONUtils.map2Json(result(MAYBE, "system is error"));
		}
	}

	@ApiOperation(value = "反水转账")
	@ApiImplicitParams({ //
		@ApiImplicitParam(name = "timestamp", value = "时间戳", dataType = "long", required = true, paramType = "header"), //
		@ApiImplicitParam(name = "siteId", value = "网站ID", dataType = "int", required = true, paramType = "header"), //
		@ApiImplicitParam(name = "encrypt", value = "encrypt", dataType = "string", required = true, paramType = "header")//
	})
	@RequestMapping(value = "/send", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	public @ResponseBody String editsend(@RequestBody String params) {
		logger.info("send : params = {}", params);
		try {
			JSONObject jsonObj = JSONObject.parseObject(params);
			Integer siteId = jsonObj.getInteger("siteId");
			String operator = jsonObj.getString("operator");
			JSONArray usernameArr = jsonObj.getJSONArray("usernames");
			String date = jsonObj.getString("date");
			return JSONUtils.map2Json(this.lossBonusService.sendBonus(siteId, operator, date, usernameArr.toArray(new String[usernameArr.size()])));
		} catch (Exception e) {
			logger.error("send 系统错误 : ", e);
			return JSONUtils.map2Json(result(MAYBE, "system is error"));
		}
	}

}
