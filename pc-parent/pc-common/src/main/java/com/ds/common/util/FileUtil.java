package com.ds.common.util;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.FileReader;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

/**
 * 文件操作
 *
 * @author jackson
 *
 */
public class FileUtil {

	public static final String BET = "bet.txt"; //

	private synchronized static File getMaxIdFile(String fileName) {
		try {
			String userDir = System.getProperty("user.dir") + File.separator + "resource";
			File file = new File(userDir);
			if (!file.exists()) {
				file.mkdirs();
			}
			file = new File(userDir + File.separator + fileName);
			if (!file.exists()) {
				file.createNewFile();
			}
			return file;
		} catch (IOException e) {
			e.printStackTrace();
		}
		return null;
	}

	public synchronized static String getContentByFileName(String fileName) {
		FileInputStream fis = null;
		try {
			File file = FileUtil.getMaxIdFile(fileName);
			fis = new FileInputStream(file);
			byte[] readBuf = new byte[fis.available()];
			fis.read(readBuf);
			return new String(readBuf);
		} catch (IOException e) {
			e.printStackTrace();
		} finally {
			try {
				if (fis != null)
					fis.close();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		return null;
	}

	public synchronized static List<String> readLineByFileName(String fileName) {
		BufferedReader bis = null;
		try {
			File file = FileUtil.getMaxIdFile(fileName);
			bis = new BufferedReader(new FileReader(file));
			List<String> lineList = new ArrayList<>();
			String line = null;
			while ((line = bis.readLine()) != null) {
				lineList.add(line);
			}
			return lineList;
		} catch (IOException e) {
			e.printStackTrace();
		} finally {
			try {
				if (bis != null)
					bis.close();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		return null;
	}

	public synchronized static void writeContentByFileName(String content, String fileName) {
		FileOutputStream fos = null;
		try {
			File file = FileUtil.getMaxIdFile(fileName);
			fos = new FileOutputStream(file);
			fos.write(content.getBytes());
			fos.flush();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (null != fos)
					fos.close();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
	}

	public static void main(String[] args) {
		String content = FileUtil.getContentByFileName(FileUtil.BET);

		System.out.println(content);
	}

}
