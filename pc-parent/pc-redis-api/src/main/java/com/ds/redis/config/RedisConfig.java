package com.ds.redis.config;

import java.net.UnknownHostException;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.data.redis.connection.RedisConnectionFactory;
import org.springframework.data.redis.connection.jedis.JedisConnectionFactory;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.data.redis.serializer.StringRedisSerializer;

import com.ds.common.util.StringUtil;

import redis.clients.jedis.JedisPoolConfig;

/**
 * redis 配置
 * 
 * @author jackson
 *
 */
@Configuration
public class RedisConfig {

	@Value("${spring.redis.database}")
	private Integer index;

	@Value("${spring.redis.host}")
	private String hostName;

	@Value("${spring.redis.password}")
	private String password;

	@Value("${spring.redis.port}")
	private Integer port;

	@Value("${spring.redis.timeout}")
	private Integer timeout;

	@Value("${spring.redis.pool.max-idle}")
	private Integer maxIdle;

	@Value("${spring.redis.pool.min-idle}")
	private Integer minIdle;

	@Value("${spring.redis.pool.max-active}")
	private Integer maxTotal;

	@Value("${spring.redis.pool.max-wait}")
	private Long maxWaitMillis;

	@Bean
	public RedisConnectionFactory redisConnectionFactory() {
		JedisConnectionFactory connectionFactory = new JedisConnectionFactory();
		connectionFactory.setDatabase(index);
		connectionFactory.setHostName(hostName);
		if (!StringUtil.isNull(password)) {
			connectionFactory.setPassword(password);
		}
		connectionFactory.setPort(port);
		connectionFactory.setTimeout(timeout);
		connectionFactory.setUsePool(true);
		JedisPoolConfig pool = new JedisPoolConfig();
		pool.setMaxIdle(maxIdle); // 最大空闲
		pool.setMinIdle(minIdle);
		pool.setMaxTotal(maxTotal); // 最大连接数
		pool.setMaxWaitMillis(maxWaitMillis); // 最大等待
		pool.setTestOnReturn(true);
		pool.setBlockWhenExhausted(true);
		pool.setTestOnBorrow(true);
		pool.setTestWhileIdle(true);
		connectionFactory.setPoolConfig(pool);
		connectionFactory.afterPropertiesSet();
		return connectionFactory;
	}

	@Bean
	public RedisTemplate<?, ?> redisTemplate() throws UnknownHostException {
		RedisTemplate<?, ?> redisTemplate = new RedisTemplate<>();
		redisTemplate.setConnectionFactory(redisConnectionFactory());
		redisTemplate.setDefaultSerializer(new StringRedisSerializer());
		return redisTemplate;
	}

}
