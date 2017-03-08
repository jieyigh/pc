package com.ds.service.impl;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Date;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Predicate;
import javax.persistence.criteria.Root;
import javax.transaction.Transactional;

import org.apache.commons.lang.StringUtils;
import org.hibernate.SQLQuery;
import org.hibernate.transform.Transformers;
import org.hibernate.type.BigDecimalType;
import org.hibernate.type.DateType;
import org.hibernate.type.IntegerType;
import org.hibernate.type.LongType;
import org.hibernate.type.StringType;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.stereotype.Service;

import com.ds.common.service.CommonService;
import com.ds.common.util.DateUtil;
import com.ds.entity.ActivityUser;
import com.ds.repository.ActivityUserPagingRepository;
import com.ds.repository.ActivityUserRepository;
import com.ds.service.ActivityUserService;

@SuppressWarnings("unchecked")
@Service
public class ActivityUserServiceImpl extends CommonService implements ActivityUserService {

	private Logger logger = LoggerFactory.getLogger(this.getClass());

	@Autowired
	private ActivityUserRepository activityUserRepository;

	@Autowired
	private ActivityUserPagingRepository activityUserPagingRepository;

	@PersistenceContext
	private EntityManager entityManager;

	@Override
	public List<Integer> queryLossBonusSiteId(String today) {
		return this.activityUserRepository.queryLossBonusSiteId(today);
	}

	@Transactional
	@Override
	public int insertBatch(List<ActivityUser> activityUsers) {
		if (activityUsers == null || activityUsers.size() <= 0) {
			return 0;
		}
		List<Object> paramList = new ArrayList<>();
		StringBuilder sqlBuffer = new StringBuilder();
		sqlBuffer.append("INSERT INTO pc_activity_user( ")//
				.append("site_id, activity_id, username, original_username, loss_money, loss_money_bonus, state, create_time) ")//
				.append("VALUES ");
		ActivityUser user = null;
		for (int i = 0; i < activityUsers.size(); i++) {
			user = activityUsers.get(i);
			sqlBuffer.append("(?,?,?,?,?,?,?,?)");
			paramList.add(user.getSiteId());
			paramList.add(user.getActivityId());
			paramList.add(user.getUsername());
			paramList.add(user.getOriginalUsername());
			paramList.add(user.getLossMoney());
			paramList.add(user.getLossMoneyBonus());
			paramList.add(user.getState());
			paramList.add(user.getCreateTime());
			if (i != activityUsers.size() - 1) {
				sqlBuffer.append(",");
			}
		}
		SQLQuery sqlQuery = this.entityManager.createNativeQuery(sqlBuffer.toString()).unwrap(SQLQuery.class);
		for (int i = 0; i < paramList.size(); i++) {
			sqlQuery.setParameter(i, paramList.get(i));
		}
		return sqlQuery.executeUpdate();
	}

	@Override
	public List<ActivityUser> queryLossBonusBySiteIdAndStateAndDate(Integer siteId, Integer state, String fromDate,
			String toDate) {
		return this.activityUserRepository.findBySiteIdAndStateAndCreateTime(siteId, state, fromDate, toDate);
	}

	@Override
	public List<ActivityUser> getActivityUserBySiteIdAndDateOrUsernames(Integer siteId, Integer state, String date,
			String... usernames) {
		List<Object> paramList = new ArrayList<>();
		StringBuffer sqlBuffer = new StringBuffer();
		sqlBuffer.append(
				"SELECT id, site_id siteId, activity_id activityId, username, original_username originalUsername, ")//
				.append("loss_money lossMoney, loss_money_bonus lossMoneyBonus, state, operator, create_time createTime, update_time updateTime ")//
				.append("FROM pc_activity_user WHERE site_id = ? AND state = ? AND DATE_FORMAT(create_time, '%Y-%m-%d') = ? ");
		paramList.add(siteId);
		paramList.add(state);
		paramList.add(date);
		if (usernames != null && usernames.length > 0) {
			sqlBuffer.append("AND original_username IN (");
			for (int i = 0; i < usernames.length; i++) {
				sqlBuffer.append("?").append((i == usernames.length - 1) ? ") " : ",");
				paramList.add(usernames[i]);
			}
		} else {
			logger.info("进行整站反水 siteId = {}, date = {}", siteId, date);
		}
		SQLQuery sqlQuery = this.entityManager.createNativeQuery(sqlBuffer.toString()).unwrap(SQLQuery.class);
		for (int i = 0; i < paramList.size(); i++) {
			sqlQuery.setParameter(i, paramList.get(i));
		}
		sqlQuery.addScalar("id", LongType.INSTANCE);
		sqlQuery.addScalar("siteId", IntegerType.INSTANCE);
		sqlQuery.addScalar("activityId", LongType.INSTANCE);
		sqlQuery.addScalar("username", StringType.INSTANCE);
		sqlQuery.addScalar("originalUsername", StringType.INSTANCE);
		sqlQuery.addScalar("lossMoney", BigDecimalType.INSTANCE);
		sqlQuery.addScalar("lossMoneyBonus", BigDecimalType.INSTANCE);
		sqlQuery.addScalar("state", IntegerType.INSTANCE);
		sqlQuery.addScalar("operator", StringType.INSTANCE);
		sqlQuery.addScalar("createTime", DateType.INSTANCE);
		sqlQuery.addScalar("updateTime", DateType.INSTANCE);

		sqlQuery.setResultTransformer(Transformers.aliasToBean(ActivityUser.class));
		List<ActivityUser> list = sqlQuery.list();
		return list;
	}

	@Transactional
	@Override
	public int updateBonusByState(Integer siteId, String date, Integer state, String operator, Set<String> usernameSet,
			boolean include) {
		List<Object> paramList = new ArrayList<>();
		Date now = new Date();
		StringBuilder sqlBuffer = new StringBuilder();
		sqlBuffer.append("UPDATE pc_activity_user SET ") //
				.append("state = ?, operator = ?, update_time = ? ") //
				.append("WHERE site_id = ? AND DATE_FORMAT(create_time, '%Y-%m-%d') = ? ");
		paramList.add(state);
		paramList.add(operator);
		paramList.add(now);
		paramList.add(siteId);
		paramList.add(date);
		if (usernameSet != null && usernameSet.size() > 0) {
			Iterator<String> iterator = null;
			if (include) {
				sqlBuffer.append("AND username IN ( ");
				iterator = usernameSet.iterator();
			} else {
				sqlBuffer.append("AND original_username NOT IN ( ");
				iterator = usernameSet.iterator();
			}
			String username = null;
			while (iterator.hasNext()) {
				username = iterator.next();
				sqlBuffer.append("?").append(iterator.hasNext() ? "," : ") ");
				paramList.add(username);
			}
		}
		SQLQuery sqlQuery = this.entityManager.createNativeQuery(sqlBuffer.toString()).unwrap(SQLQuery.class);
		for (int i = 0; i < paramList.size(); i++) {
			sqlQuery.setParameter(i, paramList.get(i));
		}
		return sqlQuery.executeUpdate();
	}

	@Override
	public Page<ActivityUser> findBySiteIdAndStateAndCreateTime(Integer siteId, Integer state, String fromDate,
			String toDate, String username, Pageable pageable) {
		return activityUserPagingRepository.findBySiteIdAndStateAndCreateTime(siteId, state, fromDate, toDate, username,
				pageable);
	}

	private Specification<ActivityUser> getWhereClause(final Integer siteId, final Integer state, final String fromDate,
			final String toDate, final String username) {
		return new Specification<ActivityUser>() {

			@Override
			public Predicate toPredicate(Root<ActivityUser> root, CriteriaQuery<?> query, CriteriaBuilder cb) {
				Predicate predicate = cb.conjunction();
				if (StringUtils.isNotBlank(username)) {
					predicate.getExpressions()
							.add(cb.like(root.<String>get("username"), "%" + StringUtils.trim(username)));
				}

				if (null != siteId) {
					predicate.getExpressions().add(cb.equal(root.<Integer>get("siteId"), siteId));
				}
				
				if (null != state) {
					predicate.getExpressions().add(cb.equal(root.<Integer>get("state"), state));
				}
				
				if (StringUtils.isNotBlank(fromDate) && StringUtils.isNotBlank(toDate)) {
					Date fromDateFormat = DateUtil.parse(DateUtil.YY_MM_DD_HH_MM_SS, fromDate + " 00:00:00");
					Date toDateFormat = DateUtil.parse(DateUtil.YY_MM_DD_HH_MM_SS, toDate+ " 23:59:59");
					
					predicate.getExpressions()
							.add(cb.between(root.<Date>get("createTime"), fromDateFormat, toDateFormat));
				}
				
				predicate.getExpressions().add(cb.isNotNull(root.<BigDecimal>get("lossMoneyBonus")));
				return predicate;
			}

		};
	}

	@Override
	public Page<ActivityUser> findAll(Integer siteId, Integer state, String fromDate, String toDate, String username,
			Pageable pageable) {
		return activityUserPagingRepository.findAll(getWhereClause(siteId, state, fromDate, toDate, username),
				pageable);
	}

	

}
