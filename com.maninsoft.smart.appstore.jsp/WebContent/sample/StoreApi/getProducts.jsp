<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@page import="com.maninsoft.framework2smart.StoreApi"%>
<%@page import="com.maninsoft.smart.market.model.SwmProduct"%>
<%@page import="com.maninsoft.smart.market.model.SwmProductCond"%>
<%@page import="com.maninsoft.model.Order"%><html>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%
	//product �� ��ȸ �ϱ� ���� CONDITION��ü
	SwmProductCond cond = new SwmProductCond();
	cond.setNameLike("����");
	//cond.setStatus("uploaded"); �������
	//cond.setStatus("published"); ������

	
	long size = StoreApi.getProductsSize("kmyu@maninsoft.co.kr", cond);
	
	//������
	String order = "hitCount";//hitCount(��ȸ��)  //downCount(�α�) //score(����) //name (������) // creationDate(��ϼ�)
	boolean isAsc = false;
	
	Order orderObj = new Order();
	orderObj.setField(order);
	orderObj.setAsc(isAsc);
	Order[] orders = new Order[] {orderObj};
	
	cond.setOrders(orders);

	
	
	//����¡
	cond.setPageSize(10); //�ѹ� ��ȸ�Ҷ� 10����
	cond.setPageNo(0); //1������

		
	
	
	
	SwmProduct[] objs = StoreApi.getProducts("kmyu@maninsoft.co.kr", cond);
	
	
	
	

%>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
</head>
<body>
<%
	if (objs != null) {
		for (int i = 0; i < objs.length; i++) {
			SwmProduct obj = objs[i];
			String name = obj.getName();
%>
objectName : <%=name %><br>
<%
		}
	}
%>
</body>
</html>