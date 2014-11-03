<%@page language="java" pageEncoding="UTF-8" contentType="text/html;charset=UTF-8"%>
<%@include file="/common/config.jsp"%>
<%
	String indexObjId = "";
	if (request.getParameter("objId") != null && !request.getParameter("objId").equals("")) {
		indexObjId = request.getParameter("objId");
	}
	String strSearchText = "";
	if (request.getParameter("search") != null && !request.getParameter("search").equals("")) {
		strSearchText = request.getParameter("search").replaceAll("\"", "");
	}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<title><%=SITE_TITLE %></title>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
		<meta name="Description" content="UCC기반의 중소기업 업무포털서비스 -스마트웍스 닷넷 업무 앱스토어-">
		<meta name="Keywords" content=" 스마트웍스닷넷, smartworks.net, 업무 앱스토어, appstore, 그룹웨어, group ware, 전자결제, 인트라넷, intra net, 업무처리, 클라우드, cloud, 사스, SaaS, BPM">
		<link rel="stylesheet" type="text/css" href="<%=ROOT_DIR %>/css/common.css">
		<link rel="stylesheet" type="text/css" href="<%=ROOT_DIR%>/css/tooltip.css">
		<link rel="stylesheet" type="text/css" href="<%=ROOT_DIR%>/css/dtree.css">
		<link rel="stylesheet" type="text/css" href="<%=ROOT_DIR%>/smarteditor/css/style.css">
		<script type="text/javascript" src="<%=ROOT_DIR %>/js/other/prototype/prototype-1.6.0.2.js"></script>
		<script type="text/javascript" src="<%=ROOT_DIR %>/js/maninsoft-1.0.0.js"></script>
		<script type="text/javascript" src="<%=ROOT_DIR %>/js/div_popup.js"></script>
		<script type="text/javascript" src="<%=ROOT_DIR %>/js/floater.js"></script>
		<script type="text/javascript" src="<%=ROOT_DIR %>/js/drag.js"></script>
		<script type="text/javascript" src="<%=ROOT_DIR %>/js/loadXML.js"></script>
		<script type="text/javascript" src="<%=ROOT_DIR %>/js/appstore.js"></script>
		<script type="text/javascript">
			var indexObjId = "<%=indexObjId%>";
			var homepageUrl = "<%=HOMEPAGE_URL%>";
			var strSearchText = "<%=strSearchText%>";
		</script>
	</head>
	<body>
		<jsp:include page="/main/hidden.jsp" flush="true"></jsp:include>
		<div id="wrap">
			<div id="left">
				<jsp:include page="/main/left.jsp" flush="true"></jsp:include>
			</div>
			<div id="mainwrap">
				<div id="header">
					<jsp:include page="/main/header.jsp" flush="true"></jsp:include>
				</div>
				<div id="contentswrap">
					<div id="contents_result">
						<div id="best">
							<jsp:include page="/main/best.jsp" flush="true"></jsp:include>
						</div>
						<div id="contents">
							<jsp:include page="/main/contentsList.jsp" flush="true"></jsp:include>
						</div>
					</div>
					<div id="quick_menu" class="quick_menu_default">
						<jsp:include page="/main/quickMenu.jsp" flush="true"></jsp:include>
					</div>
				</div>
			</div>
			<div id="footer">
				<jsp:include page="/main/footer.jsp" flush="true"></jsp:include>
			</div>
		</div>
	</body>
</html>
