package com.hjon.common.file;

import java.io.File;
import java.util.ArrayList;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class FileStorageNumberStrategy {
	String rootPath;
	int maxFileNumInDirectory=10000;
	public FileStorageNumberStrategy(String rootPath){
		this.rootPath=rootPath;
	}
	
	public String getCurrentDirectoryName()
	{
		return getCurrentDirectoryName(null);
	}
	
	public String getCurrentDirectoryName(String lastDirectoryName)
	{
		if(lastDirectoryName!=null){
			String lastFolderPath=rootPath+"/"+lastDirectoryName;
			lastFolderPath=lastFolderPath.replace("//", "/");
			File lastFolder = new File(lastFolderPath);
			if (!lastFolder.exists()) {
				lastFolder.mkdirs();
				return lastDirectoryName;
			}else{
				if(lastFolder.listFiles().length<maxFileNumInDirectory){
					return lastDirectoryName;
				}
			}
		}

		File folder = new File(rootPath);
		if (!folder.exists()) {
			folder.mkdirs();
		}
		
		long maxFolderName=1;
		List<Long> lstChildFolder=new ArrayList<Long>();
		for(File file : folder.listFiles()){
			if(file.isDirectory()){
				if(isNumeric(file.getName())){
					if(Long.parseLong(file.getName())>maxFolderName){
						maxFolderName=Long.parseLong(file.getName());
					}
				}
			}
		}
		
		String maxFolderPath=rootPath+"/"+maxFolderName;
		maxFolderPath=maxFolderPath.replace("//", "/");
		File maxFolder = new File(maxFolderPath);
		if(!maxFolder.exists()){
			maxFolder.mkdir();
		}else{
			if(maxFolder.listFiles().length>=maxFileNumInDirectory){
				++maxFolderName;
				maxFolderPath=rootPath+"/"+maxFolderName;
				maxFolder = new File(maxFolderPath);
				maxFolder.mkdir();
			}
		}

		return String.valueOf(maxFolderName);
	}
	
	public boolean isNumeric(String str){ 
		   Pattern pattern = Pattern.compile("[0-9]*"); 
		   Matcher isNum = pattern.matcher(str);
		   if( !isNum.matches() ){
		       return false; 
		   } 
		   return true; 
	}
}
