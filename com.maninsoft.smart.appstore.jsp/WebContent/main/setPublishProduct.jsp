<%@page language="java" pageEncoding="UTF-8" contentType="text/html;charset=UTF-8"%>
<%@include file="/common/config.jsp"%>
<%@page import="com.maninsoft.smart.market.model.SwmProduct"%>
<%@page import="com.maninsoft.framework2smart.StoreApi"%>
<%
	String objId = "";
	if (request.getParameter("objId") != null) {
		objId = request.getParameter("objId");
	}
	StoreApi.publishProduct(S_ID, objId);
%>
	<img src="<%=ROOT_DIR %>/images/co_stop.jpg" align="top" alt="공유중지" style="cursor:pointer;" onclick="PageUtil.setUnPublishProduct('<%=objId %>')">
