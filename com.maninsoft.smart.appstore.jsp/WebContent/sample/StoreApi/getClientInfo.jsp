
<%@page import="com.maninsoft.link.model.LnkObject"%>
<%@page import="com.maninsoft.link.model.LnkList"%>
<%@page import="com.maninsoft.framework2smart.StoreApi"%><%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%
	LnkList obj = StoreApi.getClientSmartWorksInfo();

	LnkObject[] lnkObjs = obj.getItems();
	
	for (int i = 0; i < lnkObjs.length; i++) {
		LnkObject lnkObj = lnkObjs[i];
		String type = lnkObj.getType(); //Ÿ��
		String ref = lnkObj.getRef(); //����Ʈ���� ȣ�� URL����
		String label = lnkObj.getLabel(); // ȸ�� �̸�
		String desc = lnkObj.getExpression(); //����
		out.print("Ÿ��:" +type+ ", ȣ��URL:" +ref+ ", ȸ���̸�:" +label+ ", ����:" +desc+ "<br>");
	}
%>