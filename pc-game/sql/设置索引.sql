DROP PROCEDURE IF EXISTS schema_change;  
  DELIMITER //
 CREATE PROCEDURE schema_change() BEGIN 
 DECLARE  CurrentDatabase VARCHAR(100);
 SELECT DATABASE() INTO CurrentDatabase;
    /*	w_money  */
	IF NOT EXISTS (SELECT * FROM information_schema.statistics WHERE table_schema=CurrentDatabase AND table_name = 'w_money' AND index_name = 'index_money_nickname') THEN 
		ALTER TABLE w_money ADD INDEX index_money_nickname (nickname); 
	END IF;
	IF NOT EXISTS (SELECT * FROM information_schema.statistics WHERE table_schema=CurrentDatabase AND table_name = 'w_money' AND index_name = 'index_money_agent_name') THEN 
		ALTER TABLE w_money ADD INDEX index_money_agent_name (agent_name); 
	END IF;
	IF NOT EXISTS (SELECT * FROM information_schema.statistics WHERE table_schema=CurrentDatabase AND table_name = 'w_money' AND index_name = 'index_money_agent') THEN 
		ALTER TABLE w_money ADD INDEX index_money_agent (agent);
	END IF;
	IF NOT EXISTS (SELECT * FROM information_schema.statistics WHERE table_schema=CurrentDatabase AND table_name = 'w_money' AND index_name = 'index_money_type') THEN 
		ALTER TABLE w_money ADD INDEX index_money_type (type);  
	END IF;

    /*	w_money_log  */
 	IF NOT EXISTS (SELECT * FROM information_schema.statistics WHERE table_schema=CurrentDatabase AND table_name = 'w_money_log' AND index_name = 'index_money_log_nickname') THEN  
    	ALTER TABLE w_money_log ADD INDEX index_money_log_nickname (nickname);
 	END IF; 
 	IF NOT EXISTS (SELECT * FROM information_schema.statistics WHERE table_schema=CurrentDatabase AND table_name = 'w_money_log' AND index_name = 'index_money_log_game_type') THEN  
    	ALTER TABLE w_money_log ADD INDEX index_money_log_game_type (game_type);
 	END IF;
 	IF NOT EXISTS (SELECT * FROM information_schema.statistics WHERE table_schema=CurrentDatabase AND table_name = 'w_money_log' AND index_name = 'index_money_log_state') THEN  
    	ALTER TABLE w_money_log ADD INDEX index_money_log_state (state);
 	END IF;
 	IF NOT EXISTS (SELECT * FROM information_schema.statistics WHERE table_schema=CurrentDatabase AND table_name = 'w_money_log' AND index_name = 'index_money_log_create_time') THEN  
    	ALTER TABLE w_money_log ADD INDEX index_money_log_create_time (create_time);
 	END IF;
 	IF NOT EXISTS (SELECT * FROM information_schema.statistics WHERE table_schema=CurrentDatabase AND table_name = 'w_money_log' AND index_name = 'index_money_log_update_time') THEN  
    	ALTER TABLE w_money_log ADD INDEX index_money_log_update_time (update_time);
 	END IF;

	/*	w_lottery_result  */
 	IF NOT EXISTS (SELECT * FROM information_schema.statistics WHERE table_schema=CurrentDatabase AND table_name = 'w_lottery_result' AND index_name = 'index_lottery_result_term') THEN  
    	ALTER TABLE w_lottery_result ADD INDEX index_lottery_result_term (term);
 	END IF;
 	IF NOT EXISTS (SELECT * FROM information_schema.statistics WHERE table_schema=CurrentDatabase AND table_name = 'w_lottery_result' AND index_name = 'index_lottery_result_game_type') THEN  
    	ALTER TABLE w_lottery_result ADD INDEX index_lottery_result_game_type (game_type);
 	END IF;

    /*	w_bill  */
 	IF NOT EXISTS (SELECT * FROM information_schema.statistics WHERE table_schema=CurrentDatabase AND table_name = 'w_bill' AND index_name = 'index_bill_nickname') THEN  
    	ALTER TABLE w_bill ADD INDEX index_bill_nickname (nickname);
 	END IF; 
 	IF NOT EXISTS (SELECT * FROM information_schema.statistics WHERE table_schema=CurrentDatabase AND table_name = 'w_bill' AND index_name = 'index_bill_term') THEN  
    	ALTER TABLE w_bill ADD INDEX index_bill_term (term);
 	END IF;
 	IF NOT EXISTS (SELECT * FROM information_schema.statistics WHERE table_schema=CurrentDatabase AND table_name = 'w_bill' AND index_name = 'index_bill_game_type') THEN  
    	ALTER TABLE w_bill ADD INDEX index_bill_game_type (game_type);
 	END IF;
 	IF NOT EXISTS (SELECT * FROM information_schema.statistics WHERE table_schema=CurrentDatabase AND table_name = 'w_bill' AND index_name = 'index_bill_create_time') THEN  
    	ALTER TABLE w_bill ADD INDEX index_bill_create_time (create_time);
 	END IF;
 	IF NOT EXISTS (SELECT * FROM information_schema.statistics WHERE table_schema=CurrentDatabase AND table_name = 'w_bill' AND index_name = 'index_bill_update_time') THEN  
    	ALTER TABLE w_bill ADD INDEX index_bill_update_time (update_time);
 	END IF;


 	/*	w_bet_info  */
 	IF NOT EXISTS (SELECT * FROM information_schema.statistics WHERE table_schema=CurrentDatabase AND table_name = 'w_bet_info' AND index_name = 'index_bet_info_nickname') THEN  
    	ALTER TABLE w_bet_info ADD INDEX index_bet_info_nickname (nickname);
 	END IF; 
 	IF NOT EXISTS (SELECT * FROM information_schema.statistics WHERE table_schema=CurrentDatabase AND table_name = 'w_bet_info' AND index_name = 'index_bet_info_term') THEN  
    	ALTER TABLE w_bet_info ADD INDEX index_bet_info_term (term);
 	END IF;
 	IF NOT EXISTS (SELECT * FROM information_schema.statistics WHERE table_schema=CurrentDatabase AND table_name = 'w_bet_info' AND index_name = 'index_bet_info_game_type') THEN  
    	ALTER TABLE w_bet_info ADD INDEX index_bet_info_game_type (game_type);
 	END IF;

 END//  
DELIMITER ;  
CALL schema_change(); 


