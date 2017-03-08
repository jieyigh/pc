package com.ds.transfer.record.service.impl;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.persistence.EntityManager;
import javax.transaction.Transactional;

import org.hibernate.SQLQuery;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ds.entity.TransferRecord;
import com.ds.transfer.record.repository.TransferRecordRepository;
import com.ds.transfer.record.service.TransferRecordService;

@Service
public class TransferRecordServiceImpl implements TransferRecordService {

	@Autowired
	private TransferRecordRepository transferRecordRepository;

	@Autowired
	private EntityManager entityManager;

	@Transactional
	@Override
	public void insert(TransferRecord record) {
		this.transferRecordRepository.save(record);
	}

	@Transactional
	@Override
	public int insertBatch(List<TransferRecord> recordList) {
		if (null == recordList || recordList.isEmpty()) {
			return 0;
		}
		StringBuffer sqlBuffer = new StringBuffer();
		sqlBuffer.append("INSERT INTO pc_transfer_record(")//
				.append("site_id, table_id, term, username, original_username, money, type, bill_no, result_state, result_msg, transfer_type, create_time) VALUES ");
		TransferRecord record = null;
		List<Object> paramList = new ArrayList<>();
		Date now = new Date();
		for (int i = 0; i < recordList.size(); i++) {
			record = recordList.get(i);
			sqlBuffer.append("(?,?,?,?,?,?,?,?,?,?,?,?) ");
			paramList.add(record.getSiteId());
			paramList.add(record.getTableId());
			paramList.add(record.getTerm());
			paramList.add(record.getUsername());
			paramList.add(record.getOriginalUsername());
			paramList.add(record.getMoney());
			paramList.add(record.getType());
			paramList.add(record.getBillNo());
			paramList.add(record.getResultState());
			paramList.add(record.getResultMsg());
			paramList.add(record.getTransferType());
			paramList.add(now);
			if (i != recordList.size() - 1) {
				sqlBuffer.append(",");
			}
		}
		SQLQuery sqlQuery = this.entityManager.createNativeQuery(sqlBuffer.toString()).unwrap(SQLQuery.class);
		for (int i = 0; i < paramList.size(); i++) {
			sqlQuery.setParameter(i, paramList.get(i));
		}
		return sqlQuery.executeUpdate();
	}

	@Transactional
	@Override
	public int insertRepeatTermPayoff(Long term, List<TransferRecord> repeatRecords) {
		if (repeatRecords == null || repeatRecords.size() <= 0) {
			return 0;
		}
		List<String> termList = this.transferRecordRepository.findBillnoByTerm(term);
		List<TransferRecord> recordList = new ArrayList<>();
		for (TransferRecord record : repeatRecords) {
			if (termList != null && termList.size() > 0) {
				if (termList.contains(record.getBillNo())) {
					continue;
				}
			}
			recordList.add(record);
		}
		if (recordList != null && recordList.size() > 0) {
			return this.insertBatch(recordList);
		}
		return 0;
	}

}
