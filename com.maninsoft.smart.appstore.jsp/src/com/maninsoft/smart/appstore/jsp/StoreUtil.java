package com.maninsoft.smart.appstore.jsp;

import java.util.List;
import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.BeansException;
import org.springframework.beans.factory.BeanFactory;
import org.springframework.beans.factory.BeanFactoryAware;

import com.maninsoft.util.CommonUtil;

public class StoreUtil implements BeanFactoryAware {
	private static Log logger = LogFactory.getLog(StoreUtil.class);
	private static BeanFactory beanFactory;
	private static StoreUtil storeUtil;
	private String asHome;
	private String appFileDirectory;
	
	private Map<String, List<String>> codeMap;
	
	public StoreUtil() {
		super();
		if (logger.isInfoEnabled())
			logger.info(this.getClass() + " loaded");
	}
	
	public static StoreUtil getStoreUtil() {
		if (storeUtil == null)
			storeUtil = (StoreUtil)beanFactory.getBean("storeUtil");
		return storeUtil;
	}
	public static String getCodeValue(String code, String lang) {
		if (CommonUtil.isEmpty(code))
			return null;
		if (CommonUtil.isEmpty(lang))
			lang = "kor";
		int index = 0;
		if (lang.equalsIgnoreCase("eng"))
			index = 1;
		List<String> value = getStoreUtil().codeMap.get(code);
		if (value == null)
			return code;
		return value.get(index);
	}
	public void setBeanFactory(BeanFactory bf) throws BeansException {
		beanFactory = bf;
	}
	public Map<String, List<String>> getCodeMap() {
		return codeMap;
	}
	public void setCodeMap(Map<String, List<String>> codeMap) {
		this.codeMap = codeMap;
	}
	public String getAsHome() {
		return asHome;
	}
	public void setAsHome(String asHome) {
		this.asHome = asHome;
	}
	public static String asHome() {
		return getStoreUtil().getAsHome();
	}
	public String getAppFileDirectory() {
		return appFileDirectory;
	}
	public void setAppFileDirectory(String appFileDirectory) {
		this.appFileDirectory = appFileDirectory;
	}
	public static String appFileDirectory() {
		return getStoreUtil().getAppFileDirectory();
	}
}
