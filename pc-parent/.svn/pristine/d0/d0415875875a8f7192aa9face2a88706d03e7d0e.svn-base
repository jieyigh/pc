package com.ds.bet.test;

import java.lang.Thread.UncaughtExceptionHandler;
import java.util.concurrent.Callable;
import java.util.concurrent.FutureTask;

import org.junit.Test;

public class ThreadTest {
	
	public static void main(String[] args) {
		try {
			Callable<String> c = new Callable<String>() {
				@Override
				public String call() throws Exception {
					System.out.println(1 / 0);
					return null;
				}
			};
			FutureTask<String> task = new FutureTask<>(c);
			Thread t = new Thread(task);
			t.start();
		} catch (Exception e) {
			System.out.println("出现异常了");
			System.out.println(e.getMessage());
		}
	}

	@Test
	public void testThreadException() {
		
	}
	
	@Test
	public void testLong() throws Exception {
		long a = 20170123062L;
		long b = Long.valueOf("20170123061").intValue();
		System.out.println(a <= b);
	}


}

class TestException implements UncaughtExceptionHandler {
	@Override
	public void uncaughtException(Thread t, Throwable e) {
		throw new RuntimeException(t.getName() + " 此线程 : 扔出异常");
	}

}