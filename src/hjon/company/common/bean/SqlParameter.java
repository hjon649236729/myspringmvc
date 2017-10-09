package hjon.company.common.bean;

public class SqlParameter {
	public SqlParameter(String type,Object value)
	{
		this.type=type;
		this.value=value;
	}
	
	private String type;
	public String getType()
	{
		return type;
	}
	public void setType(String type)
	{
		this.type=type;
	}
	
	private Object value;
	public Object getValue()
	{
		return value;
	}
	public void setValue(Object value)
	{
		this.value=value;
	}
}
