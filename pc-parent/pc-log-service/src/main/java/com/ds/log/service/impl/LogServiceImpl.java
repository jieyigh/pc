package com.ds.log.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ds.entity.Log;
import com.ds.log.repository.LogRepository;
import com.ds.log.service.LogService;

@Service
public class LogServiceImpl implements LogService {

	@Autowired
	private LogRepository logRepository;
	
	@Override
	public Log edit(Log log) {
		return logRepository.save(log);
	}

}
