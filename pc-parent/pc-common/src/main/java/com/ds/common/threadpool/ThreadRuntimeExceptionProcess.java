package com.ds.common.threadpool;

import java.util.concurrent.CancellationException;
import java.util.concurrent.ExecutionException;
import java.util.concurrent.Future;

public class ThreadRuntimeExceptionProcess {

	private Runnable r;

	private Throwable t;

	public ThreadRuntimeExceptionProcess(Runnable r, Throwable t) {
		this.r = r;
		this.t = t;
	}

	public void throwsException() {
		if (t == null && r instanceof Future<?>) {
			try {
				Future<?> future = (Future<?>) r;
				if (future.isDone())
					future.get();
			} catch (CancellationException ce) {
				t = ce;
			} catch (ExecutionException ee) {
				t = ee.getCause();
			} catch (InterruptedException ie) {
				Thread.currentThread().interrupt(); // ignore/reset
			}
		}
		if (t != null)
			throw new RuntimeException(t.getMessage(), t);
	}

}
