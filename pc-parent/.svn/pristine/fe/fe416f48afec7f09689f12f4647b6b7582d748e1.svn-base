package com.ds.transfer.record.repository;

import java.io.Serializable;
import java.util.List;

import org.springframework.data.jpa.repository.Query;

import com.ds.common.repository.BaseRepository;
import com.ds.entity.TransferRecord;

public interface TransferRecordRepository extends BaseRepository<TransferRecord, Serializable> {

	@Query(value = "SELECT bill_no FROM pc_transfer_record WHERE term = ?1", nativeQuery = true)
	List<String> findBillnoByTerm(Long term);

}
