
<%@page import="com.maninsoft.model.Property"%><%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@page import="com.maninsoft.framework2smart.StoreApi"%>
<%@page import="com.maninsoft.smart.market.model.SwmProduct"%>
<%@page import="com.maninsoft.smart.market.model.SwmProductCond"%>
<%@page import="com.maninsoft.model.Order"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%
	SwmProductCond cond = new SwmProductCond();
	
	cond.setExtendedProperties(new Property[]{new Property("appstore.category.business", 코드값)}); //업무별 검색	

	//cond.setExtendedProperties(new Property[]{new Property("appstore.category.business", 코드값)}); //업무별 검색	
	cond.setExtendedProperties(new Property[]{new Property("appstore.category.businessTypes", "Public")}); //업종별 검색	

	SwmProduct[] objs = StoreApi.getProducts("kmyu@maninsoft.co.kr", cond);

	if (objs != null) {
		for (int i = 0; i < objs.length; i++) {
			SwmProduct obj = objs[i];
			String name = obj.getName();
%>
objectName : <%= name %><br>
<%
		}
	}
%>