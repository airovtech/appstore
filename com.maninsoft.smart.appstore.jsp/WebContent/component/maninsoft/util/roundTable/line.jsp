<%@page import="com.maninsoft.util.CommonUtil"%><%
String padding = CommonUtil.toDefault(request.getParameter("padding"), "20px");
String borderColor = CommonUtil.toDefault(request.getParameter("borderColor"), "gray");
String backgroundColor = CommonUtil.toDefault(request.getParameter("backgroundColor"), "white");
String backgroundColorBottom = CommonUtil.toDefault(request.getParameter("backgroundColorBottom"), backgroundColor);
%>
		</td>
<%
	if (!padding.startsWith("0")) {
%>
		<td style="width: <%=padding%>; background-color: <%=backgroundColor%>;"></td>
<%
	}
%>
		<td style="width: 2px; background-color: <%=backgroundColor%>;"></td>
		<td style="width: 1px; background-color: <%=backgroundColor%>;"></td>
		<td style="width: 1px; background-color: <%=borderColor%>;"></td>
	</tr>
	<tr style="height: 1px; background-color: <%=borderColor%>;"><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td></tr>
	<tr>
		<td style="width: 1px; background-color: <%=borderColor%>;"></td>
		<td style="width: 1px; background-color: <%=backgroundColorBottom%>;"></td>
		<td style="width: 2px; background-color: <%=backgroundColorBottom%>;"></td>
<%
	if (!padding.startsWith("0")) {
%>
		<td style="width: <%=padding%>; background-color: <%=backgroundColorBottom%>;"></td>
<%
	}
%>
		<td style="background-color: <%=backgroundColorBottom%>;">