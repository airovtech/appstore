<%@ page language="java" pageEncoding="UTF-8" contentType="text/html;charset=UTF-8"%>
<%@page import="com.maninsoft.framework2smart.StoreApi"%>
<%@page import="com.maninsoft.smart.organization.model.SwoUser"%>
<%@page import="com.maninsoft.util.CommonUtil"%>
<%
	request.setCharacterEncoding("UTF-8");
	//Map resultMap = StoreApi.login("http://localhost:8081/smartserver", "kmyu@mdaninsoft.co.kr", "1");
	Map resultMap = StoreApi.login("http://localhost:8081/smartserver", "kmyu@maninsoft.co.kr", "1");
	String objStr = "";
	String status = (String)resultMap.get("status");
	String resultStr = null;
	if (status.equalsIgnoreCase("ok")) {
		SwoUser obj = (SwoUser)resultMap.get("result");
		
		System.out.println("getCompanyId : " + obj.getCompanyId());
		System.out.println("getId : " + obj.getId());	
		System.out.println("getPosition : " + obj.getPosition());
		
		String strName = "";
		strName = obj.getName();
		System.out.println("strName1 : " + strName);
		
		String strName2 = new String(strName.getBytes("Cp1252"), "UTF-8");
		System.out.println("strName2 : " + strName2);

		
		String strName3 = new String(strName.getBytes("iso-8859-1"), "UTF-8");
		System.out.println("strName3 : " + strName3);
		
		String strName4 = new String(strName.getBytes("euc-kr"), "UTF-8");
		System.out.println("strName4 : " + strName4);
		
		String strName5 = new String(strName.getBytes("8859_1"), "UTF-8");
		System.out.println("strName5 : " + strName5);
		
		resultStr = obj.toString();
		
		
		
	} else {
		resultStr = (String)resultMap.get("result");
	}
%>    

<%@page import="java.util.Map"%><body>
	<textarea name="xmlStr" style="width: 99%; height: 500px;"><%=CommonUtil.toNotNull(resultStr)%></textarea>
</body>
