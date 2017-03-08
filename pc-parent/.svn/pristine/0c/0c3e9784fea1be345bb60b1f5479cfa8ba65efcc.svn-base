package com.ds.common.threadpool;

import java.util.concurrent.RejectedExecutionException;
import java.util.concurrent.ThreadPoolExecutor;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

/**
 * 当线程池被中断或拒绝时,收集日志
 * 
 * @author jackson
 *
 */
public class AbortPolicyWithReport extends ThreadPoolExecutor.AbortPolicy {

	protected Logger logger = LoggerFactory.getLogger(this.getClass());

	private final String threadName;

	public AbortPolicyWithReport(String threadName) {
		this.threadName = threadName;
	}

	@Override
	public void rejectedExecution(Runnable r, ThreadPoolExecutor e) {
		String msg = String.format(
				"Thread pool is EXHAUSTED!" + //
						" Thread Name: %s, Pool Size: %d (active: %d, core: %d, max: %d, largest: %d), Task: %d (completed: %d)," + //
						" Executor status:(isShutdown:%s, isTerminated:%s, isTerminating:%s)!", //
				threadName, e.getPoolSize(), e.getActiveCount(), e.getCorePoolSize(), e.getMaximumPoolSize(), //
				e.getLargestPoolSize(), e.getTaskCount(), e.getCompletedTaskCount(), e.isShutdown(), //
				e.isTerminated(), e.isTerminating());
		logger.warn(msg);
		throw new RejectedExecutionException(msg);
	}

}
