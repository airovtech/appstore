<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@page import="com.maninsoft.framework2smart.StoreApi"%>
<%@page import="com.maninsoft.smart.market.model.SwmProduct"%>
<%@page import="com.maninsoft.util.CommonUtil"%>
<%@page import="com.maninsoft.smart.market.model.SwmProductNumeral"%>

<html>
<%
	//��ȸ���� ������Ų��
	String productId = "402880842233a20d012233ad1a190004";
	StoreApi.setHitCount("misadmin", productId);
	
	//product�� ���̵�� �����´�
	SwmProduct product = StoreApi.getProduct("kmyu@maninsoft.co.kr", productId);
	
	
	//product�� ���̵� �̿��� ��ȸ���� ������Ʈ �Ѵ�
	//SwmProductNumeral productNumeral = StoreApi.getProductNumeral("kmyu@maninsoft.co.kr", "5e6caf381f26b928011f3f0a31880695");
	//if (productNumeral != null) {
	//	long hitCount = productNumeral.getHitCount();
	//	hitCount += 1;
	//	productNumeral.setHitCount(hitCount);
	//}
	//StoreApi.setProductNumeral("kmyu@maninsoft.co.kr", productNumeral);
%>
<% if (product != null) {
	String xmlStr = product.toString();
%>	
	<body>
		hitCount : <input type="text" value="<%= product.getHitCount() %>"/>
		<textarea name="xmlStr" style="width: 99%; height: 500px;"><%=CommonUtil.toNotNull(xmlStr)%></textarea><br>
	</body>
<%
	}
%>	
	</html>
