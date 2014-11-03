<%@ page language="java" pageEncoding="UTF-8" contentType="text/html;charset=UTF-8"%>
<%@ include file="/common/config.jsp"%>
<%@page import="com.maninsoft.framework2smart.StoreApi"%>
<%@page import="com.maninsoft.smart.market.model.SwmProduct"%>
<%@page import="com.maninsoft.smart.market.model.SwmProductCond"%>
<%@page import="com.maninsoft.link.model.LnkObject"%>
<%@page import="com.maninsoft.link.model.LnkList"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.Set"%>
<%@page import="java.util.Calendar" %>
<%
	List list = StoreApi.getWorkCategoryList();
	Map businessTypeCategory = (Map)list.get(0);	// 업종별
	Map businessCategory = (Map)list.get(1);		//업무(기능)별
	
	Calendar calen = Calendar.getInstance();
	calen.add(Calendar.DATE, -7);
%>   
<div id="left_wrap">
	<div id="left_logo_area">
		<div id="left_logo" style="padding-top:36px;">
			<a href="<%=CON_DIR%>">
				<img src="<%=ROOT_DIR %>/images/left_topad.jpg" align="top" alt="AppStore Logo">
			</a>
		</div>
		<% if (S_ID.equals("")) { %>
		<div id="left_login" class="table_display" style="height:17px;">
			<%-- 
			<div id="id_field" class="table_display">
				<div class="login_ok_field">
					<span class="txblue">방문해주셔서 감사합니다.</span>
				</div>
			</div>
			<div id="pass_field" class="table_display">
				<div class="login_ok_field">
					<span class="txblue"><a href="javascript:PageUtil.goLogin();">로그인을 하세요.</a></span>
				</div>
			</div>
			 --%>
		</div>
		<% } else { %>
		<div id="left_login" class="table_display" style="height:63px;">
			<div id="id_field" class="table_display">
				<div style="text-align:left;margin-left:12px">
					<span class="txblue"><strong><%=S_COMPANYID %></strong>, <br><%=S_NAME %> <%=S_POSITION %>님</span>
				</div>
			</div>
			<div id="pass_field" class="table_display">
				<div style="text-align:left;margin-left:12px">
					<span class="txblue"><a href="javascript:PageUtil.goMyProduct();">내업무공유함</a></span>
					|
					<span class="txblue"><a href="javascript:PageUtil.goLogout();">로그아웃</a></span>
				</div>
			</div>
		</div>
		<% } %>
	</div>
	<div id="left_menu_area">
		<div id="left_menu01">
			<div id="left_menu_title01" class="left_menu_top">
				<img src="images/left_m01.jpg" width="150" height="34" align="top" alt="업종별">
			</div>
			<div id="left_menu_contents01" class="left_menu_contents">
				<div id="left_menu_list01" class="left_menu_list">
					<ul>
						<li id="ct_a" onclick="PageUtil.goLeftMenu('a','');" style="cursor:pointer;">
							<img src="<%=ROOT_DIR%>/images/left_dot.gif" alt="">&nbsp;
							<span class="bold">전체보기</span>
						</li>
						<%
							Set keySet1 = businessTypeCategory.keySet();
							Iterator itr1 = keySet1.iterator();
							while (itr1.hasNext()) {
								String code = (String)itr1.next();
								String name = (String)businessTypeCategory.get(code);
								String lastStyle = "";
								if (!itr1.hasNext()) {
									lastStyle = "last_item";
								}
								
								//new category
								SwmProductCond cond = new SwmProductCond();
								cond.setBusinessTypeCtgId(code);
								cond.setStatus("published");
								long size1 = StoreApi.getProductsSize(S_ID, cond);
								cond.setFromDate(calen.getTime());
								long size2 = StoreApi.getProductsSize(S_ID, cond);
						%> 
						<li id="ct_<%=code %>" class="<%=lastStyle %>" onclick="PageUtil.goLeftMenu('<%=code %>','');" style="cursor:pointer;">
							<img src="<%=ROOT_DIR%>/images/left_dot.gif" alt="">&nbsp;
							<span class="normal"><%=name %>(<%=size1 %>)</span>
							<% if (size2 > 0) { %>
								<img src="<%=ROOT_DIR%>/images/ic_new02.gif" alt="new">
							<% } %>
						</li>
						<% } %>
					</ul>
				</div>
			</div>
			<div class="left_menu_bottom">
				<img src="<%=ROOT_DIR %>/images/left_mbg_b.jpg" width="150" height="12" align="top" alt="box_bottom">
			</div>
		</div>
	
		<div id="left_menu02">
			<div id="left_menu_title02" class="left_menu_top">
				<img src="<%=ROOT_DIR%>/images/left_m02.jpg" width="150" height="34" align="top" alt="기능별">
			</div>
			<div id="left_menu_contents02" class="left_menu_contents">
				<div id="left_menu_list02" class="left_menu_list">
					<ul>
						<li id="c_a" onclick="PageUtil.goLeftMenu('','a');" style="cursor:pointer;">
							<img src="<%=ROOT_DIR%>/images/left_dot.gif" alt="">&nbsp;
							<span class="bold">전체보기</span>
						</li>
						<%
							Set keySet2 = businessCategory.keySet();
							Iterator itr2 = keySet2.iterator();
							while (itr2.hasNext()) {
								String code = (String)itr2.next();
								String name = (String)businessCategory.get(code);
								String lastStyle = "";
								if (!itr2.hasNext()) {
									lastStyle = "last_item";
								}
								
								//new category
								SwmProductCond cond = new SwmProductCond();
								cond.setBusinessCtgId(code);
								cond.setStatus("published");
								long size1 = StoreApi.getProductsSize(S_ID, cond);
								cond.setFromDate(calen.getTime());
								long size2 = StoreApi.getProductsSize(S_ID, cond);
								
								
								
						%>
						<li id="c_<%=code %>" class="<%=lastStyle %>" onclick="PageUtil.goLeftMenu('','<%=code %>');" style="cursor:pointer;">
							<img src="<%=ROOT_DIR%>/images/left_dot.gif" alt="">&nbsp;
							<span class="normal"><%=name %>(<%=size1 %>)</span>
							<% if (size2 > 0) { %>
								<img src="<%=ROOT_DIR%>/images/ic_new02.gif" alt="new">
							<% } %>
						</li>
						<% } %>
					</ul>
				</div>
			</div>
			<div class="left_menu_bottom">
				<img src="<%=ROOT_DIR %>/images/left_mbg_b.jpg" width="150" height="12" align="top" alt="box_bottom">
			</div>
		</div>
	</div>
	<div id="left_banner" style="text-align:center;">
		<img src="<%=ROOT_DIR%>/images/left_banner.jpg" alt="left banner">
	</div>
</div>