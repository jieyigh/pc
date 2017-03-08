package com.ds.manager.table.controller;

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
import com.ds.common.controller.base.BaseController;
import com.ds.common.util.ValidateUtil;
import com.ds.entity.TableConfig;
import com.ds.redis.key.KeyConfig;
import com.ds.room.service.TableConfigService;
import com.ds.room.vo.SiteConfigParams;
import com.ds.room.vo.SiteConfigParams.SiteConfigParamsQuery;
import com.ds.room.vo.TableConfigParams;
import com.ds.room.vo.TableConfigParams.TableConfigParamsAdd;
import com.ds.room.vo.TableConfigParams.TableConfigParamsUpdate;

import io.swagger.annotations.ApiImplicitParam;
import io.swagger.annotations.ApiImplicitParams;
import io.swagger.annotations.ApiOperation;

@RestController
@RequestMapping("/table")
public class TableConfigController extends BaseController implements KeyConfig {

	private static final Logger logger = LoggerFactory.getLogger(TableConfigController.class);

	@Autowired
	private TableConfigService tableConfigService;

	@RequestMapping(value = "/findByRoomId", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	public @ResponseBody Object findByRoomId(HttpServletRequest request) {
		try {
			String params = this.getParams(request);
			logger.info("findByRoomId : params = {}", params);
			JSONObject jsonObj = JSONObject.parseObject(params);
			String roomId = jsonObj.getString("roomId");
			List<TableConfig> rooms = tableConfigService.findByRoomId(Integer.valueOf(roomId));
			return result(SUCCESS, rooms);
		} catch (Exception e) {
			logger.error("系统错误 findByRoomId : ", e);
			return result(MAYBE, "system error maybe cause param format is error");
		}
	}

	@ApiOperation(value = "通过siteId查询房间")
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

			List<TableConfig> tables = tableConfigService.getTablesBySiteId(Integer.valueOf(siteId));

			if (null == tables || tables.isEmpty()) {
				return result(ERROR, "data is null");
			}

			return result(SUCCESS, tables);
		} catch (Exception e) {
			logger.error("系统错误 findBySiteId : ", e);
			return result(MAYBE, "system error maybe cause param format is error");
		}
	}

	@RequestMapping(value = "/get", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	public @ResponseBody Object get(HttpServletRequest request) {
		try {
			return tableConfigService.getTableConfigResult();
		} catch (Exception e) {
			logger.error("系统错误 get : ", e);
			return result(MAYBE, "system error maybe cause param format is error");
		}
	}

	@RequestMapping(value = "/find", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	public @ResponseBody Object find(HttpServletRequest request) {
		try {
			return tableConfigService.getTableConfigResult();
		} catch (Exception e) {
			logger.error("系统错误 get : ", e);
			return result(MAYBE, "system error maybe cause param format is error");
		}
	}

	@ApiOperation(value = "编辑房间（增加&修改）")
	@ApiImplicitParams({ //
		@ApiImplicitParam(name = "timestamp", value = "时间戳", dataType = "long", required = true, paramType = "header"), //
		@ApiImplicitParam(name = "siteId", value = "网站ID", dataType = "int", required = true, paramType = "header"), //
		@ApiImplicitParam(name = "encrypt", value = "encrypt", dataType = "string", required = true, paramType = "header")//
	})
	@RequestMapping(value = "/edit", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	public @ResponseBody Object edit(@RequestBody String params) {

		try {
			logger.info("edit : params = {}", params);
			TableConfigParams tableConfigParams = JSONObject.parseObject(params, TableConfigParams.class);

			if (null == tableConfigParams) {
				return result(MAYBE, "param format is error");
			}

			String valid = null;

			if (null == tableConfigParams.getId()) {
				valid = ValidateUtil.validateModel(tableConfigParams, TableConfigParamsAdd.class);
			} else {
				valid = ValidateUtil.validateModel(tableConfigParams, TableConfigParamsUpdate.class);
			}

			if (StringUtils.isNotEmpty(valid)) {
				return result(MAYBE, valid);
			}

			TableConfig result = tableConfigService.edit(tableConfigParams);

			if (null == result) {
				return result(ERROR, "data is null maybe id is error");
			}

			/*Map<Integer, SiteConfigVo> roomMap = this.siteConfigService.getRoomsMap();
			Set<Entry<Integer, SiteConfigVo>> roomEntrySet = roomMap.entrySet();
			for (Entry<Integer, SiteConfigVo> entry : roomEntrySet) {
				this.redisService.set(KEY_ROOM + entry.getKey(), JSONUtils.bean2Json(entry.getValue()));
			}*/

			return result(SUCCESS, result);
		} catch (Exception e) {
			logger.error("系统错误 edit : ", e);
			return result(MAYBE, "system error maybe cause param format is error");
		}

	}

}
