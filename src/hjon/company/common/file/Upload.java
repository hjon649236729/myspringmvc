package hjon.company.common.file;

import hjon.company.common.utils.DateTimeUtils;
import hjon.company.common.utils.LogHelper;
import hjon.company.config.Constant;

import java.awt.image.BufferedImage;
import java.io.BufferedInputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.Iterator;
import java.util.List;
import java.util.UUID;

import javax.imageio.ImageIO;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

public class Upload extends HttpServlet {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}

	protected void doPost(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		try {
			request.setCharacterEncoding("UTF-8");
			response.setCharacterEncoding("UTF-8");
			String rootFolder = request.getParameter("rootFolder");
			String uuid = UUID.randomUUID().toString();
			if (rootFolder == null) {
				rootFolder = Constant.PathSeparator;
			} else {
				if (!rootFolder.startsWith("/")) {
					rootFolder = "/" + rootFolder;
				}
				if (!rootFolder.endsWith("/")) {
					rootFolder = rootFolder + "/";
				}
			}
			String savePath = Constant.UploadFileRootPath + rootFolder;
			DiskFileItemFactory fac = new DiskFileItemFactory();
			ServletFileUpload upload = new ServletFileUpload(fac);
			upload.setHeaderEncoding("utf-8");

			File folder = new File(savePath);
			if (!folder.exists()) {
				folder.mkdirs();
			}
			String currentDir = DateTimeUtils.getCurrentDateTimeString("yyyy")
					+ "/" + DateTimeUtils.getCurrentDateTimeString("MM") + "/"
					+ DateTimeUtils.getCurrentDateTimeString("dd") + "/";
			savePath = savePath + currentDir;
			savePath = savePath.replace("//", "/");
			File path = new File(savePath);
			if (!path.exists()) {
				path.mkdirs();
			}
			List<FileItem> fileList = null;
			try {
				fileList = upload.parseRequest(request);
			} catch (FileUploadException ex) {
				ex.printStackTrace();
				return;
			}
			String fileName = "";
			Iterator<FileItem> it = fileList.iterator();
			StringBuffer html = new StringBuffer();
			String realName = "";
			String extName = "";
			long fileSize = 0L;
			while (it.hasNext()) {
				FileItem item = it.next();
				if (!item.isFormField()) {
					fileName = realName = item.getName();
					fileSize = item.getSize() / 1024L;

					if ((realName == null) || (realName.trim().equals(""))) {
						continue;
					}
					if (realName.lastIndexOf(".") >= 0) {
						extName = realName
								.substring(realName.lastIndexOf(".") + 1);
						realName = realName.substring(0,
								realName.lastIndexOf("."));
					}

					// String storeFileName = DateTimeUtils
					// .getCurrentDateTimeString("yyyyMMddHH24mmssSSS")
					// + "." + extName;
					String storeFileName = uuid + "." + extName;
					File file = new File(savePath + storeFileName);
					if (file.exists()) {
						response.getWriter().print("exist:" + fileName);
						return;
					}

					BufferedInputStream bis = new BufferedInputStream(
							item.getInputStream());
					FileOutputStream fos = new FileOutputStream(file);
					int len = -1;
					byte[] buffer = new byte[1024 * 4];
					while ((len = bis.read(buffer)) != -1) {
						fos.write(buffer, 0, len);
					}
					bis.close();
					fos.close();

					String fileInfo = "";
					try {

					} catch (Exception e) {
						e.printStackTrace();
					}
					if (request.getParameter("type") != null
							&& request.getParameter("type").equals("image")) {
						InputStream is = item.getInputStream();
						BufferedImage buff = ImageIO.read(is);
						int w = 0;
						int h = 0;
						try {
							w = buff.getWidth();
							h = buff.getHeight();
						} catch (Exception ex1) {

						}
						is.close(); // 关闭Stream
						fileInfo = "{uuid:'"
								+ uuid
								+ "',fileName:'"
								+ realName
								+ "',fileType:'"
								+ extName
								+ "',fileSize:'"
								+ fileSize
								+ "',savePath:'"
								+ (rootFolder + "/" + currentDir + "/" + storeFileName)
										.replace("//", "/") + "','width':'" + w
								+ "','height':'" + h + "'}";
					} else {
						fileInfo = "{uuid:'"
								+ uuid
								+ "',fileName:'"
								+ realName
								+ "',fileType:'"
								+ extName
								+ "',fileSize:'"
								+ fileSize
								+ "',savePath:'"
								+ (rootFolder + "/" + currentDir + "/" + storeFileName)
										.replace("//", "/") + "'}";
					}
					html.append(fileInfo);
				}
			}
			response.getWriter().print(html.toString());
		} catch (IOException ex) {
			LogHelper.Error(ex);
			throw ex;
		}

	}
}