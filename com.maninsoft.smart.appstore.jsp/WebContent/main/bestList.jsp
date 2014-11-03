<%@ page language="java" pageEncoding="UTF-8" contentType="text/html;charset=UTF-8"%>
<%@ include file="/common/config.jsp" %>
<%@page import="com.maninsoft.framework2smart.StoreApi"%>
<%@page import="com.maninsoft.smart.market.model.SwmProduct"%>
<%@page import="com.maninsoft.smart.market.model.SwmProductCond"%>
<%@page import="com.maninsoft.model.Order"%>
<%@page import="java.text.SimpleDateFormat" %>
<%@page import="java.io.File" %>
<%!
	public String convertStringText(String checkValue) {
		String replaceString = "";
		replaceString = checkValue.replaceAll("&" , "&amp;");
		replaceString = replaceString.replaceAll("<" , "&lt;");
		replaceString = replaceString.replaceAll(">" , "&gt;");
		replaceString = replaceString.replaceAll("\n" , "<br>");
		replaceString = replaceString.replaceAll(" " , "&nbsp;");
		return replaceString;
	}
	
	/**
	 * 문자열을 length 단위로 자르기
	 * @param str
	 * @param len
	 * @param tail
	 * @return
	 */
	public String strLengthSlice(String str, int len, String tail) {
	    if (str == null)
	    	return null;
	
	    if (str.length() < len)
	        return str;
	
	    String tmpTail = tail;
	    if (tail == null)
	        tmpTail = "";
	
	    int tailLen = tmpTail.length();
	    if (tailLen > len)
	        return "";
	
	    return str.substring(0, len) + tmpTail;
	}

	/**
	 * 문자열을 byte 단위로 자르기
	 * @param str String
	 * @param len int
	 * @param tail String
	 * @return String
	 */
	public String strSlice(String str, int len, String tail) {
	    if (str == null)
	    	return null;
	
	    int srcLen = str.getBytes().length;
	    if (srcLen < len)
	        return str;
	
	    String tmpTail = tail;
	    if (tail == null)
	        tmpTail = "";
	
	    int tailLen = tmpTail.getBytes().length;
	    if (tailLen > len)
	        return "";
	
	    char a;
	    int i = 0;
	    int realLen = 0;
	    for (i = 0; i < len - tailLen && realLen < len - tailLen; i++) {
	        a = str.charAt(i);
	        if ((a & 0xFF00) == 0)
	            realLen += 1;
	        else
	            realLen += 2;
	    }
	
	    while (str.substring(0, i).getBytes().length > len - tailLen) {
	        i--;
	    }
	
	    return str.substring(0, i) + tmpTail;
	}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<title><%=SITE_TITLE %></title>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
		<link rel="stylesheet" type="text/css" href="<%=ROOT_DIR %>/css/common.css">
		<link rel="stylesheet" type="text/css" href="<%=ROOT_DIR%>/css/tooltip.css">
		<script type="text/javascript">
		</script>
	</head>
	<body style="overflow:hidden;">
		<!-- tooltip start -->
		<div id="dhtmltooltip"></div>
		<script type="text/javascript" src="<%=ROOT_DIR%>/js/tooltip.js"></script>
		<!-- tooltip end -->
<%
	SimpleDateFormat sdf = new SimpleDateFormat("yy.MM.dd");

	//인기 (다운로드)
	SwmProductCond cond1 = new SwmProductCond();
	cond1.setStatus("published");
	Order orderObj1 = new Order();
	orderObj1.setField("downCount");
	orderObj1.setAsc(false);
	Order[] orders1 = new Order[] { orderObj1 };
	cond1.setOrders(orders1);
	cond1.setPageSize(8); 
	cond1.setPageNo(0);  //1페이지
		
	if (StoreApi.getProducts(S_ID, cond1) == null) {
%>
		<div id="bestList_wrap">
			<div id="bestList_area">
				<div id="bestList_view">
					<div id="btn_appstore">
						<a href="<%=ROOT_DIR %>" target="_blank"><img src="<%=ROOT_DIR %>/images/btn_appstore.jpg"></a>
					</div>
				</div>
			</div>
		</div>
<%		
	} else {
		
		SwmProduct[] objs1 = StoreApi.getProducts(S_ID, cond1);
		SwmProduct obj1 = objs1[0];
		
		String obj1ObjId = obj1.getObjId();
		String obj1Image = "systemImages/productDef/" + obj1ObjId + "/" + obj1.getMainImg() + "_tn.png";
		File obj1CheckFile = new File(getServletContext().getRealPath("/") + obj1Image);
		
		String obj1Name = obj1.getName();
		String obj1SliceName = strLengthSlice(obj1Name, 10, "..");
		long obj1DownCount = obj1.getDownCount();
		if (obj1Name == null) { obj1Name = ""; }
		obj1Name = convertStringText(obj1Name);
		
		//최신 (등록일)
		SwmProductCond cond2 = new SwmProductCond();
		cond2.setStatus("published");
		Order orderObj2 = new Order();
		orderObj2.setField("creationDate");
		orderObj2.setAsc(false);
		Order[] orders2 = new Order[] { orderObj2 };
		cond2.setOrders(orders2);
		cond2.setPageSize(1); 
		cond2.setPageNo(0);  //1페이지
		SwmProduct[] objs2 = StoreApi.getProducts(S_ID, cond2);
		SwmProduct obj2 = objs2[0];
		
		String obj2ObjId = obj2.getObjId();
		String obj2Image = "systemImages/productDef/" + obj2ObjId + "/" + obj2.getMainImg() + "_tn.png";
		File obj2CheckFile = new File(getServletContext().getRealPath("/") + obj2Image);
		String obj2Name = obj2.getName();
		String obj2SliceName = strLengthSlice(obj2Name, 10, "..");
		String obj2CreationDate = sdf.format(obj2.getCreationDate());
		if (obj2Name == null) { obj2Name = ""; }
		obj2Name = convertStringText(obj2Name);
		
		//평점 
		SwmProductCond cond3 = new SwmProductCond();
		cond3.setStatus("published");
		Order orderObj3 = new Order();
		orderObj3.setField("score");
		orderObj3.setAsc(false);
		Order[] orders3 = new Order[] { orderObj3 };
		cond3.setOrders(orders3);
		cond3.setPageSize(1); 
		cond3.setPageNo(0);  //1페이지
		SwmProduct[] objs3 = StoreApi.getProducts(S_ID, cond3);
		SwmProduct obj3 = objs3[0];
		
		String obj3ObjId = obj3.getObjId();
		String obj3Image = "systemImages/productDef/" + obj3ObjId + "/" + obj3.getMainImg() + "_tn.png";
		File obj3CheckFile = new File(getServletContext().getRealPath("/") + obj3Image);
		String obj3Name = obj3.getName();
		String obj3SliceName = strLengthSlice(obj3Name, 10, "..");
		double obj3Score = obj3.getScore();
		if (obj3Name == null) { obj3Name = ""; }
		//if (obj3Score == null) { obj3Score = "0"; }
		obj3Name = convertStringText(obj3Name);
		
		//조회수 
		SwmProductCond cond4 = new SwmProductCond();
		cond4.setStatus("published");
		Order orderObj4 = new Order();
		orderObj4.setField("hitCount");
		orderObj4.setAsc(false);
		Order[] orders4 = new Order[] { orderObj4 };
		cond4.setOrders(orders4);
		cond4.setPageSize(1); 
		cond4.setPageNo(0);  //1페이지
		SwmProduct[] objs4 = StoreApi.getProducts(S_ID, cond4);
		SwmProduct obj4 = objs4[0];
	
		String obj4ObjId = obj4.getObjId();
		String obj4Image = "systemImages/productDef/" + obj4ObjId + "/" + obj4.getMainImg() + "_tn.png";
		File obj4CheckFile = new File(getServletContext().getRealPath("/") + obj4Image);
		String obj4Name = obj4.getName();
		String obj4SliceName = strLengthSlice(obj4Name, 10, "..");
		long obj4HitCount = obj4.getHitCount();
		if (obj4Name == null) { obj4Name = ""; }
		obj4Name = convertStringText(obj4Name);
%>
		<div id="bestList_wrap">
			<div id="bestList_area">
				<div id="bestList_view">
					<div id="btn_appstore">
						<a href="<%=ROOT_DIR %>" target="_blank"><img src="<%=ROOT_DIR %>/images/btn_appstore.jpg"></a>
					</div>
					<div id="bestList_list01">
						<div class="bestList_item01">
							<a href="<%=ROOT_DIR %>/?objId=<%=obj1ObjId %>" target="_blank">
								<% if (obj1CheckFile.exists()) { %>
									<img src="<%=ROOT_DIR %>/<%=obj1Image %>" width="124" height="69" align="top" alt="" style="border:1px solid #A0A0A0">
								<% } else { %>
									<% if (obj1ObjId.equals("SYSTEMFORM")) { %>
										<img src="<%=ROOT_DIR %>/images/SYSTEMFORM_tn.png" width="124" height="69" align="top" alt="" style="border:1px solid #A0A0A0">
									<% } else { %>
										<img src="<%=ROOT_DIR %>/images/no_img.jpg" width="124" height="69" align="top" alt="" style="border:1px solid #A0A0A0">
									<% } %>
								<% } %>
							</a>
						</div>
						<div class="bestList_item02"><img src="<%=ROOT_DIR %>/images/bestbar_popular.gif" alt=""></div>
						<div class="bestList_item03">
							<a href="<%=ROOT_DIR %>/?objId=<%=obj1ObjId %>" target="_blank">
								<%--<span class="txlink"><%=strSlice(obj1Name, 20, "..") %></span> --%>
								<span class="txlink"><%=obj1SliceName %></span>
							</a>
						</div>
						<div class="bestList_item04"><span style="color:#cf0e0d">다운로드수:<%=obj1DownCount %></span></div>
					</div>
					<div id="bestList_list02">
						<div class="bestList_item01">
							<a href="<%=ROOT_DIR %>/?objId=<%=obj2ObjId %>" target="_blank">
								<% if (obj2CheckFile.exists()) { %>
									<img src="<%=ROOT_DIR %>/<%=obj2Image %>" width="124" height="69" align="top" alt="" style="border:1px solid #A0A0A0">
								<% } else { %>
									<% if (obj2ObjId.equals("SYSTEMFORM")) { %>
										<img src="<%=ROOT_DIR %>/images/SYSTEMFORM_tn.png" width="124" height="69" align="top" alt="" style="border:1px solid #A0A0A0">
									<% } else { %>
										<img src="<%=ROOT_DIR %>/images/no_img.jpg" width="124" height="69" align="top" alt="" style="border:1px solid #A0A0A0">
									<% } %>
								<% } %>
							</a>
						</div>
						<div class="bestList_item02"><img src="<%=ROOT_DIR %>/images/bestbar_new.gif" alt=""></div>
						<div class="bestList_item03">
							<a href="<%=ROOT_DIR %>/?objId=<%=obj2ObjId %>" target="_blank">
								<%--<span class="txlink"><%=strSlice(obj2Name, 20, "..") %></span> --%>
								<span class="txlink"><%=obj2SliceName %></span>
							</a>
						</div>
						<div class="bestList_item04"><span style="color:#d95903">등록일:<%=obj2CreationDate %></span></div>
					</div>
					<div id="bestList_list03">
						<div class="bestList_item01">
							<a href="<%=ROOT_DIR %>/?objId=<%=obj3ObjId %>" target="_blank">
								<% if (obj3CheckFile.exists()) { %>
									<img src="<%=ROOT_DIR %>/<%=obj3Image %>" width="124" height="69" align="top" alt="" style="border:1px solid #A0A0A0">
								<% } else { %>
									<% if (obj3ObjId.equals("SYSTEMFORM")) { %>
										<img src="<%=ROOT_DIR %>/images/SYSTEMFORM_tn.png" width="124" height="69" align="top" alt="" style="border:1px solid #A0A0A0">
									<% } else { %>
										<img src="<%=ROOT_DIR %>/images/no_img.jpg" width="124" height="69" align="top" alt="" style="border:1px solid #A0A0A0">
									<% } %>
								<% } %>
							</a>
						</div>
						<div class="bestList_item02"><img src="<%=ROOT_DIR %>/images/bestbar_grade.gif" alt=""></div>
						<div class="bestList_item03">
							<a href="<%=ROOT_DIR %>/?objId=<%=obj3ObjId %>" target="_blank">
								<%-- <span class="txlink"><%=strSlice(obj3Name, 20, "..") %></span>--%>
								<span class="txlink"><%=obj3SliceName %></span>
							</a>
						</div>
						<div class="bestList_item04"><span style="color:#c8156b">평점:<%=obj3Score %></span></div>
					</div>
					<div id="bestList_list04">
						<div class="bestList_item01">
							<a href="<%=ROOT_DIR %>/?objId=<%=obj4ObjId %>" target="_blank">
								<% if (obj4CheckFile.exists()) { %>
									<img src="<%=ROOT_DIR %>/<%=obj4Image %>" width="124" height="69" align="top" alt="" style="border:1px solid #A0A0A0">
								<% } else { %>
									<% if (obj4ObjId.equals("SYSTEMFORM")) { %>
										<img src="<%=ROOT_DIR %>/images/SYSTEMFORM_tn.png" width="124" height="69" align="top" alt="" style="border:1px solid #A0A0A0">
									<% } else { %>
										<img src="<%=ROOT_DIR %>/images/no_img.jpg" width="124" height="69" align="top" alt="" style="border:1px solid #A0A0A0">
									<% } %>
								<% } %>
							</a>
						</div>
						<div class="bestList_item02"><img src="<%=ROOT_DIR %>/images/bestbar_inquiry.gif" alt=""></div>
						<div class="bestList_item03">
							<a href="<%=ROOT_DIR %>/?objId=<%=obj4ObjId %>" target="_blank">
								<%-- <span class="txlink"><%=strSlice(obj4Name, 20, "..") %></span>--%>
								<span class="txlink"><%=obj4SliceName %></span>
							</a>
						</div>
						<div class="bestList_item04"><span style="color:#aa24b9">조회수:<%=obj4HitCount %></span></div>
					</div>
				</div>
			</div>
		</div>
<% } %>
	</body>
</html>