<%@page import="com.maninsoft.util.CommonUtil"%><%
String padding = CommonUtil.toDefault(request.getParameter("padding"), "20px");
String borderColor = CommonUtil.toDefault(request.getParameter("borderColor"), "gray");
String backgroundColor = CommonUtil.toDefault(request.getParameter("backgroundColor"), "white");
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
</table>