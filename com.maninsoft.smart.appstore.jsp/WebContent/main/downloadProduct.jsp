<%@page language="java" pageEncoding="UTF-8" contentType="text/html;charset=UTF-8"%>
<%@include file="/common/config.jsp"%>
<%@page import="com.maninsoft.smart.market.model.SwmProduct"%>
<%@page import="com.maninsoft.framework2smart.StoreApi"%>
<%@page import="java.util.Map"%>
<%
	String objId = "";
	if (request.getParameter("objId") != null) {
		objId = request.getParameter("objId");
	}

	SwmProduct product = StoreApi.getProduct(S_ID, objId);
	Map resultMap = StoreApi.downloadProduct(S_ID, S_URL, product);
	
	String objStr = "";
	String status = (String)resultMap.get("status");
	String resultStr = null;
	
	if (status.equalsIgnoreCase("OK")) {         		//success
		resultStr = status;
	} else {
		resultStr = (String)resultMap.get("result");  	//fail
	}
%><%=resultStr %>

