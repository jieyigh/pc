package com.ds.room.service.impl;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.TypedQuery;

import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.ds.common.constants.Constants.NormalState;
import com.ds.common.util.BeanUtil;
import com.ds.entity.BetLimit;
import com.ds.entity.BetOdd;
import com.ds.entity.RoomConfig;
import com.ds.entity.SiteConfig;
import com.ds.entity.TableConfig;
import com.ds.limit.service.BetLimitService;
import com.ds.limit.vo.BetLimitParams;
import com.ds.odds.service.BetOddService;
import com.ds.odds.vo.BetOddParams;
import com.ds.room.repository.TableConfigRepository;
import com.ds.room.service.TableConfigService;
import com.ds.room.vo.TableConfigParams;
import com.ds.room.vo.TableConfigResult;

@Service
public class TableConfigServiceImpl implements TableConfigService {

	@Autowired
	private TableConfigRepository tableConfigRepository;

	@PersistenceContext
	private EntityManager entityManager;

	@Autowired
	private BetOddService betOddService;

	@Autowired
	private BetLimitService betLimitService;

	@Override
	public List<TableConfig> findByRoomId(Integer roomId) {
		return tableConfigRepository.findByRoomId(roomId);
	}

	@Override
	public List<TableConfigResult> getTableConfigResult() {

		StringBuilder sql = new StringBuilder();
		sql.append("SELECT a.id,a.game_type as gameType,a.memo1,a.memo2,a.level,a.state AS tableState, ") //
				.append(" b.site_id as siteId,c.state AS siteState,c.memo AS siteMemo, ")//
				.append(" a.room_id as roomId,b.state AS roomState,b.memo AS roomMemo ").append(" FROM pc_table_config a INNER JOIN pc_room_config b ON a.room_id=b.id ").append(" INNER JOIN pc_site_config c ON b.site_id=c.site_id");

		String s = "SELECT t FROM TableConfig t";
		s = "SELECT a.* FROM pc_table_config a";

		String jpql = String.format(
				"select new %1$s(a.id,a.gameType as gameType,a.memo,a.level,a.state AS tableState, "
						+ "b.siteId as siteId,c.state AS siteState,c.memo AS siteMemo,"
						+ "a.roomId as roomId,b.state AS roomState,b.memo AS roomMemo ) from %2$s a, "
						+ "%3$s b, %4$s c where a.roomId=b.id and b.siteId=c.siteId and c.siteId=?1",
				TableConfigResult.class.getName(), TableConfig.class.getName(), RoomConfig.class.getName(),
				SiteConfig.class.getName());
		System.out.println();
		// 建立有类型的查询
		TypedQuery<TableConfigResult> reportTypedQuery = entityManager.createQuery(jpql, TableConfigResult.class);
		// 另外有详细查询条件的在jpql中留出参数位置来(?1 ?2 ?3....)，然后在这设置
		// reportTypedQuery.setParameter(1, params);
		reportTypedQuery.setParameter(1, 99999);
		List<TableConfigResult> reports = reportTypedQuery.getResultList();
		return reports;
	}

	@Override
	public List<TableConfigResult> getTableConfigResultBySiteId(Integer siteId) {
		String jpql = String.format("select new %1$s(a.id,a.gameType as gameType,a.memo1,a.memo2,a.name,a.level,a.state AS tableState, " //
					              + "b.siteId as siteId,c.state AS siteState,c.memo AS siteMemo," + "a.roomId as roomId,b.state AS roomState,b.memo AS roomMemo,b.memo2 AS roomMemo2 ) from %2$s a, " //
					              + "%3$s b, %4$s c where a.roomId=b.id and b.siteId=c.siteId and c.siteId=?1", //
				TableConfigResult.class.getName(), TableConfig.class.getName(), RoomConfig.class.getName(), SiteConfig.class.getName());
		// 建立有类型的查询
		TypedQuery<TableConfigResult> reportTypedQuery = entityManager.createQuery(jpql, TableConfigResult.class);
		// 另外有详细查询条件的在jpql中留出参数位置来(?1 ?2 ?3....)，然后在这设置
		// reportTypedQuery.setParameter(1, params);
		reportTypedQuery.setParameter(1, siteId);
		List<TableConfigResult> results = reportTypedQuery.getResultList();
		return results;
	}

	@Override
	public List<TableConfig> getTablesBySiteId(Integer siteId) {
		return tableConfigRepository.getTablesBySiteId(siteId);
	}

	@Transactional
	@Override
	public TableConfig edit(TableConfigParams params) {
		if (null == params.getId()) {
			TableConfig e = new TableConfig();
			BeanUtils.copyProperties(params, e);
			e.setRoomId(Integer.valueOf(params.getRoomId()));
			e.setLevel(Integer.valueOf(params.getLevel()));
			e.setState(NormalState.启用.getKey());
			e.setCreateTime(new Date());

			TableConfig entity = this.tableConfigRepository.save(e);
			if (null != entity) {/*
				// TODO 生成赔率，限额
				Integer tableId = entity.getId();

				List<BetOddParams> oddParams = params.getOdds();
				List<BetLimitParams> limitParams = params.getLimits();

				List<BetOdd> odds = new ArrayList<>();
				List<BetLimit> limits = new ArrayList<>();

				if (null == oddParams || oddParams.isEmpty()) {
					this.tableConfigRepository.createBetOdds(tableId);
				} else {
					for (BetOddParams oddParam : oddParams) {
						BetOdd odd = new BetOdd();
						BeanUtils.copyProperties(oddParam, odd);
						odd.setTableId(tableId);
						odd.setParentId(Long.valueOf(oddParam.getParentId()));
						odd.setEnabled(NormalState.启用.getKey());
						odd.setCreateTime(new Date());
						odds.add(odd);
					}
				}

				if (null == limitParams || limitParams.isEmpty()) {
					this.tableConfigRepository.createBetLimit(tableId);
				} else {
					for (BetLimitParams limitParam : limitParams) {
						BetLimit limit = new BetLimit();
						BeanUtils.copyProperties(limitParam, limit);
						limit.setTableId(tableId);
						limit.setEnabled(NormalState.启用.getKey());
						limit.setCreateTime(new Date());
						limits.add(limit);
					}
				}

				if (!odds.isEmpty()) {
					this.betOddService.saveList(odds);
				}

				if (!limits.isEmpty()) {
					this.betLimitService.saveList(limits);
				}

			*/}
			return entity;
		}

		TableConfig e = this.tableConfigRepository.findOne(params.getId());

		if (null == e) {
			return null;
		}

		BeanUtil.copyPropertiesIgnoreNull(params, e);
		if (null != params.getRoomId()) {
			e.setRoomId(Integer.valueOf(params.getRoomId()));
		}
		if (null != params.getState()) {
			e.setState(Integer.valueOf(params.getState()));
		}
		if (null != params.getLevel()) {
			e.setLevel(Integer.valueOf(params.getLevel()));
		}
		e.setUpdateTime(new Date());
		return tableConfigRepository.saveAndFlush(e);
	}

	@Override
	public List<TableConfig> findAll() {
		return tableConfigRepository.findAll();
	}

}
