package com.ds.redis.api.impl;

import java.util.Set;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.data.redis.connection.RedisConnection;
import org.springframework.data.redis.core.RedisCallback;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.stereotype.Service;

import com.ds.common.util.SerializeUtil;
import com.ds.redis.api.RedisService;

@Service
public class RedisServiceImpl implements RedisService {

	private Logger logger = LoggerFactory.getLogger(this.getClass());

	private static final String DEFAULT_REDIS_CODE = "UTF-8";

	private static final long DEFAULT_LIVE_TIME = Integer.MAX_VALUE - 1;

	@Autowired
	private RedisTemplate<String, Object> redisTemplate;

	@Override
	public long del(final String... keys) {
		if (keys == null || keys.length <= 0) {
			throw new RuntimeException("keys param is null");
		}
		return this.redisTemplate.execute(new RedisCallback<Long>() {
			@Override
			public Long doInRedis(RedisConnection connection) throws DataAccessException {
				long result = 0l;
				for (int i = 0; i < keys.length; i++) {
					result = connection.del(keys[i].getBytes());
				}
				return result;
			}
		});
	}

	/**
	 * @param key
	 * @param value
	 * @param liveTime
	 */
	@Override
	public void set(final byte[] key, final byte[] value, final long liveTime) {
		redisTemplate.execute(new RedisCallback<Object>() {
			public Long doInRedis(RedisConnection connection) throws DataAccessException {
				connection.set(key, value);
				if (liveTime > 0) {
					connection.expire(key, liveTime);
				}
				return 1L;
			}
		});
	}

	@Override
	public void set(String key, String value, long liveTime) {
		this.set(key.getBytes(), value.getBytes(), liveTime);
	}

	@Override
	public void set(String key, String value) {
		this.set(key.getBytes(), value.getBytes());
	}

	@Override
	public void set(byte[] key, byte[] value) {
		this.set(key, value, DEFAULT_LIVE_TIME);
	}

	@Override
	public String get(final String key) {
		return this.redisTemplate.execute(new RedisCallback<String>() {
			@Override
			public String doInRedis(RedisConnection connection) throws DataAccessException {
				try {
					if (connection.exists(key.getBytes())) {
						return new String(connection.get(key.getBytes()), DEFAULT_REDIS_CODE);
					}
				} catch (Exception e) {
					logger.error("redis 获取 key =" + key + " 错误 : ", e);
				}
				return null;
			}
		});
	}

	@Override
	public Set<String> setKeys(String pattern) {
		return this.redisTemplate.keys(pattern);
	}

	@Override
	public boolean exists(final String key) {
		return this.redisTemplate.execute(new RedisCallback<Boolean>() {
			@Override
			public Boolean doInRedis(RedisConnection connection) throws DataAccessException {
				return connection.exists(key.getBytes());
			}
		});
	}

	@Override
	public String flushDB() {
		return this.redisTemplate.execute(new RedisCallback<String>() {
			@Override
			public String doInRedis(RedisConnection connection) throws DataAccessException {
				connection.flushDb();
				return "ok";
			}
		});
	}

	@Override
	public long dbSize() {
		return this.redisTemplate.execute(new RedisCallback<Long>() {
			@Override
			public Long doInRedis(RedisConnection connection) throws DataAccessException {
				return connection.dbSize();
			}
		});
	}

	@Override
	public String ping() {
		return this.redisTemplate.execute(new RedisCallback<String>() {
			@Override
			public String doInRedis(RedisConnection connection) throws DataAccessException {
				return connection.ping();
			}
		});
	}

	@Override
	public void set(String key, Object value) {
		this.set(key.getBytes(), SerializeUtil.serialize(value));
	}

	@Override
	public Object getObject(final String key) {
		return this.redisTemplate.execute(new RedisCallback<Object>() {
			@Override
			public Object doInRedis(RedisConnection connection) throws DataAccessException {
				try {
					if (connection.exists(key.getBytes())) {
						return SerializeUtil.unserialize(connection.get(key.getBytes()));
					}
				} catch (Exception e) {
					logger.error("redis 获取 key =" + key + " 错误 : ", e);
				}
				return null;
			}
		});
	}

}
