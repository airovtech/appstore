<%@page language="java" pageEncoding="UTF-8" contentType="text/html;charset=UTF-8"%>
<%@page import="com.maninsoft.util.CommonUtil"%>
<%
String message = CommonUtil.toNotNull(request.getParameter("message"));
%>
<jsp:include page="../roundTable/prefix.jsp" flush="true">
	<jsp:param name="width" value=""/>
	<jsp:param name="height" value=""/>
	<jsp:param name="padding" value=""/>
	<jsp:param name="borderColor" value=""/>
	<jsp:param name="backgroundColor" value=""/>
	<jsp:param name="style" value="text-align: center;"/>
</jsp:include>
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<%=message%>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<br>
<jsp:include page="button/modal.jsp" flush="true"/>
<jsp:include page="../roundTable/suffix.jsp" flush="true">
	<jsp:param name="padding" value=""/>
	<jsp:param name="borderColor" value=""/>
	<jsp:param name="backgroundColor" value=""/>
</jsp:include>