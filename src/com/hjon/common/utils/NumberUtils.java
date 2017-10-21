package com.hjon.common.utils;

//
//Source code recreated from a .class file by IntelliJ IDEA
//(powered by Fernflower decompiler)
//

import java.math.BigDecimal;
import java.text.DecimalFormat;
import java.util.Map;

import org.apache.commons.lang3.StringUtils;

public class NumberUtils {
	private static final int FourDecimalMedian = 4;
	public static final int YI = 100000000;
	public static final int WAN = 10000;

	public NumberUtils() {
	}

	public static Integer safeToInteger(Object o, Integer dv) {
		Integer r = dv;
		if (o != null) {
			try {
				r = new Integer(String.valueOf(o));
			} catch (Exception var4) {
				;
			}
		}

		return r;
	}

	public static Long safeToLong(Object o, Long dv) {
		// TODO Auto-generated method stub
		Long r = dv;
		if (o != null) {
			r = new Long(String.valueOf(o));
		}
		return r;
	}

	public static Double safeToDouble(Object o, Double dv) {
		Double r = dv;
		if (o != null) {
			try {
				r = new Double(String.valueOf(o));
			} catch (Exception var4) {
				;
			}
		}

		return r;
	}

	public static Double safeToDouble(Object o, Double dv, int round) {
		Double r = dv;
		if (o != null) {
			try {
				r = new Double(String.valueOf(o));
			} catch (Exception var5) {
				;
			}
		}

		r = Double.valueOf((new BigDecimal(r.doubleValue())).setScale(round, 4)
				.doubleValue());
		return r;
	}

	public static Float safeToFloat(Object o, Float dv) {
		Float r = dv;
		if (o != null) {
			try {
				r = new Float(String.valueOf(o));
			} catch (Exception var4) {
				;
			}
		}

		return r;
	}

	public static Float safeToFloat(Object o, Float dv, int round) {
		Float r = dv;
		if (o != null) {
			try {
				r = new Float(String.valueOf(o));
			} catch (Exception var5) {
				;
			}
		}

		r = Float.valueOf((new BigDecimal((double) r.floatValue())).setScale(
				round, 4).floatValue());
		return r;
	}

	public static BigDecimal stringToBigDecimal(String paraValue) {
		try {
			Object e = null;
			return paraValue.indexOf("%") == -1 ? (new BigDecimal(Double
					.valueOf(paraValue.trim().replace(",", "")).doubleValue()))
					.setScale(4, 4) : (new BigDecimal(Double.valueOf(
					paraValue.trim().replace("%", "")).doubleValue() / 100.0D))
					.setScale(4, 4);
		} catch (Exception var2) {
			var2.printStackTrace();
			return null;
		}
	}

	public static BigDecimal stringToBigDecimalTwoSpilt(String paraValue) {
		try {
			Object e = null;
			return paraValue.indexOf("%") == -1 ? (new BigDecimal(Double
					.valueOf(paraValue.trim().replace(",", "")).doubleValue()))
					.setScale(2, 4) : (new BigDecimal(Double.valueOf(
					paraValue.trim().replace("%", "")).doubleValue() / 100.0D))
					.setScale(4, 4);
		} catch (Exception var2) {
			var2.printStackTrace();
			return null;
		}
	}

	public static BigDecimal aSubtractB(BigDecimal aParaValue,
			BigDecimal bParaValue) {
		try {
			return aParaValue.subtract(bParaValue).setScale(4, 4);
		} catch (Exception var3) {
			var3.printStackTrace();
			return null;
		}
	}

	public static BigDecimal aDivideB(BigDecimal aParaValue,
			BigDecimal bParaValue) {
		try {
			return aParaValue.divide(bParaValue, 4).setScale(4, 4);
		} catch (Exception var3) {
			var3.printStackTrace();
			return null;
		}
	}

	public static double avg(double[] sequenceArr) {
		if (sequenceArr != null && sequenceArr.length > 0) {
			double sum = 0.0D;
			int T = sequenceArr.length;

			for (int i = 0; i < T; ++i) {
				sum += sequenceArr[i];
			}

			return sum / (double) T;
		} else {
			return 0.0D;
		}
	}

	public static double round(double value, int count) {
		int t = (int) Math.pow(10.0D, (double) (count + 1));
		return (double) Math.round(value * (double) t) / (double) t;
	}

	public static Double getFourDecimalNumber(Number number) {
		if (number != null && 0.0D != number.doubleValue()) {
			DecimalFormat format = new DecimalFormat("##0.0000");
			return Double.valueOf(format.format(number));
		} else {
			return Double.valueOf(0.0D);
		}
	}

	public static Integer convertMapKeyToInt(Map map, String key,
			Integer defaultValue) {
		return safeToInteger(map.get(key), defaultValue);
	}

	public static Integer convertMapKeyToInt(Map map, String key) {
		return convertMapKeyToInt(map, key, Integer.valueOf(0));
	}

	public static String convertIntArrayToString(int[] intArray) {
		if (intArray.length <= 0) {
			return "";
		} else {
			String _string = "";
			int[] arr$ = intArray;
			int len$ = intArray.length;

			for (int i$ = 0; i$ < len$; ++i$) {
				int _int = arr$[i$];
				_string = _string
						+ (_string.equals("") ? (new Integer(_int)).toString()
								: "," + (new Integer(_int)).toString());
			}

			return _string;
		}
	}

	public static Double safeAdd(Double v1, Double v2) {
		if (v1 != null && v2 != null) {
			BigDecimal b1 = new BigDecimal(Double.toString(v1.doubleValue()));
			BigDecimal b2 = new BigDecimal(Double.toString(v2.doubleValue()));
			return Double.valueOf(b1.add(b2).doubleValue());
		} else {
			return null;
		}
	}

	public static Double safeSub(Double v1, Double v2) {
		if (v1 != null && v2 != null) {
			BigDecimal b1 = new BigDecimal(Double.toString(v1.doubleValue()));
			BigDecimal b2 = new BigDecimal(Double.toString(v2.doubleValue()));
			return Double.valueOf(b1.subtract(b2).doubleValue());
		} else {
			return null;
		}
	}

	public static Double safeDiv(Double v1, Double v2) {
		return safeDiv(v1, v2, 4);
	}

	public static Double safeDiv(Double v1, Double v2, int sacle) {
		if (v1 != null && v2 != null && v2.doubleValue() != 0.0D) {
			BigDecimal b1 = new BigDecimal(Double.toString(v1.doubleValue()));
			BigDecimal b2 = new BigDecimal(Double.toString(v2.doubleValue()));
			return Double.valueOf(b1.divide(b2, sacle, 4).doubleValue());
		} else {
			return null;
		}
	}

	public static Double safeMul(Double v1, Double v2) {
		if (v1 != null && v2 != null) {
			BigDecimal b1 = new BigDecimal(Double.toString(v1.doubleValue()));
			BigDecimal b2 = new BigDecimal(Double.toString(v2.doubleValue()));
			return Double.valueOf(b1.multiply(b2).doubleValue());
		} else {
			return null;
		}
	}

	public static String formateNumber(double number, String pattern) {
		if (number == 0.0D) {
			return "0";
		} else {
			DecimalFormat decimalFormat = new DecimalFormat(pattern);
			return decimalFormat.format(number);
		}
	}

	public static String formatNumber(String number, String pattern) {
		if (StringUtils.isBlank(number)) {
			return "";
		} else {
			DecimalFormat decimalFormat = new DecimalFormat(pattern);
			return decimalFormat.format(safeToDouble(number,
					Double.valueOf(0.0D)));
		}
	}

}
