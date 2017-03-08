package com.ds.manager.activities.controller;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.ds.common.controller.base.BaseController;
import com.ds.common.util.JSONUtils;
import com.ds.entity.Activity;
import com.ds.service.ActivityService;

import io.swagger.annotations.ApiImplicitParam;
import io.swagger.annotations.ApiImplicitParams;
import io.swagger.annotations.ApiOperation;

/**
 * 活动
 * 
 * @author jackson
 *
 */
@RestController
@RequestMapping("/activity")
public class ActivityController extends BaseController {

	private Logger logger = LoggerFactory.getLogger(this.getClass());

	@Autowired
	private ActivityService activityService;

	/**
	 * 获取activity
	 */
	@ApiOperation(value = "查询活动")
	@ApiImplicitParams({ //
			@ApiImplicitParam(name = "timestamp", value = "时间戳", dataType = "long", required = true, paramType = "header"), //
			@ApiImplicitParam(name = "siteId", value = "网站ID", dataType = "int", required = true, paramType = "header"), //
			@ApiImplicitParam(name = "encrypt", value = "encrypt", dataType = "string", required = true, paramType = "header")//
	})
	@RequestMapping(value = "/getData", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	public String getDataBySiteId(@RequestBody String params) {
		try {
			logger.info("getDataBySiteId : params = {}", params);
			JSONObject jsonObj = JSONObject.parseObject(params);
			Integer siteId = jsonObj.getInteger("siteId");
			if (siteId == null) {
				return JSONUtils.map2Json(result(SITEID_OR_LIVE_NOEXIST, "siteId is null or no exists"));
			}
			List<Activity> activityList = this.activityService.findBySiteId(siteId);
			return JSONArray.toJSONString(activityList);
		} catch (Exception e) {
			logger.error("系统错误 getDataBySiteId : ", e);
			return JSONUtils.map2Json(result(MAYBE, "system error maybe cause param format is error"));
		}
	}

	/**
	 * 修改
	 * 
	 * @return
	 */
	@ApiOperation(value = "更新活动")
	@ApiImplicitParams({ //
		@ApiImplicitParam(name = "timestamp", value = "时间戳", dataType = "long", required = true, paramType = "header"), //
		@ApiImplicitParam(name = "siteId", value = "网站ID", dataType = "int", required = true, paramType = "header"), //
		@ApiImplicitParam(name = "encrypt", value = "encrypt", dataType = "string", required = true, paramType = "header")//
	})
	@RequestMapping(value = "/updateById", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	public String editUpdateById(@RequestBody String params) {
		try {
			logger.info("edit : param = {}", params);
			JSONObject jsonObj = JSONObject.parseObject(params);
			Activity activity = new Activity();
			activity.setName(jsonObj.getString("name"));
			activity.setContent(jsonObj.getJSONArray("content").toJSONString());
			activity.setMemo(jsonObj.getString("memo"));
			activity.setId(jsonObj.getLong("id"));
			this.activityService.updateById(activity);
			return JSONUtils.map2Json(result(SUCCESS, "ok"));
		} catch (Exception e) {
			logger.error("系统错误 edit : ", e);
			return JSONUtils.map2Json(result(MAYBE, "system error maybe cause param format is error"));
		}

	}

}
