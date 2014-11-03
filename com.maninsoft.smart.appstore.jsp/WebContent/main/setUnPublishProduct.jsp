<%@page language="java" pageEncoding="UTF-8" contentType="text/html;charset=UTF-8"%>
<%@include file="/common/config.jsp"%>
<%@page import="com.maninsoft.smart.market.model.SwmProduct"%>
<%@page import="com.maninsoft.framework2smart.StoreApi"%>
<%
	String objId = "";
	if (request.getParameter("objId") != null) {
		objId = request.getParameter("objId");
	}
	StoreApi.unPublishProduct(S_ID, objId);
%>
	<% if (S_COMPANYID.equals("Maninsoft") && S_AUTHID.equals("ADMINISTRATOR")) { %>
		<img src="<%=ROOT_DIR %>/images/co_start.jpg" align="top" alt="공유시작" style="cursor:pointer;" onclick="PageUtil.setPublishProduct('<%=objId %>')">
		<img src="<%=ROOT_DIR %>/images/co_not.jpg" align="top" alt="공유불가" style="cursor:pointer;" onclick="PageUtil.openNotSharedComment('<%=objId %>')">
	<% } else { %>
		<img src="<%=ROOT_DIR %>/images/co_start.jpg" align="top" alt="공유시작" style="cursor:pointer;" onclick="PageUtil.setPublishProduct('<%=objId %>')">
	<% } %>
	<img src="<%=ROOT_DIR %>/images/co_delete.jpg" align="top" alt="삭제" style="cursor:pointer;" onclick="PageUtil.setRemoveProduct('<%=objId %>')">