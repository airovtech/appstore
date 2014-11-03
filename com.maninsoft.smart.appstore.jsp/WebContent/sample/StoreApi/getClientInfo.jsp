
<%@page import="com.maninsoft.link.model.LnkObject"%>
<%@page import="com.maninsoft.link.model.LnkList"%>
<%@page import="com.maninsoft.framework2smart.StoreApi"%><%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%
	LnkList obj = StoreApi.getClientSmartWorksInfo();

	LnkObject[] lnkObjs = obj.getItems();
	
	for (int i = 0; i < lnkObjs.length; i++) {
		LnkObject lnkObj = lnkObjs[i];
		String type = lnkObj.getType(); //타입
		String ref = lnkObj.getRef(); //스마트웍스 호출 URL정보
		String label = lnkObj.getLabel(); // 회사 이름
		String desc = lnkObj.getExpression(); //설명
		out.print("타입:" +type+ ", 호출URL:" +ref+ ", 회사이름:" +label+ ", 설명:" +desc+ "<br>");
	}
%>