<%@page language="java" pageEncoding="UTF-8" contentType="text/html;charset=UTF-8"%>
<%@page import="com.maninsoft.util.CommonUtil"%>
<%@include file="/common/config.jsp"%>
<%
String message = CommonUtil.toNotNull(request.getParameter("message"));
%>
<jsp:include page="../roundTable/prefix.jsp" flush="true">
	<jsp:param name="width" value=""/>
	<jsp:param name="height" value=""/>
	<jsp:param name="padding" value=""/>
	<jsp:param name="borderColor" value=""/>
	<jsp:param name="backgroundColor" value=""/>
	<jsp:param name="style" value="text-align: center;"/>
</jsp:include>
<div style="width:34px; height:34px; margin:auto; text-align:center;">
<object classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000" codebase="http://fpdownload.macromedia.com/get/flashplayer/current/swflash.cab" style="width: 34px; height: 34px;">
	<param name="movie" value="<%=ROOT_DIR%>/images/ProgressIcon.swf"/>
	<param name="quality" value="high"/>
	<param name="wmode" value="transparent"/>
	<param name="allowScriptAccess" value="sameDomain"/>
	<param name="flashvars" value="message=<%=message%>"/>
	<embed name="confirmObj" src="<%=ROOT_DIR%>/images/ProgressIcon.swf" width="100%" height="100%"
		quality="high" allowScriptAccess="sameDomain" play="true" loop="false"
		type="application/x-shockwave-flash" pluginspage="http://www.adobe.com/go/getflashplayer">
	</embed>
</object>
</div>
<br>
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<%=message%>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<br>
<jsp:include page="../roundTable/suffix.jsp" flush="true">
	<jsp:param name="padding" value=""/>
	<jsp:param name="borderColor" value=""/>
	<jsp:param name="backgroundColor" value=""/>
</jsp:include>