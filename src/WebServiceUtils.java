

import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.net.MalformedURLException;
import java.net.URL;
import java.rmi.RemoteException;
import java.util.List;

import javax.activation.DataHandler;
import javax.activation.FileDataSource;
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
public class WebServiceUtils {
	public static void main(String[] args) {

	}
    /**
     * 调用WebServices服务的通用方法
     *
     * @param webServiceURL WebServices服务URL
     * @param methodName    方法名称
     * @param parameters    方法参数
     * @return 返回的字符串
     */
    public static Object sendMessage(String webServiceURL, String methodName, Object[] parameters,List<AttachmentPart> attachments) {
        Service service = null;
        Call call = null;
        QName qName = null;
        URL url = null;
        try {
        	Object[] message=new Object[]{2,1,"{systemNo:'投研',phoneNo:'18301609238',content:'测试短信内容'}"};
        	Object[] email=new Object[]{3,1,"{systemNo:'投研',toList:'zz.he@sinitek.com',title:'123123123123123123123',content:'1231231231231'}"};
            service = new Service();
            qName = new QName("http://172.16.65.40:8091/default/MessageService?wsdl", "sendMessage");
            url = new URL("http://172.16.65.40:8091/default/MessageService?wsdl");

            call = (Call) service.createCall();
            call.setOperationName(qName);
            call.setTargetEndpointAddress(url);
            
           //for(int AttachmentPart a)
           call.addAttachmentPart(attachments);
           // AttachmentPart attachment =new Attachment();
           // call.addAttachmentPart(new Object());
           //call.addAttachmentPart();
           //call.addAttachmentPart(attachment)
           
            return call.invoke(message);
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
    public static List<AttachmentPart> getAttachments(File file){
    	//String fileName1 = new String("/local/data/g.txt"); 
    	//File file1 = new File(fileName1); ]
    	
    	DataHandler attachment = new DataHandler(new 
    	FileDataSource(file)); 
    	//_call.addAttachmentPart(attachmentFile1); 
    	return null;
    }
}
