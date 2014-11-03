<%@ page pageEncoding="UTF-8" contentType="text/xml; charset=UTF-8"
import="com.maninsoft.framework2smart.StoreApi"
import="com.maninsoft.smart.market.model.SwmProduct"
%><%
	request.setCharacterEncoding("UTF-8");
	String objId = "";
	if (request.getParameter("objId") != null) {
		objId = request.getParameter("objId");
	}
	
	//product를 아이디로 가져온다
	SwmProduct product = StoreApi.getProduct("", objId);
	String xml = product.getPackageRels();							//xml
	out.println(xml);
%>
