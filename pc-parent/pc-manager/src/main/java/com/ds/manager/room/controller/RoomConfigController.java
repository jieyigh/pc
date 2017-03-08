package com.ds.manager.room.controller;

import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.Map.Entry;

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
import com.ds.common.controller.base.BaseController;
import com.ds.common.util.JSONUtils;
import com.ds.common.util.ValidateUtil;
import com.ds.entity.RoomConfig;
import com.ds.redis.api.RedisService;
import com.ds.redis.key.KeyConfig;
import com.ds.room.service.RoomConfigService;
import com.ds.room.service.SiteConfigService;
import com.ds.room.vo.RoomConfigParams;
import com.ds.room.vo.RoomConfigParams.RoomConfigParamsAdd;
import com.ds.room.vo.RoomConfigParams.RoomConfigParamsUpdate;
import com.ds.room.vo.SiteConfigParams;
import com.ds.room.vo.SiteConfigVo;
import com.ds.room.vo.SiteConfigParams.SiteConfigParamsQuery;

import io.swagger.annotations.ApiImplicitParam;
import io.swagger.annotations.ApiImplicitParams;
import io.swagger.annotations.ApiOperation;

@RestController
@RequestMapping("/room")
public class RoomConfigController extends BaseController implements KeyConfig{

	private static final Logger logger = LoggerFactory.getLogger(RoomConfigController.class);

	@Autowired
	private SiteConfigService siteConfigService;
	
	@Autowired
	private RoomConfigService roomConfigService;
	
	@Autowired
	private RedisService redisService;

	@RequestMapping(value = "/findBySiteIdAndGameType", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	public @ResponseBody Object findBySiteIdAndGameType(HttpServletRequest request) {
		try {
			String params = this.getParams(request);
			logger.info("findByGameType : params = {}", params);
			JSONObject jsonObj = JSONObject.parseObject(params);
			Integer siteId = jsonObj.getInteger("siteId");
			String gameType = jsonObj.getString("gameType");
			List<RoomConfig> rooms = roomConfigService.findBySiteIdAndGameType(siteId, gameType);
			return result(SUCCESS, rooms);
		} catch (Exception e) {
			logger.error("系统错误 findByGameType : ", e);
			return result(MAYBE, "system error maybe cause param format is error");
		}
	}

	@RequestMapping(value = "/findByGameType", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	public @ResponseBody Object findByGameType(HttpServletRequest request) {
		try {
			String params = this.getParams(request);
			logger.info("findByGameType : params = {}", params);
			JSONObject jsonObj = JSONObject.parseObject(params);
			String gameType = jsonObj.getString("gameType");
			List<RoomConfig> rooms = roomConfigService.findByGameType(gameType);
			return result(SUCCESS, rooms);
		} catch (Exception e) {
			logger.error("系统错误 findByGameType : ", e);
			return result(MAYBE, "system error maybe cause param format is error");
		}
	}

	@ApiOperation(value = "通过siteId查询房")
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

			List<RoomConfig> rooms = roomConfigService.findBySiteId(siteId);
			return result(SUCCESS, rooms);
		} catch (Exception e) {
			logger.error("系统错误 findBySiteId : ", e);
			return result(MAYBE, "system error maybe cause param format is error");
		}
	}

	@ApiOperation(value = "编辑房（增加&修改）")
	@ApiImplicitParams({ //
		@ApiImplicitParam(name = "timestamp", value = "时间戳", dataType = "long", required = true, paramType = "header"), //
		@ApiImplicitParam(name = "siteId", value = "网站ID", dataType = "int", required = true, paramType = "header"), //
		@ApiImplicitParam(name = "encrypt", value = "encrypt", dataType = "string", required = true, paramType = "header")//
	})
	@RequestMapping(value = "/edit", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	public @ResponseBody Object edit(@RequestBody String params) {

		try {
			logger.info("edit : params = {}", params);
			RoomConfigParams roomConfigParams = JSONObject.parseObject(params, RoomConfigParams.class);

			if (null == roomConfigParams) {
				return result(ERROR, "param format is error");
			}

			String valid = null;

			if (null == roomConfigParams.getId()) {
				valid = ValidateUtil.validateModel(roomConfigParams, RoomConfigParamsAdd.class);
			} else {
				valid = ValidateUtil.validateModel(roomConfigParams, RoomConfigParamsUpdate.class);
			}

			if (StringUtils.isNotEmpty(valid)) {
				return result(ERROR, valid);
			}

			RoomConfig result = roomConfigService.edit(roomConfigParams);

			if (null == result) {
				return result(ERROR, "data is null maybe id is error");
			}
			
			/*Map<Integer, SiteConfigVo> roomMap = this.siteConfigService.getRoomsMap();
			Set<Entry<Integer, SiteConfigVo>> roomEntrySet = roomMap.entrySet();
			for (Entry<Integer, SiteConfigVo> entry : roomEntrySet) {
				this.redisService.set(KEY_ROOM + entry.getKey(), JSONUtils.bean2Json(entry.getValue()));
			}
			 */
			return result(SUCCESS, result);
		} catch (Exception e) {
			logger.error("系统错误 edit : ", e);
			return result(MAYBE, "system error maybe cause param format is error");
		}

	}

}
