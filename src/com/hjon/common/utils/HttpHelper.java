package com.hjon.common.utils;

import java.io.ByteArrayOutputStream;
import java.io.InputStream;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.Map;
import java.util.Map.Entry;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
import java.util.zip.DeflaterInputStream;
import java.util.zip.DeflaterOutputStream;
import java.util.zip.GZIPInputStream;
import java.util.zip.GZIPOutputStream;

public class HttpHelper {
	public static String sendGet(String url) throws Exception {
		return send(url, "GET", null, null);
	}
	
	public static String sendPost(String url, byte[] data) throws Exception {
		return send(url, "POST", data , null);
	}
	
	public static String sendDelete(String url, byte[] data) throws Exception {
		return send(url, "DELETE", data , null);
	}
	
	public static String sendPut(String url, byte[] data) throws Exception {
		return send(url, "PUT", data , null);
	}
	
	public static String send(String url, String method, byte[] data, Map<String,String> headers) throws Exception {
		HttpURLConnection conn = getConnection(url, method, data, headers);
		return send(conn);
	}
	
	private static String send(HttpURLConnection conn) throws Exception {
		String result = null;
		String charset = conn.getHeaderField("Content-Type");
		charset = detectCharset(charset);
		InputStream input = getInputStream(conn);
		ByteArrayOutputStream output = new ByteArrayOutputStream();
		int count;
		byte[] buffer = new byte[4096];
		while ((count = input.read(buffer, 0, buffer.length)) > 0) {
			output.write(buffer, 0, count);
		}
		input.close();
		// 若已通过请求头得到charset，则不需要去html里面继续查找
		if (charset == null || charset.equals("")) {
				charset = detectCharset(output.toString());
			// 若在html里面还是未找到charset，则设置默认编码为utf-8
			if (charset == null || charset.equals("")) {
				charset = "utf-8";
			}
		}
		result = output.toString(charset);
		output.close();
		// result = output.toString(charset);
		// BufferedReader bufferReader = new BufferedReader(new
		// InputStreamReader(input, charset));
		// String line;
		// while ((line = bufferReader.readLine()) != null) {
		// if (result == null)
		// bufferReader.mark(1);
		// result += line;
		// }
		// bufferReader.close();
		return result;
	}
	
	private static String detectCharset(String input) {
		Pattern pattern = Pattern.compile("charset=\"?([\\w\\d-]+)\"?;?", Pattern.CASE_INSENSITIVE);
		if (input != null && !input.equals("")) {
			Matcher matcher = pattern.matcher(input);
			if (matcher.find()) {
				return matcher.group(1);
			}
		}
		return null;
	}
	
	private static InputStream getInputStream(HttpURLConnection conn) throws Exception {
		String ContentEncoding = conn.getHeaderField("Content-Encoding");
		if (ContentEncoding != null) {
			ContentEncoding = ContentEncoding.toLowerCase();
			if (ContentEncoding.indexOf("gzip") != 1)
			return new GZIPInputStream(conn.getInputStream());
			else if (ContentEncoding.indexOf("deflate") != 1)
			return new DeflaterInputStream(conn.getInputStream());
		}
		return conn.getInputStream();
	}
	
	static HttpURLConnection getConnection(String url, String method, byte[] data, Map<String,String> header) throws Exception {
		HttpURLConnection conn = (HttpURLConnection) (new URL(url)).openConnection();
		conn.setRequestMethod(method);
		// 设置通用的请求属性
		conn.setRequestProperty("Accept", "text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8");
		conn.setRequestProperty("Connection", "keep-alive");
		conn.setRequestProperty("User-Agent", "Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/33.0.1750.117 Safari/537.36");
		conn.setRequestProperty("Accept-Encoding", "gzip,deflate");
		String ContentEncoding = null;
		if (header != null) {
			for (Entry<String,String> entry : header.entrySet()) {
			if (entry.getKey().equalsIgnoreCase("Content-Encoding"))
				ContentEncoding = entry.getValue();
				conn.setRequestProperty(entry.getKey(), entry.getValue());
			}
		}
		if (method == "POST") {
			conn.setDoOutput(true);
			conn.setDoInput(true);
			if (data != null) {
				OutputStream output = conn.getOutputStream();
				if (ContentEncoding != null) {
					if (ContentEncoding.indexOf("gzip") > 0) {
						output=new GZIPOutputStream(output);
					}
					else if(ContentEncoding.indexOf("deflate") > 0) {
						output=new DeflaterOutputStream(output);
					}
				}
				output.write(data);
			}
		}
		// 建立实际的连接
		conn.connect();
		return conn;
	}
}
