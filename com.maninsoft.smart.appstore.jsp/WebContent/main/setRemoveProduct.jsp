<%@page language="java" pageEncoding="UTF-8" contentType="text/html;charset=UTF-8"%>
<%@include file="/common/config.jsp"%>
<%@page import="com.maninsoft.smart.market.model.SwmProduct"%>
<%@page import="com.maninsoft.framework2smart.StoreApi"%><%
	String objId = "";
	if (request.getParameter("objId") != null) {
		objId = request.getParameter("objId");
	}
	
	StoreApi.removeProduct(S_ID, objId);
%><result status="success">
	<a/>
	<b/>
	<c/>
</result>
