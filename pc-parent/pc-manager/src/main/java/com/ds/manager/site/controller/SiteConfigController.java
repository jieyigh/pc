package com.ds.manager.site.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

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
import com.ds.common.constants.StatusCode;
import com.ds.common.controller.base.BaseController;
import com.ds.common.util.EncUtil;
import com.ds.common.util.StringUtil;
import com.ds.common.util.ValidateUtil;
import com.ds.entity.SiteConfig;
import com.ds.redis.key.KeyConfig;
import com.ds.room.service.SiteConfigService;
import com.ds.room.vo.SiteConfigParams;
import com.ds.room.vo.SiteConfigParams.SiteConfigParamsAdd;
import com.ds.room.vo.SiteConfigParams.SiteConfigParamsQuery;
import com.ds.room.vo.SiteConfigParams.SiteConfigParamsUpdate;

import io.swagger.annotations.ApiImplicitParam;
import io.swagger.annotations.ApiImplicitParams;
import io.swagger.annotations.ApiOperation;

import com.ds.room.vo.SiteConfigVo;

@RestController
@RequestMapping("/site")
public class SiteConfigController extends BaseController implements KeyConfig {

	private static final Logger logger = LoggerFactory.getLogger(SiteConfigController.class);

	@Autowired
	private SiteConfigService siteConfigService;

	@ApiOperation(value = "获取所有网站")
	@ApiImplicitParams({ //
		@ApiImplicitParam(name = "timestamp", value = "时间戳", dataType = "long", required = true, paramType = "header"), //
		@ApiImplicitParam(name = "siteId", value = "网站ID", dataType = "int", required = true, paramType = "header"), //
		@ApiImplicitParam(name = "encrypt", value = "encrypt", dataType = "string", required = true, paramType = "header")//
	})
	@RequestMapping(value = "/findAll", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	public @ResponseBody Object findAll() {
		try {
			List<SiteConfig> sites = siteConfigService.findAll();
			return result(SUCCESS, sites);
		} catch (Exception e) {
			logger.error("系统错误 findAll : ", e);
			return result(MAYBE, "system error maybe cause param format is error");
		}
	}

	/**
	 * 增加
	 * 
	 * @param request
	 * @return
	 */
	@ApiOperation(value = "编辑网站（增加）")
	@ApiImplicitParams({ //
		@ApiImplicitParam(name = "timestamp", value = "时间戳", dataType = "long", required = true, paramType = "header"), //
		@ApiImplicitParam(name = "encrypt", value = "encrypt", dataType = "string", required = true, paramType = "header")//
	})
	@RequestMapping(value = "/add", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	public @ResponseBody Object editadd(HttpServletRequest request, HttpServletResponse response,@RequestBody String params) {
		try {

			String timestamp = request.getHeader("timestamp");
			String encrypt = request.getHeader("encrypt");
			if (StringUtil.isNull(timestamp) || StringUtil.isNull(encrypt)) {
				md5Process(request, response, timestamp, encrypt, MD5_IS_ERROR, "md5 param is null");
				return false;
			}

			if (!encrypt.equalsIgnoreCase(EncUtil.toMD5(timestamp + StatusCode.DT_MD5_KEY))) {
				logger.info("明文 = {}", (timestamp + StatusCode.DT_MD5_KEY));
				md5Process(request, response, timestamp, encrypt, MD5_IS_ERROR, "md5 is error");
				return false;
			}

			logger.info("add : params = {}", params);
			SiteConfigParams siteConfigParams = JSONObject.parseObject(params, SiteConfigParams.class);

			if (null == siteConfigParams) {
				return result(MAYBE, "param format is error");
			}

			String valid = ValidateUtil.validateModel(siteConfigParams, SiteConfigParamsAdd.class);

			if (StringUtils.isNotEmpty(valid)) {
				return result(MAYBE, valid);
			}
			
			//检验siteId是否重复
			Integer siteId = Integer.valueOf(siteConfigParams.getSiteId());
			List<SiteConfig> siteconfigs = siteConfigService.findBySiteId(siteId);
			if(null != siteconfigs && !siteconfigs.isEmpty()){
				return result(MAYBE, "siteId already exist,please use another siteId");
			}

			SiteConfig result = siteConfigService.edit(siteConfigParams);

			if (null == result) {
				return result(ERROR, "data is null maybe id is error");
			}

			return result(SUCCESS, result);
		} catch (Exception e) {
			logger.error("系统错误 add : ", e);
			return result(MAYBE, "system error maybe cause param format is error");
		}
	}

	/**
	 * 修改
	 * 
	 * @param request
	 * @return
	 */
	@ApiOperation(value = "编辑网站（修改）")
	@ApiImplicitParams({ //
		@ApiImplicitParam(name = "timestamp", value = "时间戳", dataType = "long", required = true, paramType = "header"), //
		@ApiImplicitParam(name = "siteId", value = "网站ID", dataType = "int", required = true, paramType = "header"), //
		@ApiImplicitParam(name = "encrypt", value = "encrypt", dataType = "string", required = true, paramType = "header")//
	})
	@RequestMapping(value = "/edit", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	public @ResponseBody Object edit(@RequestBody String params) {
		try {
			logger.info("edit : params = {}", params);
			SiteConfigParams siteConfigParams = JSONObject.parseObject(params, SiteConfigParams.class);

			if (null == siteConfigParams) {
				return result(MAYBE, "param format is error");
			}

			String valid = null;

			if (null == siteConfigParams.getId()) {
				valid = ValidateUtil.validateModel(siteConfigParams, SiteConfigParamsAdd.class);
			} else {
				valid = ValidateUtil.validateModel(siteConfigParams, SiteConfigParamsUpdate.class);
			}

			if (StringUtils.isNotEmpty(valid)) {
				return result(MAYBE, valid);
			}
			
			//检验siteId是否重复
			String siteId = siteConfigParams.getSiteId();
			if(null != siteId){
				List<SiteConfig> siteconfigs = siteConfigService.findBySiteId(Integer.valueOf(siteId));
				if(null != siteconfigs && !siteconfigs.isEmpty()){
					return result(MAYBE, "siteId already exist,please use another siteId");
				}
			}
			

			SiteConfig result = siteConfigService.edit(siteConfigParams);

			if (null == result) {
				return result(ERROR, "data is null maybe id is error");
			}

			/*
			 * Map<Integer, SiteConfigVo> roomMap =
			 * this.siteConfigService.getRoomsMap(); Set<Entry<Integer,
			 * SiteConfigVo>> roomEntrySet = roomMap.entrySet(); for
			 * (Entry<Integer, SiteConfigVo> entry : roomEntrySet) {
			 * this.redisService.set(KEY_ROOM + entry.getKey(),
			 * JSONUtils.bean2Json(entry.getValue())); }
			 */

			return result(SUCCESS, result);
		} catch (Exception e) {
			logger.error("系统错误 edit : ", e);
			return result(MAYBE, "system error maybe cause param format is error");
		}
	}

	@ApiOperation(value = "通过siteId查询网站、房、房间")
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

			SiteConfigVo siteConfigVo = siteConfigService.findBySiteIdOne(Integer.valueOf(siteId));
			if (null == siteConfigVo) {
				return result(ERROR, "data is null");
			}
			return result(SUCCESS, siteConfigVo);
		} catch (Exception e) {
			logger.error("系统错误 findBySiteId : ", e);
			return result(MAYBE, "system error maybe cause param format is error");
		}

	}

}
