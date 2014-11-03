<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%
	SwmProduct productObj = StoreApi.getProduct("misadmin", "4028808422328ec40122329cea4a0002");
	String value = productObj.getValue();
	value = XmlUtil.encode(value);
%>

<%@page import="com.maninsoft.framework2smart.StoreApi"%>
<%@page import="com.maninsoft.smart.market.model.SwmProduct"%>
<%@page import="com.maninsoft.util.XmlUtil"%><html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
</head>
<body>
<form action="http://localhost:8081/smartserver/services/market/appStoreDownService.jsp" method="post">
	<input type="text" name="userId" id="userId" value="kmyu@maninsoft.co.kr">
	<textarea id="packages" name="packages" style="width: 99%; height: 500px;"><%=value%></textarea>
	<input type="submit" value="ok">
</form>
</body>
</html>