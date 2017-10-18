package com.hjon.common.utils;

import java.text.NumberFormat;
import java.util.Locale;

public class FloatUtil {
	public static String add(String a,String b)
	{
		a=a.replace(",", "");
		b=b.replace(",", "");
		double a1=Double.parseDouble(a);
		double b1=Double.parseDouble(b);
		double result=a1+b1;
		NumberFormat nf2 = NumberFormat.getInstance(Locale.CHINA);
		return nf2.format(result).replace(",", "");
	}
	
	public static String subtract(String a,String b)
	{
		a=a.replace(",", "");
		b=b.replace(",", "");
		double a1=Double.parseDouble(a);
		double b1=Double.parseDouble(b);
		double result=a1-b1;
		NumberFormat nf2 = NumberFormat.getInstance(Locale.CHINA);
		return nf2.format(result).replace(",", "");
	}
}
