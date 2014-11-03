<%@page language="java" pageEncoding="UTF-8" contentType="text/html;charset=UTF-8"%>
<%@include file="/common/config.jsp"%>
<div id="dialogbackgroundlayer" style="display:none;position:absolute;z-index:21;cursor:pointer" onclick="voPopupCtrl.dialog_close();"></div>
<div id="dialoglayer" style="display:none;position:absolute;z-index:22;"></div>
<div id="message" style="display:none;position:absolute;left:0px;top:0px;padding:3px 5px 0px 5px;background:#569fc7;color:#ffffff;font-size:12px;font-weight:bold;z-index:100;"></div>
<form name="refererForm" method="post" action="<%=S_URL %>/login_ok.jsp" target="_blank">
	<input type="hidden" id="userId" name="userId" value="<%=S_ID %>">
	<input type="hidden" id="userPass" name="userPass" value="<%=S_PASS %>">
</form>
<!-- tooltip start -->
<div id="dhtmltooltip"></div>
<script type="text/javascript" src="<%=ROOT_DIR%>/js/tooltip.js"></script>
<!-- tooltip end -->