package com.hjon.common.utils;

import java.sql.Timestamp;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;


public class DateTimeUtils {

	public static Timestamp  getCurrentDateTime()
	{
		Date nowTime=new Date();
		SimpleDateFormat matter=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss"); //hh:mm:ss是12小时计时法，HH:mm:ss是24小时计时法
		String time = matter.format(nowTime);
		return Timestamp.valueOf(time);
	}
	
	public static Timestamp  getCurrentDateTime(String date)
	{
		
		SimpleDateFormat matter=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss"); //hh:mm:ss是12小时计时法，HH:mm:ss是24小时计时法
		Date nowTime=null;
		try {
			nowTime = matter.parse(date);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			nowTime=new Date();
		}
		String time = matter.format(nowTime);
		return Timestamp.valueOf(time);
	}
	
	public static String  getCurrentDateTimeString(String format)
	{
		DateFormat.getDateInstance().format(new Date());
		SimpleDateFormat matter=new SimpleDateFormat(format);
		return matter.format(new Date());
	}
	
	public static String  formatDateTime(Timestamp time,String format)
	{
		SimpleDateFormat matter=new SimpleDateFormat(format); //hh:mm:ss是12小时计时法，HH:mm:ss是24小时计时法
		return matter.format(time);
	}
	
	public static String getRelativeDay(String date,int n)
	{ 
	   Date temDate = new Date(Timestamp.valueOf(date).getTime());
	   Calendar calendar = Calendar.getInstance(); //new GregorianCalendar(temDate.ge, temDate.getMonth(), temDate.getDay());
	   calendar.setTime(temDate);
	   calendar.add(Calendar.DATE,n); 
	   Date newDate=calendar.getTime();
	   SimpleDateFormat matter=new SimpleDateFormat("yyyy-MM-dd"); //hh:mm:ss是12小时计时法，HH:mm:ss是24小时计时法
	   return matter.format(newDate);
    }
	public static String getTimeOrder(){
		Date date=new Date();
		SimpleDateFormat matter=new SimpleDateFormat("yyyyMMddHHmmss"); //hh:mm:ss是12小时计时法，HH:mm:ss是24小时计时法
		String time = matter.format(date);
		return time;
	}
	
	 /**
	  * 字符串转换成日期 如果转换格式为空，则利用默认格式进行转换操作
	  * @param str 字符串
	  * @param format 日期格式
	  * @return 日期
	  * @throws java.text.ParseException 
	  */
	 public static Date strToDate(String str, String format){
	  if (null == str || "".equals(str)) {
	   return null;
	  }
	  // 如果没有指定字符串转换的格式，则用默认格式进行转换
	  if (null == format || "".equals(format)) {
	   format = "yyyy-MM-dd HH:mm:ss.SSS";
	  }
	  SimpleDateFormat sdf = new SimpleDateFormat(format);
	  Date date = null;
	   try {
	    date = sdf.parse(str);
	    return date;
	   } catch (ParseException e) {
	    e.printStackTrace();
	   }
	  return null;
	 }
	  
	 /** 字符串转换时间戳
	  * @param str
	  * @return
	  */
	 public static Timestamp strToTimestamp(String str) {
	  Date date = strToDate(str, "yyyy-MM-dd HH:mm:ss.SSS");
	  return new Timestamp(date.getTime());
	 }
}
