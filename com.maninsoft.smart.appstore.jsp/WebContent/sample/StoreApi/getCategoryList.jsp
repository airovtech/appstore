<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@page import="com.maninsoft.framework2smart.StoreApi"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.Set"%>
<%
	List list = StoreApi.getWorkCategoryList();
	Map businessTypeCategory = (Map)list.get(0); // 업종별
	Map businessCategory = (Map)list.get(1); //업무별
%>    
업종별<br>
<%
	Set keySet = businessTypeCategory.keySet();
	Iterator itr = keySet.iterator();
	while (itr.hasNext()) {
		String code = (String)itr.next();
		String name = (String)businessTypeCategory.get(code);
%>   
코드:<%=code %>, 이름:<%=name %><br>
<%
	}
%>    
업무별<br>
<%
	Set keySet2 = businessCategory.keySet();
	Iterator itr2 = keySet2.iterator();
	while (itr2.hasNext()) {
		String code = (String)itr2.next();
		String name = (String)businessCategory.get(code);
%>   
코드:<%=code %>, 이름:<%=name %><br>
<%
	}
%>      