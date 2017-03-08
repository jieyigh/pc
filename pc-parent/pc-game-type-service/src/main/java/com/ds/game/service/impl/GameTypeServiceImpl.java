package com.ds.game.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ds.entity.GameType;
import com.ds.game.repository.GameTypeRepository;
import com.ds.game.service.GameTypeService;

@Service
public class GameTypeServiceImpl implements GameTypeService {

	@Autowired
	private GameTypeRepository gameTypeRepository;

	@Override
	public List<GameType> findAll() {
		return this.gameTypeRepository.findAll();
	}

}
