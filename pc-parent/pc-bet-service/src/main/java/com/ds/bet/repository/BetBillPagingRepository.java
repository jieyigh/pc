package com.ds.bet.repository;

import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.repository.PagingAndSortingRepository;
import org.springframework.stereotype.Repository;

import com.ds.bet.entity.BetBill;

@Repository
public interface BetBillPagingRepository extends JpaSpecificationExecutor<BetBill>, PagingAndSortingRepository<BetBill, String>{

	

} 
