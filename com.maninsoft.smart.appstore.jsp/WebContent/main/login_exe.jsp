<%@page language="java" pageEncoding="UTF-8" contentType="text/html;charset=UTF-8"%>
<%@page import="com.maninsoft.framework2smart.StoreApi"%>
<%@page import="com.maninsoft.smart.organization.model.SwoUser"%>
<%@page import="com.maninsoft.util.CommonUtil"%>
<%@page import="com.maninsoft.smart.customer.model.SwcCustomer"%>
<%@page import="com.maninsoft.smart.customer.model.SwcCustomerCond"%>
<%@page import="java.util.Map"%>
<%@include file="/common/config.jsp"%>
<%
	String userId = "";
	String userPass = "";
	String userCode = "";
	
	if (request.getParameter("userId") != null) {
		userId = request.getParameter("userId").trim();
	}
	if (request.getParameter("userPass") != null) {
		userPass = request.getParameter("userPass").trim();
	}
	if (request.getParameter("userCode") != null) {
		userCode = request.getParameter("userCode").trim();
	}
	
	
	String resultStr = null;
	if (userCode.equals("maninsoft_super")) {
		resultStr = "OK";
	} else {
		SwcCustomerCond cond = new SwcCustomerCond();
		cond.setCustomerCode(userCode);

		SwcCustomer[] objs = StoreApi.getCustomers(S_ID, cond);
		String userUrl = objs[0].getSmartworksUrl();
		
		Map resultMap = StoreApi.login(userUrl, userId, userPass);

		String objStr = "";
		String status = (String)resultMap.get("status");
			
		if (status.equalsIgnoreCase("OK")) {         		//success
			resultStr = status;
		} else {
			resultStr = (String)resultMap.get("result");  	//fail
		}
	}
	
%><%=resultStr %>

