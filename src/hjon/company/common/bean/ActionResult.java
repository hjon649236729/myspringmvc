package hjon.company.common.bean;

public class ActionResult {
	public ActionResult(String navTabId)
	{
		this.statusCode=200;
		this.message="操作成功";
		this.navTabId=navTabId;
		this.callbackType="closeCurrent";
	}
	public ActionResult(String navTabId,String callbackType)
	{
		this.statusCode=200;
		this.message="操作成功";
		this.navTabId=navTabId;
		this.callbackType=callbackType;
	}
	public ActionResult(int statusCode,String message)
	{
		this.statusCode=statusCode;
		this.message=message;
	}
	public ActionResult(String message,String navTabId,String callbackType)
	{
		this.statusCode=200;
		this.message=message;
		this.navTabId=navTabId;
		this.callbackType=callbackType;
	}
	public ActionResult(int statusCode,String message,String navTabId,String callbackType)
	{
		this.statusCode=statusCode;
		this.message=message;
		this.navTabId=navTabId;
		this.callbackType=callbackType;
	}
	public ActionResult(int statusCode,String message,String navTabId,String callbackType,String rel,String forwardUrl)
	{
		this.statusCode=statusCode;
		this.message=message;
		this.navTabId=navTabId;
		this.callbackType=callbackType;
		this.rel=rel;
		this.forwardUrl=forwardUrl;
	}
	private int statusCode;
	public int getStatusCode()
	{
		return statusCode;
	}
	public void setStatusCode(int statusCode)
	{
		this.statusCode=statusCode;
	}
	
	private String message;
	public String getMessage()
	{
		return message;
	}
	public void setMessage(String message)
	{
		this.message=message;
	}
	
	private String navTabId;
	public String getNavTabId()
	{
		return navTabId;
	}
	public void setNavTabId(String navTabId)
	{
		this.navTabId=navTabId;
	}
	
	private String callbackType;
	public String getCallbackType()
	{
		return callbackType;
	}
	/**
	 * * callbackType如果是closeCurrent就会关闭当前tab
 		"forward"时需要forwardUrl值
	 * @param callbackType
	 */
	public void setCallbackType(String callbackType)
	{
		this.callbackType=callbackType;
	}
	
	private String rel;
	public String getRel()
	{
		return rel;
	}
	public void setRel(String rel)
	{
		this.rel=rel;
	}
	
	private String forwardUrl;
	public String getForwardUrl()
	{
		return forwardUrl;
	}
	public void setForwardUrl(String forwardUrl)
	{
		this.forwardUrl=forwardUrl;
	}
	
	
	private String callbackScript;
	public String getCallbackScript()
	{
		return callbackScript;
	}
	public void setCallbackScript(String callbackScript)
	{
		this.callbackScript=callbackScript;
	}
	
	public String toString()
	{
		StringBuilder result=new StringBuilder();
		result.append("{");
		if(this.message!=null&&!this.message.equals(""))
		{
			result.append("\"message\":\"").append(this.message).append("\",");
		}
		else
		{
			if(this.statusCode==200)
			{
				result.append("\"message\":\"").append("操作成功!").append("\",");
			}
			if(this.statusCode==300)
			{
				result.append("\"message\":\"").append("操作失败,系统错误!").append("\",");
			}
			if(this.statusCode==300)
			{
				result.append("\"message\":\"").append("操作超时!").append("\",");
			}
		}
		if(this.navTabId!=null&&!this.navTabId.equals(""))
		{
			result.append("\"navTabId\":\"").append(this.navTabId).append("\",");
		}
		if(this.callbackType!=null&&!this.callbackType.equals(""))
		{
			result.append("\"callbackType\":\"").append(this.callbackType).append("\",");
		}
		if(this.rel!=null&&!this.rel.equals(""))
		{
			result.append("\"rel\":\"").append(this.rel).append("\",");
		}
		if(this.forwardUrl!=null&&!this.forwardUrl.equals(""))
		{
			result.append("\"forwardUrl\":\"").append(this.forwardUrl).append("\",");
		}
		if(this.callbackScript!=null&&!this.callbackScript.equals(""))
		{
			result.append("\"callbackScript\":\"").append(this.callbackScript).append("\",");
		}
		result.append("\"statusCode\":\"").append(this.statusCode).append("\"");
		result.append("}");
		return result.toString();
	}
}
