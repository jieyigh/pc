package com.ds.manager.odds.service;

import javax.annotation.Resource;
import javax.jms.Queue;
import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ds.common.mq.queue.key.KeyConfig;
import com.ds.common.util.JSONUtils;
import com.ds.entity.BetOdd;
import com.ds.mq.provider.p2p.MQProviderService;
import com.ds.odds.service.BetOddService;
import com.ds.odds.vo.BetOddParams;

@Service
public class OddsManagerService implements KeyConfig {

	@Autowired
	private BetOddService betOddService;

	@Resource(name = QUEUE_BET_ODDS)
	private Queue queueBetOdds;

	@Autowired
	private MQProviderService mqService;

	@Transactional
	public BetOdd edit(BetOddParams betOddParams) throws Exception {
		BetOdd edit = this.betOddService.edit(betOddParams);
		this.mqService.send(queueBetOdds, JSONUtils.bean2Json(edit));
		return edit;
	}

}
