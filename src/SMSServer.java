import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;

public class SMSServer {
	/**
	 * @param url
	 *            : 发送短信接口服务；
	 * @param lx
	 *            : 处理类型；
	 * @param userName
	 *            : 接口认证的用户名
	 * @param password
	 *            : 接口认证的密码
	 * @param phoneNum
	 *            : 手机号吗
	 * @param content
	 *            : 短信内容；
	 * @param bmlx
	 *            : 编码类型；
	 * @throws IOException
	 * */
	public String SMS(String _url, String lx, String username, String password,
			String phoneNum, String Content, String bmlx) throws IOException {
		String returninfo = "";
		String content = "";
		// 15901245791
		content = java.net.URLEncoder.encode(Content, bmlx);
		if (bmlx == null) {
			content = Content;
		} else if (bmlx.equals("")) {
			content = java.net.URLEncoder.encode(Content);
		} else {
			content = java.net.URLEncoder.encode(Content, bmlx);
		}
		String strurl = _url + "?lx=" + lx + "&DLZH=" + username + "&DLMM="
				+ password + "&SJHM=" + phoneNum + "&XXNR=" + content;
		URL url = new URL(strurl);
		HttpURLConnection huc = (HttpURLConnection) url.openConnection();
		huc.setRequestMethod("Post");
		huc.setRequestProperty("Accept", "*/*");
		huc.setRequestProperty("User-Agent",
				"Profile/MIDP-2.0 Configuration/CLDC-1.0");
		huc.setRequestProperty("Content-Language", "en-US");
		huc.setRequestProperty("Accept-Language", "zh-CN");
		huc.setRequestProperty("Content-type", "text/html");
		System.out.println(strurl);
		BufferedReader br = new BufferedReader(new InputStreamReader(
				huc.getInputStream()));
		String line;
		while ((line = br.readLine()) != null) {
			returninfo = line;
		}
		huc.connect();
		br.close();
		return returninfo;
	}

	public static void main(String[] args) {
		SMSServer server = new SMSServer();
		try {
			String text;
			text = server.SMS("http://220.174.209.181:10031/HttpInterface/HttpService.ashx",
					"0", " hi123456", "d5cd8a049278fbcd4089ff7b82fe4eb6",
					"18301609238", "短信测试内容", "UTF-8");
			System.out.print(text); // 返回值（String）：0、-1、-2、-3…
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
}
