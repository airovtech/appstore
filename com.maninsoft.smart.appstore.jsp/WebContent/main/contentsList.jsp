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

	String typeCatId = "a";
	String catId = "a";
	String typeCatName = "전체보기";
	String catName = "전체보기";
	String searchText = "";
	
	int curPage = 1;
	int pageSize = 8;
	String order = "downCount";  //downCount(인기), creationDate(등록순), score(평점), hitCount(조회순), name(가나다순), 
	String asc = "false";
	String status = "published";
	
	if (request.getParameter("searchText") != null) {
		searchText = request.getParameter("searchText");
	}
	if (request.getParameter("typeCatId") != null && !request.getParameter("typeCatId").equals("")) {
		typeCatId = request.getParameter("typeCatId");
	}
	if (request.getParameter("catId") != null && !request.getParameter("catId").equals("")) {
		catId = request.getParameter("catId");
	}
	if (request.getParameter("page") != null) {
		curPage = Integer.parseInt(request.getParameter("page"));
	}
	if (request.getParameter("order") != null) {
		order = request.getParameter("order");
	}
	if (request.getParameter("asc") != null && !request.getParameter("asc").equals("")) {
		asc = request.getParameter("asc");
	}
	if (request.getParameter("status") != null && !request.getParameter("status").equals("")) {
		status = request.getParameter("status");
	}

	SwmProductCond cond = new SwmProductCond();
	cond.setNameLike(searchText);
	cond.setStatus(status);
	
	if (!typeCatId.equals("a")) {
		typeCatName = StoreApi.getCtgNameByCode("", StoreApi.BUSINESSTYPEKEY, typeCatId);
		cond.setBusinessTypeCtgId(typeCatId);
	}
	if (!catId.equals("a")) {
		catName = StoreApi.getCtgNameByCode("", StoreApi.BUSINESSKEY, catId);
		cond.setBusinessCtgId(catId);
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
	
	String tabImgClass01 = "imgTab_out";
	String tabImgClass02 = "imgTab_out";
	String tabImgClass03 = "imgTab_out";
	String tabImgClass04 = "imgTab_out";
	String tabImgClass05 = "imgTab_out";
	
	if (order.equals("downCount")) {
		tabImgClass01 = "imgTab_over";
	} else if (order.equals("creationDate")) {
		tabImgClass02 = "imgTab_over";
	} else if (order.equals("score")) {
		tabImgClass03 = "imgTab_over";
	} else if (order.equals("hitCount")) {
		tabImgClass04 = "imgTab_over";
	} else if (order.equals("name")) {
		tabImgClass05 = "imgTab_over";
	}
	
	//String tabAscButton = "▼";
	//if (asc.equals("false")) {
	//	tabAscButton = "▼";
	//} else {
	//	tabAscButton = "▲";
	//}
%>
<div id="contents_wrap">
	<div id="list_title_area">
		<div id="list_title">
			<a href="<%=ROOT_DIR %>"><strong>HOME</strong></a> &gt;
			<a href="javascript:PageUtil.goLeftMenu('<%=typeCatId %>','')"><span class="txlarge2"><%=typeCatName %></span></a>,
			<a href="javascript:PageUtil.goLeftMenu('','<%=catId %>')"><span class="txlarge2"><%=catName %></span></a> &gt;
			&nbsp;&nbsp;
			<img src="<%=ROOT_DIR%>/images/m_ic_folder.jpg" align="top" alt="">
			<% if (!searchText.equals("")) { %>
				<span class="txred"><%=searchText %></span>
			<% } %>
			검색결과 <span class="txred"><strong><%=totalCount %></strong></span> 건
		</div>
		<div><img src="<%=ROOT_DIR%>/images/m_line_01.jpg" alt=""></div>
	</div>
	<div id="tabs"> <!-- list_tab_menu_area -->
		<ul id="tab_menu">
			<li id="btn_tab01" class="<%=tabImgClass01 %>" onclick="PageUtil.goTab('downCount', 'published');">
				<div id="btn_label01" class="label">인기도 ▼</div>
			</li>
			<li id="btn_tab02" class="<%=tabImgClass02 %>" onclick="PageUtil.goTab('creationDate', 'published');">
				<div id="btn_label02" class="label">등록순 ▼</div>
			</li>
			<li id="btn_tab03" class="<%=tabImgClass03 %>" onclick="PageUtil.goTab('score', 'published');">
				<div id="btn_label03" class="label">평점순 ▼</div>
			</li>
			<li id="btn_tab04" class="<%=tabImgClass04 %>" onclick="PageUtil.goTab('hitCount', 'published');">
				<div id="btn_label04" class="label">조회순 ▼</div>
			</li>
			<li id="btn_tab05" class="<%=tabImgClass05 %>" onclick="PageUtil.goTab('name', 'published');">
				<div id="btn_label05" class="label">가나다순 ▲</div>
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
							String type = obj.getType();								//업무 Type
							
							if (name == null) { name = ""; }
							if (description == null) { description = ""; }
							//if (score == null) { score = "0"; }
							if (creationUser == null) { creationUser = ""; }
							if (company == null) { company = ""; }
							
							name = convertStringText(name);
							//description = convertStringText(description);
							
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
				%>
						<div class="<%=listStyle %> <%=lastStyle %> table_display">
							<div class="list_img_box">
								<div class="list_img">
									<a href="javascript:PageUtil.goDetail('<%=objId %>');">
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
							</div>
							<div class="list_contents">
								<div class="list_item">
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
										<div style="float:left;"><span class="txwname"><a href="javascript:PageUtil.goDetail('<%=objId %>');"><%=name %></a></span></div>
										<% if (intCreationDate >= intOldDate) { %>
											<div style="float:left;padding-top:4px;padding-left:4px;"><img src="<%=ROOT_DIR%>/images/ic_new.gif" alt=""></div>
										<% } %>
									</div>
								</div>
								<div class="list_item" style="clear:both;">
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
						{<span class="txred"><%=searchText %></span>}에 대한 검색결과가 없습니다.
					</div>
				<% } %>
			</div>
			<div id="list_paging">
				<jsp:include page="/main/paging.jsp" flush="true">
					<jsp:param value="<%=totalCount %>" name="pagingTotalCount"/>
					<jsp:param value="<%=pageSize %>" name="pagingPageSize"/>
					<jsp:param value="<%=curPage %>" name="pagingPage"/>
					<jsp:param value="PageUtil.goPage" name="fnc"/>
				</jsp:include>
			</div>
		</div>
	</div>
</div>

