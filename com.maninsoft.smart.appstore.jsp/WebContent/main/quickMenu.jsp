<%@page language="java" pageEncoding="UTF-8" contentType="text/html;charset=UTF-8"%>
<%@include file="/common/config.jsp"%>
<%@page import="com.maninsoft.framework2smart.StoreApi"%>
<%@page import="com.maninsoft.smart.market.model.SwmProduct"%>
<%@page import="com.maninsoft.smart.market.model.SwmProductNumeral"%>
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
%>
<%
	
	int lastIndex = 2;
	if (request.getParameter("lastIndex") != null) {
		lastIndex = Integer.parseInt(request.getParameter("lastIndex"));
	}
	
	int cookieSize = 10;
	Cookie[] idCookies = request.getCookies();
	String [] arrC_OBJID = new String[cookieSize];
	
	if (idCookies != null) {
		int idx = 0;
		for(int i = 0; i < idCookies.length; i++) {
			if (idCookies[i].getName().startsWith("C_OBJID_")) {
				if (!idCookies[i].getValue().equals("")) {
					arrC_OBJID[idx] = idCookies[i].getValue();
					idx++;
				}
			}
		}
	}
	
%>

	<div id="quick_today">
		<div id="quick_button" onclick="PageUtil.showQuickMenu();">
			<img src="<%=ROOT_DIR %>/images/today_menu.gif" alt="quick menu button">
		</div>
		<div id="quick_body" style="display:block;">
			<div id="top"><img src="<%=ROOT_DIR %>/images/today_top.gif" alt="today top img"></div>
			<div id="middle">
				<div id="btn_top" class="btn">
					<% if (lastIndex-3 > -1 && arrC_OBJID[lastIndex-3] != null) { %>
					<a href="javascript:PageUtil.nextCookieProducts('<%=lastIndex-1 %>');">
						<img src="<%=ROOT_DIR %>/images/quick_btn_top.gif" align="top" alt="top button">
					</a>
					<% } %>
				</div>
				<div id="body">
					<%
						if (arrC_OBJID[lastIndex-2] != null) {
							for( int i = lastIndex-2; i <= lastIndex; i++ ) {
								if (arrC_OBJID[i] != null) {
									SwmProduct product = StoreApi.getProduct(S_ID, arrC_OBJID[i]);
									
									if (product != null) {
										String objId = product.getObjId();
										String name = product.getName();
										String image = "systemImages/productDef/" + objId + "/" + product.getMainImg() + "_tn.png";
										File checkFile = new File(getServletContext().getRealPath("/") + image);
										if (name == null) { name = ""; }
										name = convertStringText(name);
					%>
										<div class="list">
											<div class="item01">
												<a href="javascript:PageUtil.goDetail('<%=objId %>');">
													<% if (checkFile.exists()) { %>
														<img src="<%=ROOT_DIR %>/<%=image %>" alt="" width="64" height="32" style="border:1px solid #8C9799" align="top">
													<% } else { %>
														<% if (objId.equals("SYSTEMFORM")) { %>
															<img src="<%=ROOT_DIR %>/images/SYSTEMFORM_tn.png" width="64" height="32" align="top" alt="">
														<% } else { %>
															<img src="<%=ROOT_DIR %>/images/no_img.jpg" alt="" width="64" height="32" style="border:1px solid #8C9799" align="top">
														<% } %>
													<% } %>
												</a>
											</div>
											<div class="item02">
												<a href="javascript:PageUtil.goDetail('<%=objId %>');"><span class="txlink"><%=name %></span></a>
											</div>
										</div>
								<% } else { %>
									<div class="list">
										<div class="item01">
											<a href="javascript:alert('삭제된 업무입니다.');">
												<img src="<%=ROOT_DIR %>/images/no_img.jpg" alt="" width="64" height="32" style="border:1px solid #8C9799" align="top">
											</a>
										</div>
										<div class="item02">
											삭제된업무
										</div>
									</div>
								<% } %>
							<% } %>
						<% } %>
					<% } else { %>
						<div class="list">
							오늘 본 업무가 없습니다.
						</div>
					<% } %>
				</div>
				<div id="btn_bottom" class="btn">
					<% if (arrC_OBJID[0] != null && lastIndex+1 < cookieSize &&  arrC_OBJID[lastIndex+1] != null) { %>
						<a href="javascript:PageUtil.nextCookieProducts('<%=lastIndex+1 %>');">
							<img src="<%=ROOT_DIR %>/images/quick_btn_bottom.gif" align="top" alt="bottom button">
						</a>
					<% } %>
				</div>
			</div>
			<div id="bottom"><img src="<%=ROOT_DIR %>/images/today_bottom.gif" alt="today bottom img"></div>
			<div id="quick_guide">
				<a href="http://manual.smartworks.net/category/업무내려받기가이드" target="_blank">		
					<img src="<%=ROOT_DIR %>/images/q_guide.gif" alt="guide image" align="top">
				</a>
			</div>
			<div id="quick_down">
				<a href="<%=HOMEPAGE_URL%>/purchase/purchase02.jsp" target="_blank">
					<img src="<%=ROOT_DIR %>/images/q_s_down.gif" alt="download image" align="top">
				</a>
			</div>
		</div>
	</div>
	
