<%@page language="java" pageEncoding="UTF-8" contentType="text/html;charset=UTF-8"%>
<%@include file="/common/config.jsp"%>
<%
	session.invalidate();
	response.sendRedirect(ROOT_DIR);
%>

