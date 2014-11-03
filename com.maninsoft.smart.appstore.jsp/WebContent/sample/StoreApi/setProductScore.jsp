<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@page import="com.maninsoft.smart.market.model.SwmProduct"%>
<%@page import="com.maninsoft.framework2smart.StoreApi"%>
<%

	//product를 아이디로 가져온다
	SwmProduct product = StoreApi.setProductScore("kmyu@maninsoft.co.kr", "5e6caf3820174c5c01201d18502f0023", 1);
	String scoreStr = product.getScore();
	double score = Double.parseDouble(scoreStr);
%>    
    
    
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
</head>
<body>
score : <input type="text" value="<%=score %>">
</body>
</html>