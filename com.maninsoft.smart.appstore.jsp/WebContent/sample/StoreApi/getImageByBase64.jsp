
<%@page import="com.maninsoft.framework2smart.SmartApi"%><%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%
	String result = SmartApi.getImageAsBase64("pkg_7d07d88b69984f209c2e657f44e908a2", "prc_20273e003aef4fefae8489e3429e91fe");
	out.print(result);	
%>


