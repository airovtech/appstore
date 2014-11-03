<%@page language="java" pageEncoding="UTF-8" contentType="text/html;charset=UTF-8"%>
<%@include file="/common/config.jsp"%>
<%@page import="com.maninsoft.smart.appstore.jsp.StoreUtil"%>
<%@page import="com.maninsoft.util.CommonUtil"%>
<%@page import="com.maninsoft.framework2smart.StoreApi"%>
<%@page import="com.maninsoft.smart.market.model.SwmProduct"%>
<%@page import="com.maninsoft.smart.market.model.SwmProductCond"%>
<%@page import="com.maninsoft.model.Order"%>
<%@page import="java.text.SimpleDateFormat" %>
<%@page import="java.util.Calendar" %>
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
	int curPage = 1;
	int pageSize = 8;
	String order = "creationDate";  //downCount(인기), creationDate(등록순), score(평점), hitCount(조회순), name(가나다순), 
	String asc = "false";
	
	if (request.getParameter("page") != null) {
		curPage = Integer.parseInt(request.getParameter("page"));
	}
		
	SwmProductCond cond = new SwmProductCond();
	if (!S_COMPANYID.equals("Maninsoft") || !S_AUTHID.equals("ADMINISTRATOR")) {
		cond.setCreationUser(S_ID);
	}

	long totalCount = StoreApi.getProductsSize(S_ID, cond);
	
	//오더링
	boolean isAsc = false;		//desc
	if (asc.equals("true")) { isAsc = true;	}
	Order orderObj = new Order();
	orderObj.setField(order);
	orderObj.setAsc(isAsc);
	Order[] orders = new Order[] {orderObj};
	
	cond.setOrders(orders);
	
	//페이징
	cond.setPageSize(pageSize); //한번 조회할때 10개씩
	cond.setPageNo(curPage-1);  //1페이지
	SwmProduct[] objs = StoreApi.getProducts(S_ID, cond);

	Calendar calen = Calendar.getInstance();
	calen.add(Calendar.DATE, -7);
	
	SimpleDateFormat sdf1 = new SimpleDateFormat("yy.MM.dd");
	SimpleDateFormat sdf2 = new SimpleDateFormat("yyyyMMdd");
	int intOldDate = Integer.parseInt(sdf2.format(calen.getTime()));    //일주일전 날짜.
%>
<div id="contents_wrap">
	<div id="list_title_area">
		<div id="list_title">
			<a href="<%=ROOT_DIR %>"><strong>HOME</strong></a> &gt;
			<span class="txlarge2">내업무공유함</span>
			&nbsp;&nbsp;
			<img src="<%=ROOT_DIR%>/images/m_ic_folder.jpg" align="bottom" alt="">
			총 등록업무 : <span class="txred"><strong><%=totalCount %></strong></span> 건
		</div>
		<div><img src="<%=ROOT_DIR%>/images/m_line_01.jpg" alt=""></div>
	</div>
	<div id="tabs"> <!-- list_tab_menu_area -->
		<ul id="tab_menu">
			<li class="tab_over">
				<div class="left"></div>
				<div class="inheritMid">
					<div class="label">내업무공유함</div>
				</div>
				<div class="right"></div>
			</li>
		</ul>
		<div id="contents_result_sub">
			<div id="tab_view">
				<%	
					if (objs != null) {
						for (int i = 0; i < objs.length; i++) {
							SwmProduct obj = objs[i];
							String objId = obj.getObjId();								//product id
							String name = obj.getName();								//업무명
							String image = "systemImages/productDef/" + objId + "/" + obj.getMainImg() + "_tn.png";
							File checkFile = new File(getServletContext().getRealPath("/") + image);
							String businessTypeCtgId = obj.getBusinessTypeCtgId();		//업종별
							String businessCtgId = obj.getBusinessCtgId();				//업무별
							String businessTypeCtgName = StoreApi.getCtgNameByCode("", StoreApi.BUSINESSTYPEKEY, businessTypeCtgId);
							String businessCtgName =  StoreApi.getCtgNameByCode("", StoreApi.BUSINESSKEY, businessCtgId);
							String description = obj.getDescription();					//내용
							long hitCount = obj.getHitCount();							//조회수
							long downCount = obj.getDownCount();						//다운로드수
							double score = obj.getScore();								//평점
							String creationUser = obj.getCreationUser();				//등록자
							String company = obj.getCompany();							//회사명
							String creationDate = sdf1.format(obj.getCreationDate());	//등록일
							int intCreationDate = Integer.parseInt(sdf2.format(obj.getCreationDate()));
							String extValue = obj.getExtValue();						//불가사유
							String type = obj.getType();								//업무 Type
							
							String status = obj.getStatus();
							String strStatus = "";
							if (status.equals("uploaded")) {
								strStatus = "<img src=\"" + ROOT_DIR + "/images/water_wait.gif\"> ";
							} else if (status.equals("published")) {
								strStatus = "<img src=\"" + ROOT_DIR + "/images/water_ing.gif\"> ";
							} else {
								strStatus = "<img src=\"" + ROOT_DIR + "/images/water_not.gif\"> ";
							}
							
							if (name == null) { name = ""; }
							if (description == null) { description = ""; }
							//if (score == null) { score = "0"; }
							if (creationUser == null) { creationUser = ""; }
							if (company == null) { company = ""; }
							if (extValue == null) { extValue = ""; }
							
							name = convertStringText(name);
							//description = convertStringText(description);
							extValue = convertStringText(extValue);
							
							String listStyle = "";
							if (i % 2 == 0) {
								listStyle = "list_view_g";
							} else {
								listStyle = "list_view_w";
							}
							String lastStyle = "";
							if (i == objs.length - 1) { 
								lastStyle = "last_item";
							}
							
							String isPublished = obj.getIsPublished();
				%>
						<div class="<%=listStyle %> <%=lastStyle %> table_display">
							<div class="list_img_box">
								<div class="list_img">
									<div>
										<a href="javascript:PageUtil.goMyProductDetail('<%=objId %>');">
											<% if (checkFile.exists()) { %>
												<img src="<%=ROOT_DIR%>/<%=image %>" width="204" height="122" align="top" alt="">
											<% } else { %>
												<% if (objId.equals("SYSTEMFORM")) { %>
													<img src="<%=ROOT_DIR %>/images/SYSTEMFORM_tn.png" width="204" height="122" align="top" alt="">
												<% } else { %>
													<img src="<%=ROOT_DIR%>/images/no_img.jpg" width="204" height="122" align="top" alt="">
												<% } %>
											<% } %>
										</a>
									</div>
									<div id="warter_<%=objId %>" class="watermark">
										<%=strStatus %>
									</div>
								</div>
							</div>
							<div class="list_contents">
								<div class="list_item">
									<div>
										<%--
										<div class="cell01">
											<img src="<%=ROOT_DIR%>/images/m_content_dot.gif" alt="">
											<span class="txbgray"><strong>업무명:</strong></span>
										</div>
										--%>
										<div class="cell02" style="padding-bottom:4px;">
											<% if (type.equals("SINGLE")) { %>
												<div style="float:left;padding-right:4px;"><img src="<%=ROOT_DIR%>/images/ic_information.gif" width="18" height="16" alt="icon information"></div>
											<% } else { %>
												<div style="float:left;padding-right:4px;"><img src="<%=ROOT_DIR%>/images/ic_process.gif" width="18" height="16" alt="icon process"></div>
											<% } %>
											<div style="float:left;"><span class="txwname"><a href="javascript:PageUtil.goMyProductDetail('<%=objId %>');"><%=name %></a></span></div>
											<% if (intCreationDate >= intOldDate) { %>
												<div style="float:left;padding-top:4px;padding-left:4px;"><img src="<%=ROOT_DIR%>/images/ic_new.gif" alt=""></div>
											<% } %>
										</div>
									</div>
									<div id="publish_result_<%=objId %>" class="publish_result">
										<% if (status.equals("published")) { %>
											<img src="<%=ROOT_DIR %>/images/co_stop.jpg" align="top" alt="공유중지" style="cursor:pointer;" onclick="PageUtil.setUnPublishProduct('<%=objId %>')">
										<% } else { %>
											<% if (S_COMPANYID.equals("Maninsoft") && S_AUTHID.equals("ADMINISTRATOR")) { %>
												<img src="<%=ROOT_DIR %>/images/co_start.jpg" align="top" alt="공유시작" style="cursor:pointer;" onclick="PageUtil.setPublishProduct('<%=objId %>')">
												<img src="<%=ROOT_DIR %>/images/co_not.jpg" align="top" alt="공유불가" style="cursor:pointer;" onclick="PageUtil.openNotSharedComment('<%=objId %>')">
											<% } else { %>
												<% if (isPublished.equals("true")) { %>
											 		<img src="<%=ROOT_DIR %>/images/co_start.jpg" align="top" alt="공유시작" style="cursor:pointer;" onclick="PageUtil.setPublishProduct('<%=objId %>')">
											 	<% } %>
											<% } %>
											<img src="<%=ROOT_DIR %>/images/co_delete.jpg" align="top" alt="삭제" style="cursor:pointer;" onclick="PageUtil.setRemoveProduct('<%=objId %>')">
										<% } %>
									</div>
								</div>
								<div class="list_item">
									<%--
									<div class="cell01">
										<img src="<%=ROOT_DIR%>/images/m_content_dot.gif" alt="">
										<span class="txbgray"><strong>분류:</strong></span>
									</div>
									<div class="cell02">
										업종별-<%=businessTypeCtgName %>, 업무별-<%=businessCtgName %>
									</div>
									--%>
									<div class="cell02">
										<img src="<%=ROOT_DIR%>/images/m_content_dot.gif" alt="">
										<span class="txbgray"><strong>업종별:</strong></span>
										<%=businessTypeCtgName %>
										&nbsp;
										<img src="<%=ROOT_DIR%>/images/m_content_dot.gif" alt="">
										<span class="txbgray"><strong>업무별:</strong></span>
										<%=businessCtgName %>
									</div>
								</div>
								<div id="comment_area_<%=objId %>" class="list_item" <% if (!status.equals("notShared")) { out.println("style=\"display:none;\""); }%>>
									<div class="comment_item01">
										<img src="<%=ROOT_DIR %>/images/m_content_dot.gif" alt="">
										<span class="txred"><strong>불가사유:</strong></span>
									</div>
									<div class="comment_item02">
										<span id="comment_<%=objId %>" class="txred"><%=extValue %></span>
									</div>
								</div>
								<div class="list_item" style="padding-bottom:4px;">
									<div class="cell01" style="height:75px;">
										<img src="<%=ROOT_DIR%>/images/m_content_dot.gif" alt="">
										<span class="txbgray"><strong>내용:</strong></span>
									</div>
									<div class="cell02" style="width:484px;">
										<%=description %>							
									</div>
								</div>
								<div class="list_item">
									<div class="cell02" style="width:530px;">
										<img src="<%=ROOT_DIR %>/images/m_content_dot.gif" alt="">
										<% if (order.equals("hitCount")) { out.println("<span class=\"txgreen\">"); } %>
											<strong>조회수:</strong> <%=hitCount %>
										<% if (order.equals("hitCount")) { out.println("</span>"); } %>
										&nbsp;&nbsp;&nbsp;
										<img src="<%=ROOT_DIR %>/images/m_content_dot.gif" alt="">
										<% if (order.equals("downCount")) { out.println("<span class=\"txgreen\">"); } %>
											<strong>다운로드수:</strong> <%=downCount %>
										<% if (order.equals("downCount")) { out.println("</span>"); } %>
										&nbsp;&nbsp;&nbsp;
										<img src="<%=ROOT_DIR %>/images/m_content_dot.gif" alt="">
										<% if (order.equals("score")) { out.println("<span class=\"txgreen\">"); } %>
											<strong>평점:</strong> <%=score %>
										<% if (order.equals("score")) { out.println("</span>"); } %>
										&nbsp;&nbsp;&nbsp;
										<img src="<%=ROOT_DIR %>/images/m_content_dot.gif" alt="">
											<strong>등록자:</strong> <%=company %>
										&nbsp;&nbsp;&nbsp;
										<img src="<%=ROOT_DIR %>/images/m_content_dot.gif" alt="">
										<% if (order.equals("creationDate")) { out.println("<span class=\"txgreen\">"); } %>
											<strong>등록일:</strong> <%=creationDate %>
										<% if (order.equals("creationDate")) { out.println("</span>"); } %>
									</div>
								</div>
							</div>
						</div>
					<% } //for (int i = 0; i < objs.length; i++) {%>
				<% } else { %>
					<div class="list_view_g last_item default_height">
						등록된 업무가 없습니다.
					</div>
				<% } %>
			</div>
			<div id="list_paging">
				<jsp:include page="/main/paging.jsp" flush="true">
					<jsp:param value="<%=totalCount %>" name="pagingTotalCount"/>
					<jsp:param value="<%=pageSize %>" name="pagingPageSize"/>
					<jsp:param value="<%=curPage %>" name="pagingPage"/>
					<jsp:param value="PageUtil.goMyProductPage" name="fnc"/>
				</jsp:include>
			</div>
		</div>
	</div>
</div>

