package hjon.company.common.file;

import hjon.company.config.Constant;

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

public class Download extends HttpServlet {
	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String filePath = decodeUrl(request.getParameter("p"));
		String fileName = request.getParameter("fileName");
		String fileType = request.getParameter("fileType");
		if (fileName != null && fileType != null) {
			fileName = decodeUrl(fileName) + "." + decodeUrl(fileType);
		} else {
			fileName = filePath.substring(filePath
					.lastIndexOf(Constant.PathSeparator) + 1);
		}

		filePath = (Constant.UploadFileRootPath + filePath);
		File obj = new File(filePath);
		if (!obj.exists()) {
			response.setContentType("text/html;charset=utf-8");
			return;
		}
		if (fileName.toLowerCase().endsWith("jpg")
				|| fileName.toLowerCase().endsWith("png")
				|| fileName.toLowerCase().endsWith("gif")
				|| fileName.toLowerCase().endsWith("bmp")) {
			response.setContentType("image/jpg");
			/*
			 * response.setHeader("Content-disposition", "inline;filename=" +
			 * URLEncoder.encode(fileName, "UTF-8") );
			 */
		}
		ServletOutputStream out = response.getOutputStream();
		response.setHeader("Content-disposition", "attachment;filename=\""
				+ URLEncoder.encode(fileName, "UTF-8") + "\"");
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