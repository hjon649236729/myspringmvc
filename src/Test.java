import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

import sun.misc.BASE64Encoder;

public class Test {

	/**
	 * @param args
	 */
	public static void main(String[] args) {
		// TODO Auto-generated method stub
		try {
			String userName = "linxianguo";
			String strTemp = String.valueOf(userName + "oazty").trim();
			MessageDigest digest;
			digest = MessageDigest.getInstance("MD5");
			byte[] temp = digest.digest(strTemp.getBytes());
			// 2 BASE64 编码
			BASE64Encoder encoder = new BASE64Encoder();
			String md5UserName = encoder.encodeBuffer(temp).trim();
			md5UserName = md5UserName.replace("+", " ");
			// 测试发现第一个空格会被替换掉
			md5UserName = md5UserName.substring(0, 1).replace(" ", "")
					+ md5UserName.substring(1);
			System.out.println(md5UserName);
			String url ="http://10.3.3.54/oalogon.action?method=execute&strUserName="+userName+"&strTempInfo="+md5UserName+"&time=17:21:15:572";
			System.out.println(url);
		} catch (NoSuchAlgorithmException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

	}
}
