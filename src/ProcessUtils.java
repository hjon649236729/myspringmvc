

import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.net.MalformedURLException;
import java.net.URL;
import java.rmi.RemoteException;

import javax.xml.namespace.QName;
import javax.xml.soap.AttachmentPart;

import org.apache.axis.client.Call;
import org.apache.axis.client.Service;
import org.hibernate.service.spi.ServiceException;

/**
 * Created by IntelliJ IDEA.
 * User: sinitek
 * Date: 12-1-16
 * Time: 下午4:43
 * To change this template use File | Settings | File Templates.
 */
public class ProcessUtils {
	public static void main(String[] args) {
		Object a=callMethod("http://114.255.222.211/services/WeixinWebService?wsdl","findSearchReportList",new Object[]{"{condition:[{rowstart:1,rowend:30,isIndustryType:2,keyword:\"\",starttime:\"\",endtime:\"\"}]}"});
		
		System.out.println(a.toString());
/*	Object b=callMethod("http://114.255.222.211/services/WeixinWebService?wsdl","getReportById",new Object[]{"{condition:[{objid:23876}]}"});
		System.out.println(b.toString());*/
///http://114.255.222.211/rschreport/innerreport/downloadattachment.action?id=44286&msirm=sinitek&fromuser=999000001
	
	}
	public static void byte2File(byte[] buf, String filePath, String fileName)  
    {  
        BufferedOutputStream bos = null;  
        FileOutputStream fos = null;  
        File file = null;  
        try  
        {  
            File dir = new File(filePath);  
            if (!dir.exists() && dir.isDirectory())  
            {  
                dir.mkdirs();  
            }  
            file = new File(filePath + File.separator + fileName);  
            fos = new FileOutputStream(file);  
            bos = new BufferedOutputStream(fos);  
            bos.write(buf);  
        }  
        catch (Exception e)  
        {  
            e.printStackTrace();  
        }  
        finally  
        {  
            if (bos != null)  
            {  
                try  
                {  
                    bos.close();  
                }  
                catch (IOException e)  
                {  
                    e.printStackTrace();  
                }  
            }  
            if (fos != null)  
            {  
                try  
                {  
                    fos.close();  
                }  
                catch (IOException e)  
                {  
                    e.printStackTrace();  
                }  
            }  
        }  
    }  
    /**
     * 调用WebServices服务的通用方法
     *
     * @param webServiceURL WebServices服务URL
     * @param methodName    方法名称
     * @param parameters    方法参数
     * @return 返回的字符串
     */
    public static Object callMethod(String webServiceURL, String methodName, Object[] parameters) {
        Service service = null;
        Call call = null;
        QName qName = null;
        URL url = null;
        try {
            service = new Service();
            qName = new QName(webServiceURL, methodName);
            url = new URL(webServiceURL);

            call = (Call) service.createCall();
            call.setOperationName(qName);
            call.setTargetEndpointAddress(url);
           // AttachmentPart attachment =new Attachment();
           // call.addAttachmentPart(new Object());
            //call.addAttachmentPart();
            //call.addAttachmentPart(attachment)
            return call.invoke(parameters);
        } catch (MalformedURLException e) {
          //  LogUtils.error(ProcessUtils.class, e.getMessage());
        } catch (RemoteException e) {
          //  LogUtils.error(ProcessUtils.class, e.getMessage());
        } catch (ServiceException e) {
          //  LogUtils.error(ProcessUtils.class, e.getMessage());
        } catch (javax.xml.rpc.ServiceException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
            service = null;
            call = null;
            qName = null;
            url = null;
        }
       
		return "调用失败";
    }
}
