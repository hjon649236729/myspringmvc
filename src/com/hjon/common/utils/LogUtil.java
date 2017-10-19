package com.hjon.common.utils;

import com.hjon.config.Constant;

import java.io.BufferedWriter;
import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.io.PrintWriter;
import java.io.StringWriter;

/// <summary>
/// 日志工具集
/// </summary>
public class LogUtil {
	public static boolean ifShowError = true;
	public static boolean ifShowException = true;
	public static boolean ifShowWarn = true;
	public static boolean ifShowLog = true;
	public static boolean ifShowDebug = true;

	public static boolean ifPrintToFile = true; // 是否记录到文件

	public static String gLogFileDir = Constant.LogPath;// new
														// File("").getAbsolutePath()+"/Log";//LogHelper.class.getProtectionDomain().getCodeSource().getLocation()
														// + "Log";

	// / <summary>
	// / 错误
	// / </summary>
	// / <param name="msg"></param>
	public static void Error(String msg) {
		if (ifShowError)
			Print("[ERROR] " + msg);
	}

	// / <summary>
	// / 错误
	// / </summary>
	// / <param name="msg"></param>
	public static void Error(Throwable e) {
		Error(getExceptionTrace(e));
	}

	// / <summary>
	// / 警告
	// / </summary>
	// / <param name="msg"></param>
	public static void Warn(String msg) {
		if (ifShowException)
			Print("[WARN] " + msg);
	}

	// / <summary>
	// / 程序运行流程（关键流程）
	// / </summary>
	// / <param name="msg"></param>
	public static void Log(String msg) {
		if (ifShowLog)
			Print("[LOG] " + msg);
	}

	// / <summary>
	// / 程序运行流程（仅再调试下显示的信息）
	// / </summary>
	// / <param name="msg"></param>
	public static void Debug(String msg) {
		if (ifShowDebug)
			Print("[DEBUG] " + msg);
	}

	// / <summary>
	// / 打印
	// / </summary>
	// / <param name="msg"></param>
	public static void Print(String msg) {
		msg = "["
				+ DateTimeUtils.getCurrentDateTimeString("yyyy-MM-dd HH:mm:ss")
				+ "]" + msg + "\r\n";

		if (ifPrintToFile) {
			try {
				File folder = new File(gLogFileDir);
				if (!folder.exists()) {
					folder.mkdirs();
				}

				FileWriter fw = new FileWriter(gLogFileDir + "/"
						+ DateTimeUtils.getCurrentDateTimeString("yyyyMMdd")
						+ ".log", true);
				BufferedWriter bw = new BufferedWriter(fw);
				bw.write(msg);
				bw.close();
				fw.close();
			} catch (IOException e) {

			}
		}
	}

	public static String getExceptionTrace(Throwable e) {
		if (e != null) {
			StringWriter sw = new StringWriter();
			PrintWriter pw = new PrintWriter(sw);
			e.printStackTrace(pw);
			return sw.toString();
		}
		return "";
	}

}