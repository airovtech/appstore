<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@page import="com.maninsoft.framework2smart.StoreApi"%>
<%@page import="com.maninsoft.smart.market.model.SwmProduct"%>
<%@page import="com.maninsoft.smart.market.model.SwmProductCond"%>
<%@page import="com.maninsoft.model.Order"%><html>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%
	//product 를 조회 하기 위한 CONDITION객체
	SwmProductCond cond = new SwmProductCond();
	cond.setNameLike("제출");
	//cond.setStatus("uploaded"); 공유대기
	//cond.setStatus("published"); 공유됨

	
	long size = StoreApi.getProductsSize("kmyu@maninsoft.co.kr", cond);
	
	//오더링
	String order = "hitCount";//hitCount(조회수)  //downCount(인기) //score(평점) //name (가나다) // creationDate(등록순)
	boolean isAsc = false;
	
	Order orderObj = new Order();
	orderObj.setField(order);
	orderObj.setAsc(isAsc);
	Order[] orders = new Order[] {orderObj};
	
	cond.setOrders(orders);

	
	
	//페이징
	cond.setPageSize(10); //한번 조회할때 10개씩
	cond.setPageNo(0); //1페이지

		
	
	
	
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