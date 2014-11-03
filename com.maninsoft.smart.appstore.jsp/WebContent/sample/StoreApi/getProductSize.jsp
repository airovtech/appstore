<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@page import="com.maninsoft.framework2smart.StoreApi"%>
<%@page import="com.maninsoft.smart.market.model.SwmProduct"%>
<%@page import="com.maninsoft.util.CommonUtil"%>
<%@page import="com.maninsoft.smart.market.model.SwmProductNumeral"%>
<%@page import="com.maninsoft.smart.market.model.SwmProductCond"%>
<%@page import="java.util.Date"%>
<%@page import="java.util.Calendar"%>

<%
	Calendar cal = Calendar.getInstance();
	cal.add(Calendar.DATE, -7);
	SwmProductCond cond = new SwmProductCond();
	cond.setFromDate(cal.getTime());
	long size = StoreApi.getProductsSize("kmyu@maninsoft.co.kr", cond);
%>
	<html>
	<body>
		size : <input type="text" value="<%= size %>"/>
	</body>
	</html>
