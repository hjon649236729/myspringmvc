package com.hjon.common.file;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.net.URLEncoder;

import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.hjon.config.Constant;

public class WarningMessageDownload extends HttpServlet {
	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String filePath = decodeUrl(request.getParameter("p"));
//		String ctxPath = request.getSession().getServletContext()
//				.getRealPath("/");
//		filePath = (ctxPath + "/templates/" + filePath);
		//LogHelper.Debug(filePath);
		File obj = new File(filePath);
		if (!obj.exists()) {
			response.setContentType("text/html;charset=utf-8");
			//LogHelper.Error("指定文件不存在:" + filePath);
			return;
		}

		String fileName = "";
		fileName = filePath.substring(filePath
				.lastIndexOf(Constant.PathSeparator) + 1);

		ServletOutputStream out = response.getOutputStream();

		if (fileName.toLowerCase().endsWith("xlsx")) {
			response.setContentType("application/octet-stream");
			response.setHeader("Content-disposition", "inline;filename="
					+ fileName);
		} else {
			response.setHeader("Content-disposition", "attachment;filename=\""
					+ URLEncoder.encode(fileName, "UTF-8") + "\"");
		}
		BufferedInputStream bis = null;
		BufferedOutputStream bos = null;
		try {
			bis = new BufferedInputStream(new FileInputStream(filePath));
			bos = new BufferedOutputStream(out);
			byte[] buff = new byte[2048];
			int bytesRead;
			while (-1 != (bytesRead = bis.read(buff, 0, buff.length))) {
				bos.write(buff, 0, bytesRead);
			}
		} catch (IOException e) {
			throw e;
		} finally {
			if (bis != null)
				bis.close();
			if (bos != null)
				bos.close();
		}
	}

	public String decodeUrl(String paramter) {
		try {
			return URLDecoder.decode(paramter, "UTF-8");
		} catch (UnsupportedEncodingException e) {
		}
		throw new RuntimeException();
	}

}