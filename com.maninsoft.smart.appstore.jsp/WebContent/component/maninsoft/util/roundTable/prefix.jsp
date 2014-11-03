<%@page import="com.maninsoft.util.CommonUtil"%><%
String width = CommonUtil.toNull(request.getParameter("width"));
String height = CommonUtil.toNull(request.getParameter("height"));
String padding = CommonUtil.toDefault(request.getParameter("padding"), "20px");
String style = CommonUtil.toNotNull(request.getParameter("style"));
String borderColor = CommonUtil.toDefault(request.getParameter("borderColor"), "gray");
String backgroundColor = CommonUtil.toDefault(request.getParameter("backgroundColor"), "white");
StringBuffer styleBuf = new StringBuffer();
if (width != null)
	styleBuf.append("width: ").append(width).append(";");
if (height != null)
	styleBuf.append("height: ").append(height).append(";");
styleBuf.append(style);
%>
<table cellspacing="0" cellpadding="0" style="<%=styleBuf%>;">
	<tr style="height: 1px;">
		<td style="width: 1px;"></td>
		<td style="width: 1px;"></td>
		<td style="width: 2px;"></td>
<%
	if (!padding.startsWith("0")) {
%>
		<td style="width: <%=padding%>; background-color: <%=borderColor%>;"></td>
<%
	}
%>
		<td style="background-color: <%=borderColor%>;"></td>
<%
	if (!padding.startsWith("0")) {
%>
		<td style="width: <%=padding%>; background-color: <%=borderColor%>;"></td>
<%
	}
%>
		<td style="width: 2px;"></td>
		<td style="width: 1px;"></td>
		<td style="width: 1px;"></td>
	</tr>
	<tr style="height: 1px;">
		<td style="width: 1px;"></td>
		<td style="width: 1px;"></td>
		<td style="width: 2px; background-color: <%=borderColor%>;"></td>
<%
	if (!padding.startsWith("0")) {
%>
		<td style="width: <%=padding%>; background-color: <%=backgroundColor%>;"></td>
<%
	}
%>
		<td style="background-color: <%=backgroundColor%>;"></td>
<%
	if (!padding.startsWith("0")) {
%>
		<td style="width: <%=padding%>; background-color: <%=backgroundColor%>;"></td>
<%
	}
%>
		<td style="width: 2px; background-color: <%=borderColor%>;"></td>
		<td style="width: 1px;"></td>
		<td style="width: 1px;"></td>
	</tr>
	<tr style="height: 2px;">
		<td style="width: 1px;"></td>
		<td style="width: 1px; background-color: <%=borderColor%>;"></td>
		<td style="width: 2px; background-color: <%=backgroundColor%>;"></td>
<%
	if (!padding.startsWith("0")) {
%>
		<td style="width: <%=padding%>; background-color: <%=backgroundColor%>;"></td>
<%
	}
%>
		<td style="background-color: <%=backgroundColor%>;"></td>
<%
	if (!padding.startsWith("0")) {
%>
		<td style="width: <%=padding%>; background-color: <%=backgroundColor%>;"></td>
<%
	}
%>
		<td style="width: 2px; background-color: <%=backgroundColor%>;"></td>
		<td style="width: 1px; background-color: <%=borderColor%>;"></td>
		<td style="width: 1px;"></td>
	</tr>
<%
	if (!padding.startsWith("0")) {
%>
	<tr style="height: <%=padding%>;">
		<td style="width: 1px; background-color: <%=borderColor%>;"></td>
		<td style="width: 1px; background-color: <%=backgroundColor%>;"></td>
		<td style="width: 2px; background-color: <%=backgroundColor%>;"></td>
		<td style="width: <%=padding%>; background-color: <%=backgroundColor%>;"></td>
		<td style="background-color: <%=backgroundColor%>;"></td>
		<td style="width: <%=padding%>; background-color: <%=backgroundColor%>;"></td>
		<td style="width: 2px; background-color: <%=backgroundColor%>;"></td>
		<td style="width: 1px; background-color: <%=backgroundColor%>;"></td>
		<td style="width: 1px; background-color: <%=borderColor%>;"></td>
	</tr>
<%
	}
%>
	<tr>
		<td style="width: 1px; background-color: <%=borderColor%>;"></td>
		<td style="width: 1px; background-color: <%=backgroundColor%>;"></td>
		<td style="width: 2px; background-color: <%=backgroundColor%>;"></td>
<%
	if (!padding.startsWith("0")) {
%>
		<td style="width: <%=padding%>; background-color: <%=backgroundColor%>;"></td>
<%
	}
%>
		<td style="background-color: <%=backgroundColor%>;">