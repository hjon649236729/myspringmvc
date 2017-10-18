package com.hjon.common.file;

import com.hjon.config.Constant;

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

import org.apache.commons.io.input.SwappedDataInputStream;

public class DownloadAttachment extends HttpServlet {
	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String filePath = decodeUrl(request.getParameter("p"));

		filePath = (Constant.UploadFileRootPath + filePath);
		// LogHelper.Debug(filePath);
		File obj = new File(filePath);
		if (!obj.exists()) {
			response.setContentType("text/html;charset=utf-8");
			// LogHelper.Error("指定文件不存在:"+filePath);
			return;
		}

		String fileName = "";
		fileName = filePath.substring(filePath
				.lastIndexOf(Constant.PathSeparator) + 1);

		ServletOutputStream out = response.getOutputStream();

		if (fileName.toLowerCase().endsWith("jpg")
				|| fileName.toLowerCase().endsWith("png")
				|| fileName.toLowerCase().endsWith("gif")
				|| fileName.toLowerCase().endsWith("bmp")
				|| fileName.toLowerCase().endsWith("ret")
				|| fileName.toLowerCase().endsWith("frm")) {
			response.setContentType("image/jpg");
			response.setHeader("Content-disposition", "inline;filename="
					+ fileName);
		} else if (fileName.toLowerCase().endsWith("xlsx")) {
			response.setContentType("application/octet-stream");
			response.setHeader("Content-disposition", "inline;filename="
					+ fileName);
		} else {
			response.setHeader("Content-disposition", "attachment;filename=\""
					+ URLEncoder.encode(fileName, "UTF-8") + "\"");
		}
		if (fileName.endsWith("ret")) {
			String faceTag = request.getParameter("faceTag");

			long currentPosition = 0;

			FileInputStream in = new FileInputStream(obj);
			SwappedDataInputStream dis = new SwappedDataInputStream(in);

			while (currentPosition < obj.length()) {
				long theFaceTag = dis.readLong();
				currentPosition += 8;
				if (theFaceTag == Long.parseLong(faceTag)) {
					dis.skip(32);
					currentPosition += 32;
					int len = dis.readInt();// 图片buffer的长度
					currentPosition += 4;
					int pairNum = dis.readInt();// 比较结果集元素的个数
					currentPosition += 4;
					dis.skip(pairNum * 16);
					currentPosition += pairNum * 16;

					if (len > 0) {
						currentPosition += len;
						byte[] imgData = new byte[len];
						dis.read(imgData);

						BufferedOutputStream bos = null;
						try {
							bos = new BufferedOutputStream(out);
							bos.write(imgData);
						} catch (IOException e) {
							throw e;
						} finally {
							if (bos != null)
								bos.close();
						}
					}
					break;
				} else {
					dis.skip(32);
					currentPosition += 32;
					int len = dis.readInt();// 图片buffer的长度
					currentPosition += 4;
					int pairNum = dis.readInt();// 比较结果集元素的个数
					currentPosition += 4;
					dis.skip(pairNum * 16);
					currentPosition += pairNum * 16;
					if (len > 0) {
						currentPosition += len;
						dis.skip(len);
					}
				}
			}

			dis.close();
			in.close();
		}
		if (fileName.endsWith("frm")) {
			FileInputStream in = new FileInputStream(obj);
			SwappedDataInputStream dis = new SwappedDataInputStream(in);
			// int fLen = dis.readInt();
			dis.skipBytes(12);
			int len = dis.readInt();
			dis.skipBytes(4);
			if (len > 0) {
				byte[] imgData = new byte[len];
				dis.read(imgData);

				BufferedOutputStream bos = null;
				try {
					bos = new BufferedOutputStream(out);
					bos.write(imgData);
				} catch (IOException e) {
					throw e;
				} finally {
					if (bos != null)
						bos.close();
				}
			}

			dis.close();
			in.close();
		} else {
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
	}

	public String decodeUrl(String paramter) {
		try {
			return URLDecoder.decode(paramter, "UTF-8");
		} catch (UnsupportedEncodingException e) {
		}
		throw new RuntimeException();
	}

}