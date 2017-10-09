package hjon.company.common.utils;

import java.text.DateFormat;
import java.text.NumberFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.regex.Pattern;

public class FormatUtil {
	public static String formatTempContent(String content){
		return content.replace("color: rgb(255, 140, 0); border-width: 0px;", "color:rgb(255,140,0);border-width:0px;")
			.replace("border-right-width: 0px; border-top-width: 0px; border-bottom-width: 0px; color: rgb(255,140,0); border-left-width: 0px", "color:rgb(255,140,0);border-width:0px;");
	}
	/**
	 * 格式化数字字符串
	 * @param 数据类型[string(不格式化),int,double]
	 * @param 字符串
	 * @return 非科学计数法的数字字符串
	 */
	public static String format(String type, String value){
		if(type.equals("int") && value != null && !value.equals("")){
			NumberFormat nf = NumberFormat.getInstance();
			nf.setGroupingUsed(false);
			return nf.format(Long.parseLong(value));
		}
		else if(type.equals("double") && value != null && !value.equals("")){
			NumberFormat nf = NumberFormat.getInstance();
			nf.setGroupingUsed(false);
			return nf.format(Double.parseDouble(value));
		}
		return value;
	}
	
	/**
	 * 判断字符串是否为整数
	 * @param 字符串
	 * @return
	 */
	public static boolean isInt(String str) {    
	    Pattern pattern1 = Pattern.compile("^[-\\+]?[\\d]*$");    
	    Pattern pattern2 = Pattern.compile("^((\\d+?\\d+)[Ee]{1}(\\d+))$");
	    return pattern1.matcher(str).matches() || pattern2.matcher(str).matches();    
    }
	
	/**
	 * 判断字符串是否为浮点数
	 * @param 字符串
	 * @return
	 */
	public static boolean isDouble(String str) {    
	    Pattern pattern1 = Pattern.compile("^[-\\+]?[.\\d]*$");    
	    Pattern pattern2 = Pattern.compile("^[\\+\\-]?[\\d]+([\\.][\\d]*)?([Ee][+-]?[\\d]+)?$");    
	    return pattern1.matcher(str).matches() || pattern2.matcher(str).matches() ;    
	}
	
	public static boolean isFormula(String str) {    
	    return str.startsWith("#{") && str.endsWith("}#"); 
	}
	
	public static String getValueByColumn(HashMap<String, String[]> map, String column){
		for(String k : map.keySet()){
			String _k = k.replace("#{", "").replace("}#", "");
			if(column.equals(_k)){
				return map.get(k)[1];
			}
		}
		return null;
	}
	
	public static String getContentByName(List<HashMap> list, String name){
		for(HashMap item : list){
			if(item.get("Name").equals(name)){
				return item.get("Content").toString();
			}
		}
		return "";
	}
	
	public static Object getValueByName(List<HashMap> list, String name){
		for(HashMap item : list){
			if(item.get("Name").toString().startsWith("#{" + name)){
				return item.get("Content");
			}
		}
		return "";
	}
	
	public static Object getValueByName(List<HashMap> list, String progressId, String name){
		for(HashMap item : list){
			if(item.get("ProgressId").toString().equals(progressId) && item.get("Name").toString().startsWith("#{" + name)){
				return item.get("Content");
			}
		}
		return "";
	}
	
	public static String getContentByPrjIdAndName(List<HashMap> list, Integer prjId, String name){
		for(HashMap item : list){
			if(item.get("Name").equals(name) && item.get("ProjectId").equals(prjId)){
				return item.get("Content") == null ? "" : item.get("Content").toString();
			}
		}
		return "";
	}
	
	public static HashMap getItemByPrjIdAndName(List<HashMap> list, String prjId, String name){
		for(HashMap item : list){
			if(item.get("Name").equals(name) && item.get("ProjectId").toString().equals(prjId)){
				return item;
			}
		}
		return new HashMap();
	}
	
	public static HashMap getItemByViewIdAndPrjIdAndName(List<HashMap> list, Integer viewId, String prjId, String name){
		for(HashMap item : list){
			if(item.get("ViewId").equals(viewId) &&item.get("Name").equals(name) && item.get("ProjectId").toString().equals(prjId)){
				return item;
			}
		}
		return new HashMap();
	}
	
	public static Object getContentByProgressIdAndName(List<HashMap> list, String progressId, String name){
		for(HashMap item : list){
			if(item.get("Name").equals(name) && item.get("ProgressId").toString().equals(progressId)){
				return item.get("Content");
			}
		}
		return 0;
	}
	
	public static String getActivityName(String uniquedActivityName){
		return (uniquedActivityName.contains("|") ?  uniquedActivityName.split("\\|")[0]+"_"+uniquedActivityName.split("_")[1] : uniquedActivityName);
	}
	
	public static String getNameWithoutUUID(String name){
		return (name.contains("|") ?  name.split("\\|")[1] : name);
	}
	
	public static String toString(String str){
		if(str == null) {
			return "";
		}
		return str;
	}
	
	public static String toString(Object str){
		if(str == null) {
			return "";
		}
		return str.toString();
	}
	
	public static int toNumber(Integer obj){
		if(obj == null) {
			return 0;
		}
		return obj;
	}
	
	public static Date stringToDate(String dateStr,String formatStr){
		DateFormat sdf=new SimpleDateFormat(formatStr);
		Date date=null;
		try {
			date = sdf.parse(dateStr);
		} catch (ParseException e) {
			e.printStackTrace();
		}
		return date;
	}
}
