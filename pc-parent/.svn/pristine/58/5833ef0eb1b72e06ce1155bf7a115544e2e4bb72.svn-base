package com.ds.common.threadpool;

import java.util.concurrent.ThreadFactory;
import java.util.concurrent.atomic.AtomicInteger;

/**
 * 自定义线程池命名工厂
 * 
 * @author jackson
 *
 */
public class NamedThreadFactory implements ThreadFactory {

	private static final AtomicInteger poolNumber = new AtomicInteger(1);
	private final ThreadGroup group;
	private final AtomicInteger threadNumber = new AtomicInteger(1);
	private final String namePrefix;
	private final boolean isDaemo;

	public NamedThreadFactory(String prefix, boolean daemo) {
		this.isDaemo = daemo;
		SecurityManager s = System.getSecurityManager();
		group = (s != null) ? s.getThreadGroup() : //
				Thread.currentThread().getThreadGroup();
		namePrefix = prefix + "-" + //
				poolNumber.getAndIncrement() + //
				"-thread-";
	}

	@Override
	public Thread newThread(Runnable r) {
		Thread t = new Thread(group, r, namePrefix + threadNumber.getAndIncrement(), 0);
		t.setDaemon(isDaemo);
		if (t.getPriority() != Thread.NORM_PRIORITY)
			t.setPriority(Thread.NORM_PRIORITY);
		return t;
	}

}