package hjon.company.common.utils;

public class SqlUtils {
	public static String format(String sql, Object... params){
		for(Object param : params){
			sql = sql.replaceFirst("\\?", param.toString());
		}
		return sql;
	}
}
