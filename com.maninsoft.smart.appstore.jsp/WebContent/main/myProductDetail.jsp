<%@page language="java" pageEncoding="UTF-8" contentType="text/html;charset=UTF-8"%>
<%@include file="/common/config.jsp"%>
<%@page import="com.maninsoft.framework2smart.StoreApi"%>
<%@page import="com.maninsoft.smart.market.model.SwmProduct"%>
<%@page import="com.maninsoft.util.CommonUtil"%>
<%@page import="com.maninsoft.smart.market.model.SwmProductProperty"%>
<%@page import="com.maninsoft.smart.market.model.SwmProductNumeral"%>
<%@page import="com.maninsoft.smart.market.model.SwmProductFile"%>
<%@page import="com.maninsoft.smart.market.model.SwmProductFileCond"%>
<%@page import="com.maninsoft.util.XmlUtil"%>
<%@page import="java.text.SimpleDateFormat" %>
<%@page import="java.io.File" %>
<%@page import="java.util.ArrayList" %>
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
<%
	String typeCatId = "a";
	String catId = "a";
	String typeCatName = "전체보기";
	String catName = "전체보기";
	
	if (request.getParameter("typeCatId") != null && !request.getParameter("typeCatId").equals("")) {
		typeCatId = request.getParameter("typeCatId");
	}
	if (request.getParameter("catId") != null && !request.getParameter("catId").equals("")) {
		catId = request.getParameter("catId");
	}
	
	if (!typeCatId.equals("a")) {
		typeCatName = StoreApi.getCtgNameByCode("", StoreApi.BUSINESSTYPEKEY, typeCatId);
	}
	if (!catId.equals("a")) {
		catName = StoreApi.getCtgNameByCode("", StoreApi.BUSINESSKEY, catId);
	}
	
	String objId = "";
	if (request.getParameter("objId") != null) {
		objId = request.getParameter("objId");
	}
	SimpleDateFormat sdf = new SimpleDateFormat("yy.MM.dd");

	//조회수를 증가시킨다
	StoreApi.setHitCount(S_ID, objId);
	
	//product를 아이디로 가져온다
	SwmProduct product = StoreApi.getProduct(S_ID, objId);
	String name = product.getName();								//업무명
	String image = "systemImages/productDef/" + objId + "/" + product.getMainImg() + "_tn.png";
	File checkFile = new File(getServletContext().getRealPath("/") + image);
	String businessTypeCtgId = product.getBusinessTypeCtgId();		//업종별
	String businessCtgId = product.getBusinessCtgId();				//업무별
	String businessTypeCtgName = StoreApi.getCtgNameByCode("", StoreApi.BUSINESSTYPEKEY, businessTypeCtgId);
	String businessCtgName =  StoreApi.getCtgNameByCode("", StoreApi.BUSINESSKEY, businessCtgId);
	String description = product.getDescription();					//내용
	long hitCount = product.getHitCount();							//조회수
	long downCount = product.getDownCount();						//다운로드수
	double score = product.getScore();								//평점
	String creationUser = product.getCreationUser();				//등록자
	String company = product.getCompany();							//회사명
	String creationDate = sdf.format(product.getCreationDate());	//등록일
	String status = product.getStatus();							//현재상태
	String type = product.getType();								//업무 Type
	//String xml = product.getPackageRels();						//xml
	//System.out.println(xml);
	String code = product.getProductCode();							//업무코드
	
	if (name == null) { name = ""; }
	if (description == null) { description = ""; }
	//if (score == null) { score = "0"; }
	if (creationUser == null) { creationUser = ""; }
	if (company == null) { company = ""; }
	
	name = convertStringText(name);
	//description = convertStringText(description);
	
	String value = product.getValue();
	value = XmlUtil.encode(value);
	
	//파일 정보(manual)
	String manualFileId = "";
	SwmProductFileCond manualCond = new SwmProductFileCond();
	manualCond.setProductId(objId);
	manualCond.setType("manualguide");
	SwmProductFile manualFile = StoreApi.getProductFile(S_ID, manualCond);
	if (manualFile != null) {
		manualFileId = manualFile.getObjId();
	}
	//파일 정보(movie)
	String movieFileId = "";
	SwmProductFileCond movieCond = new SwmProductFileCond();
	movieCond.setProductId(objId);
	movieCond.setType("movieguide");
	SwmProductFile movieFile = StoreApi.getProductFile(S_ID, movieCond);
	if (movieFile != null) {
		movieFileId = movieFile.getObjId();
	}
	
	//Main Process
	ArrayList processList = new ArrayList();
	SwmProductProperty[] processProperties = product.getProductProperties();
	for (int i=0 ; i < processProperties.length; i++) {
		SwmProductProperty processProperty = processProperties[i];
		String processType = processProperty.getType(); 				//PROCESS(프로세스) MAIN_SINGLE (프로세스에 속한 폼이미지), REF_SINGLE (연결,참조업무 이미지)
		if (processType.equals("PROCESS")) {
			String [] processInfo = new String[3];
			processInfo[0] = processProperty.getName();					//이름
			processInfo[1] = processProperty.getDescription();			//설명
			processInfo[2] = processProperty.getImageId(); 				//이미지 아이디
			processList.add(processInfo);
		}
	}
	
	//연관업무
	ArrayList refList = new ArrayList();
	SwmProductProperty[] refProperties = product.getProductProperties();
	for (int i=0 ; i < refProperties.length; i++) {
		SwmProductProperty refProperty = refProperties[i];
		String refType = refProperty.getType(); 				//PROCESS(프로세스) MAIN_SINGLE (프로세스에 속한 폼이미지), REF_SINGLE (연결,참조업무 이미지)
		if (refType.equals("REF_SINGLE")) {
			String [] refInfo = new String[3];
			refInfo[0] = refProperty.getName();					//이름
			refInfo[1] = refProperty.getDescription();			//설명
			refInfo[2] = refProperty.getImageId(); 				//이미지 아이디
			refList.add(refInfo);
		}
	}
	
	int curPage = 1;
	if (request.getParameter("page") != null) {
		curPage = Integer.parseInt(request.getParameter("page"));
	}
%>
<div id="contents_wrap">
	<div id="list_title_area">
		<div id="list_title">
			<a href="<%=ROOT_DIR %>"><strong>HOME</strong></a> &gt;
			<a href="javascript:PageUtil.goMyProductPage('<%=curPage %>');"><span class="txlarge2">내업무공유함</span></a> &gt;
			<%=name %>
		</div>
		<div><img src="<%=ROOT_DIR%>/images/m_line_01.jpg" alt=""></div>
	</div>
	<div id="detail_title_area">
		<div id="title_menu">
			<div class="title_over">
				<div class="left"></div>
				<div class="mid">
					<div class="label">
						<div style="float:left;">
							<% if (type.equals("SINGLE")) { %>
								<img src="<%=ROOT_DIR %>/images/detail_ttype02.jpg" width="25" height="25" align="top" alt="icon information">
							<% } else { %>
								<img src="<%=ROOT_DIR %>/images/detail_ttype01.jpg" width="25" height="25" align="top" alt="icon process">
							<% } %>
						</div>
						<div style="float:left;padding-top:3px;padding-left:4px;">
							<span class="txwhlarge" style="padding-top:3px;"><%=name %></span>
						</div>
					</div>
				</div>
				<div class="right"></div>
			</div>
		</div>
	</div>
	<div class="detail_view_area table_display">
		<div id="detail_view_title01">
			<img src="<%=ROOT_DIR %>/images/sub_detail_title_001.jpg" width="70" height="14" alt="업무설명">
		</div>
		<div id="detail_view_content01" class="table_display">
			<div class="thumbnail_box">
				<div class="thumbnail">
					<% if (checkFile.exists()) { %>
						<img src="<%=ROOT_DIR %>/<%=image %>" width="196" height="119" align="top" alt="">
					<% } else { %>
						<% if (objId.equals("SYSTEMFORM")) { %>
							<img src="<%=ROOT_DIR %>/images/SYSTEMFORM_tn.png" width="196" height="119" align="top" alt="">
						<% } else { %>
							<img src="<%=ROOT_DIR %>/images/no_img.jpg" width="196" height="119" align="top" alt="">
						<% } %>
					<% } %>
				</div>
			</div>
			<div class="description">
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
						&nbsp;&nbsp;&nbsp;
						<img src="<%=ROOT_DIR%>/images/m_content_dot.gif" alt="">
						<span class="txbgray"><strong>업무코드:</strong></span>
						<%=code %>
					</div>
				</div>
				<div class="list_item">
					<div class="cell01" style="height:50px;">
						<img src="<%=ROOT_DIR%>/images/m_content_dot.gif" alt="">
						<span class="txbgray"><strong>내용:</strong></span>
					</div>
					<div class="cell02">
						<%=description %>
					</div>
				</div>
				<div class="list_item">
					<div class="cell02">
						<img src="<%=ROOT_DIR%>/images/m_content_dot.gif" alt="">
						<span class="txbgray"><strong>조회수:</strong></span> <%=hitCount %>&nbsp;&nbsp;&nbsp;&nbsp;
						<img src="<%=ROOT_DIR%>/images/m_content_dot.gif" alt="">
						<span class="txbgray"><strong>다운로드수:</strong></span> <%=downCount %>&nbsp;&nbsp;&nbsp;&nbsp;
						<img src="<%=ROOT_DIR%>/images/m_content_dot.gif" alt="">
						<span class="txbgray"><strong>등록자:</strong></span> <%=company %>&nbsp;&nbsp;&nbsp;&nbsp;
						<img src="<%=ROOT_DIR%>/images/m_content_dot.gif" alt="">
						<span class="txbgray"><strong>등록일:</strong></span> <%=creationDate %>
					</div>
				</div>
				<div class="list_item">
					<div class="cell01" style="padding-top:3px;">
						<img src="<%=ROOT_DIR%>/images/m_content_dot.gif" alt="">
						<span class="txbgray"><strong>평점:</strong></span>
					</div>
					<div id="score_result" class="cell02" style="width:100px;padding-top:3px;">
						<%
							double rScore = 0;
							if (score == 0) {
								rScore = 0;
							} else {
								rScore = score;
							}
							
						    double dStar = rScore / 2;
						    double hStar = rScore % 2;

						    out.println("<span class=\"txred\">");
						    out.println(score+"/10");
						    out.println("</span>");
						    
						    for (int i = 1; i <= dStar; i++) {
						    	out.print("<img src=\"" + ROOT_DIR + "/images/d_star.gif\" alt=\"\">");
						    }
						    if (hStar >= 1) {
						    	out.print("<img src=\"" + ROOT_DIR + "/images/d_starhalf.gif\" alt=\"\">");
						    }
						%>
					</div>
					<%--
					<div class="cell02" style="position:relative;width:400px;">
						<form name="scoreForm" method="post" action="">
							<fieldset>
			  					<legend>Score</legend>
								<select id="selScore" name="selScore">
									<option value="10" selected="selected">★★★★★</option>
									<option value="8">★★★★</option>
									<option value="6">★★★</option>
									<option value="4">★★</option>
									<option value="2">★</option>
								</select>
								<a href="javascript:PageUtil.setProductScore('<%=objId %>')"><img src="<%=ROOT_DIR %>/images/sub_stard.jpg" align="top" alt="Score"></a>
							</fieldset>
						</form>
					</div>
					--%>
				</div>
				<% if (refList.size() > 0) { %>				
				<div class="list_item" style="padding-top:1px;">
					<div class="cell01" style="width:70px;">
						<img src="<%=ROOT_DIR%>/images/m_content_dot.gif" alt="">
						<span class="txbgray"><strong>구성업무:</strong></span>
					</div>
					<div class="cell02">
						<div id="ref_task" style="position:relative;width:500px;height:150px;overflow:auto;z-index:1">
						<%-- 
							<ul>
								<li id="link_main" class="bold" style="height:16px;">
									<img src="<%=ROOT_DIR%>/images/m_content_dot.gif" alt="">
									<a href="javascript:PageUtil.changeTask('main')"><%=name %></a>
								</li>
								<% 
								for (int i = 0; i < refList.size() ; i++) {
									String [] refInfo = new String[3];
									refInfo = (String[]) refList.get(i);
									String refName = refInfo[0];
									String refImgId = refInfo[2];
									if (refName == null) { refName = ""; }
									refName = convertStringText(refName);
								%>
								<li id="link_<%=refImgId %>" class="normal" style="height:16px;">
									<img src="<%=ROOT_DIR%>/images/m_content_dot.gif" alt="">
									<a href="javascript:PageUtil.changeTask('<%=refImgId %>')"><%=refName %></a>
								</li>
								<% } %>
							</ul>
						--%>
						</div>
					</div>
				</div>
				<% } %>
			</div>
		</div>
	</div>
	<div class="detail_view_area" style="margin-top:10px;">
		<div id="detail_view_title03" >
			<div class="img">
				<img src="<%=ROOT_DIR %>/images/sub_detail_title_002.jpg" width="70" height="14" alt="사용 가이드">
			</div>
			<div class="right">
				<%--
				<div class="left">
					<% if (!movieFileId.equals("")) { %>
						<img src="<%=ROOT_DIR %>/images/sub_detail_btn_mov.jpg" align="top" alt="동영상 다운로드" style="cursor:pointer;" onclick="location.href='<%=ROOT_DIR %>/servlet/download?userId=<%=S_ID %>&fileId=<%=movieFileId %>'">
					<% } %>
				</div>
				<div class="left">
					<% if (!manualFileId.equals("")) { %>
						<img src="<%=ROOT_DIR %>/images/sub_detail_btn_manu.jpg" align="top" alt="매뉴얼 다운로드" onclick="location.href='<%=ROOT_DIR %>/servlet/download?userId=<%=S_ID %>&fileId=<%=manualFileId %>'">
					<% } %>
				</div>
				--%>
			</div>
		</div>
		<div id="detail_view_content03" class="table_display">
			<%	
				boolean isFirst = true;
				String lastStyle = "";
				if (processList.size() > 0) { 
			%>
				<% 
					//Main Process
					for(int i = 0; i < processList.size() ; i++) {
						String [] processInfo = new String[3];
						processInfo = (String[]) processList.get(i);
						String processName = processInfo[0];
						String processDescription = processInfo[1];
						String processImgId = processInfo[2];
						String processOrgImage = "systemImages/productDef/" + objId + "/" + processImgId + ".png";
						File processCheckFile = new File(getServletContext().getRealPath("/") + processOrgImage);
						if (processName == null) { processName = ""; }
						if (processDescription == null) { processDescription = ""; }
						processName = convertStringText(processName);
						//processDescription = convertStringText(processDescription);
						
						if (isFirst) {
							lastStyle = "style=\"background-image:none;\"";
						}
						isFirst = false;
				%>
					<div id="task_main_<%=processImgId %>" class="wrap table_display" <%=lastStyle %>>
						<div class="field01">
							<div class="title" style="text-align:center;padding-right:10px;">
								<%-- 
								<div style="float:left;padding:0px 4px 2px 0px;"><img src="<%=ROOT_DIR %>/images/ic_process.gif" align="top" alt="icon process"></div>
								<div style="float:left;margin-top:1px;"><span class="txwhiteb"><%=strSlice(name, 50, "..") %></span></div>
								<span class="txwhiteb"><%=strSlice(name, 50, "..") %></span>
								--%>
								<span class="txwhiteb"><%=name %></span>			
							</div>
							<div class="thumbnail" style="clear:both;">
								<div style="margin:auto;width:394px;">
									<% if (processCheckFile.exists()) { %>
										<img src="<%=ROOT_DIR %>/<%=processOrgImage %>" alt="" width="394" align="top">
									<% } else { %>
										<% if (objId.equals("SYSTEMFORM")) { %>
											<img src="<%=ROOT_DIR %>/images/SYSTEMFORM.png" width="394" align="top" alt="">
										<% } else { %>
											<img src="<%=ROOT_DIR %>/images/no_img.jpg" width="394" align="top" alt="" >
										<% } %>
									<% } %>
								</div>
							</div>
							<div class="bottom"><img src="<%=ROOT_DIR %>/images/detail_tline_03.jpg" width="408" height="12"></div>
						</div>
						<div class="field02 smartOutput">
							<%=processDescription %>
						</div>
					</div>
				<% } %>
			<% } %>
			<%
				//메인업무
				SwmProductProperty[] mainProperties = product.getProductProperties();
				for (int i=0 ; i < mainProperties.length; i++) {
					SwmProductProperty mainProperty = mainProperties[i];
					String mainType = mainProperty.getType();
					
					if (mainType.equals("MAIN_SINGLE")) {							//PROCESS(프로세스) MAIN_SINGLE (프로세스에 속한 폼이미지), REF_SINGLE (연결,참조업무 이미지)
						String mainSImgId = mainProperty.getImageId(); 				//이미지 아이디
						String mainSOrgImage = "systemImages/productDef/" + objId + "/" + mainSImgId + ".png";
						File mainSCheckFile = new File(getServletContext().getRealPath("/") + mainSOrgImage);
						String mainSName = mainProperty.getName();					//이름
						String mainSDescription = mainProperty.getDescription();	//설명
						if (mainSName == null) { mainSName = ""; }
						if (mainSDescription == null) { mainSDescription = ""; }
						mainSName = convertStringText(mainSName);
						//mainSDescription = convertStringText(mainSDescription);
						
						lastStyle = "";
						if (isFirst) {
							lastStyle = "style=\"background-image:none;\"";
						}
						isFirst = false;
					
			%>
					<div id="task_main_<%=mainSImgId %>" class="wrap table_display" <%=lastStyle %>>
						<div class="field01">
							<div class="title" style="text-align:center;padding-right:10px;">
								<%--
								<div style="float:left;padding:4px 4px 2px 0px;"><img src="<%=ROOT_DIR %>/images/bt_wscreen.gif" align="top" alt="icon task"></div>
								<div style="float:left;margin-top:3px;"><span class="txwhiteb"><%=strSlice(mainSName, 50, "..") %></span></div>
								<span class="txwhiteb"><%=strSlice(mainSName, 50, "..") %></span>
								 --%>
								 <span class="txwhiteb"><%=mainSName %></span>
							</div>
							<div class="thumbnail" style="clear:both;">
								<div style="margin:auto;width:394px;">
									<% if (mainSCheckFile.exists()) { %>
										<img src="<%=ROOT_DIR %>/<%=mainSOrgImage %>" alt="" width="394" align="top">
									<% } else { %>
										<% if (objId.equals("SYSTEMFORM")) { %>
											<img src="<%=ROOT_DIR %>/images/SYSTEMFORM.png" width="394" align="top" alt="">
										<% } else { %>
											<img src="<%=ROOT_DIR %>/images/no_img.jpg" width="394" align="top" alt="" >
										<% } %>
									<% } %>
								</div>
							</div>
							<div class="bottom"><img src="<%=ROOT_DIR %>/images/detail_tline_03.jpg" width="408" height="12"></div>
						</div>
						<div class="field02 smartOutput">
							<%=mainSDescription %>
						</div>
					</div>
				<% } //if (mainType.equals("MAIN_SINGLE")) {%>
			<% } //for (int i=0 ; i < mainProperties.length; i++) {%>
			<% if (refList.size() > 0) { %>
				<% 
					//연관업무
					for(int i = 0; i < refList.size() ; i++) {
						String [] refInfo = new String[3];
						refInfo = (String[]) refList.get(i);
						String refName = refInfo[0];
						String refDescription = refInfo[1];
						String refImgId = refInfo[2];
						String refOrgImage = "systemImages/productDef/" + objId + "/" + refImgId + ".png";
						File refCheckFile = new File(getServletContext().getRealPath("/") + refOrgImage);
						if (refName == null) { refName = ""; }
						if (refDescription == null) { refDescription = ""; }
						refName = convertStringText(refName);
						//refDescription = convertStringText(refDescription);
				%>
					<div id="task_<%=refImgId %>" class="wrap" style="background-image:none;display:none;">
						<div class="field01">
							<div class="title" style="text-align:center;padding-right:10px;">
								<%-- 
								<div style="float:left;padding:4px 4px 2px 0px;"><img src="<%=ROOT_DIR %>/images/bt_wscreen.gif" align="top" alt="icon task"></div>
								<div style="float:left;margin-top:3px;"><span class="txwhiteb"><%=strSlice(refName, 50, "..") %></span></div>
								<span class="txwhiteb"><%=strSlice(refName, 50, "..") %></span>
								--%>
								<span class="txwhiteb"><%=refName %></span>
							</div>
							<div class="thumbnail" style="clear:both;">
								<div style="margin:auto;width:394px;">
									<% if (refCheckFile.exists()) { %>
										<img src="<%=ROOT_DIR %>/<%=refOrgImage %>" alt="" width="394" align="top">
									<% } else { %>
										<% if (objId.equals("SYSTEMFORM")) { %>
											<img src="<%=ROOT_DIR %>/images/SYSTEMFORM.png" width="394" align="top" alt="">
										<% } else { %>
											<img src="<%=ROOT_DIR %>/images/no_img.jpg" width="394" align="top" alt="" >
										<% } %>
									<% } %>
								</div>
							</div>
							<div class="bottom"><img src="<%=ROOT_DIR %>/images/detail_tline_03.jpg" width="408" height="12"></div>
						</div>
						<div class="field02 smartOutput">
							<%=refDescription %>
						</div>
					</div>
				<% } //for(int i = 0; i < refList.size() ; i++) {%>
			<% } //if (refList.size() > 0) {%>
		</div>
	</div>
</div>
