<%@page language="java" pageEncoding="UTF-8" contentType="text/html;charset=UTF-8"%>
<%@include file="/common/config.jsp"%>
<%@page import="com.maninsoft.smart.market.model.SwmProduct"%>
<%@page import="com.maninsoft.framework2smart.StoreApi"%>
<%
	String objId = "";
	int selScore = 0;	

	if (request.getParameter("objId") != null) {
		objId = request.getParameter("objId");
	}
	if (request.getParameter("selScore") != null) {
		selScore = Integer.parseInt(request.getParameter("selScore"));
	}

	SwmProduct product = StoreApi.setProductScore(S_ID, objId, selScore);
	double score = product.getScore();
	double dStar = score / 2;
	double hStar = score % 2;
	
	out.println("<span class=\"txred\">");
	out.println(score+"/10");
	out.println("</span>");
	
	for (int i=1; i<=dStar; i++) {
		out.print("<img src=\"" + ROOT_DIR + "/images/d_star.gif\" alt=\"\">");
	}
	if (hStar >= 1) {
		out.print("<img src=\"" + ROOT_DIR + "/images/d_starhalf.gif\" alt=\"\">");
	}
%>


