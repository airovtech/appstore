<%@page language="java" pageEncoding="UTF-8" contentType="text/html;charset=UTF-8"%>
<%@include file="/common/config.jsp"%>
<%@page import="com.maninsoft.framework2smart.StoreApi"%>
<%@page import="com.maninsoft.smart.customer.model.SwcCustomer"%>
<%@page import="com.maninsoft.smart.customer.model.SwcCustomerCond"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%
	String customer = "";
	if (request.getParameter("customer") != null) {
		customer = request.getParameter("customer");
	}
	SwcCustomerCond cond = new SwcCustomerCond();
	cond.setNameLike(customer);
	SwcCustomer[] objs = StoreApi.getCustomers(S_ID, cond);
%>
				        
	<ul id="customer_list" style="list-style:none;">
		<% if (objs == null) { %>
		<li>
			없는 회사이름 입니다.
		</li>
		<% 
			} else {
				for (int i = 0; i < objs.length; i++) {
					SwcCustomer obj = objs[i];
					String customerName = obj.getName();
					String customerCode = obj.getCustomerCode();
					//String customerUrl = obj.getSmartworksUrl();				
		%>
		<li>
			<a href="javascript:PageUtil.setCustomer('<%=customerCode %>');"><%=customerName %>(<%=customerCode %>)</a>
		</li>
			<% } %>
		<% } %>
	</ul>
						