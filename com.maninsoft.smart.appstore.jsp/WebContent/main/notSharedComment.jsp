<%@page language="java" pageEncoding="UTF-8" contentType="text/html;charset=UTF-8"%>
<%@include file="/common/config.jsp"%>
<%
	String objId = "";
	if (request.getParameter("objId") != null) {
		objId = request.getParameter("objId");
	}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<title><%=SITE_TITLE %></title>
		<link rel="stylesheet" type="text/css" href="<%=ROOT_DIR %>/css/common.css" />
	</head>
	<body>
		<div id="infoForm_area" class="darkborder_dropS" >
			<form name="commentForm" method="post" action="" onsubmit="return false;">
				<fieldset>
			  		<legend>Comment</legend>
					<div id="info" class="darkborder">
						<div id="info_move" class="info_title" onmousedown="initializedrag('dialoglayer', event)">
							<img src="<%=ROOT_DIR %>/images/co_not_title.jpg" align="top" alt="공유불가사유">
						</div>
						<div class="info_sub">
							<div style="padding-bottom:10px;">
								<textarea id="comment" name="comment" style="width:99%;height:70px;"></textarea>
							</div>
							<div class="list center tPadding">
								<img src="<%=ROOT_DIR %>/images/btn_confirmation.jpg" alt="확인" align="top" onclick="PageUtil.commentExe('<%=objId %>');" style="cursor:pointer;">
								<img src="<%=ROOT_DIR %>/images/btn_cancle.jpg" alt="취소" align="top" onclick="voPopupCtrl.dialog_close();" style="cursor:pointer;">
							</div>
						</div>
					</div>
				</fieldset>
			</form>
		</div>
	</body>
</html>
