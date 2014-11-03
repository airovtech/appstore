<%@ page language="java" pageEncoding="UTF-8" contentType="text/html;charset=UTF-8"%>
<%
String code = CommonUtil.toNull(request.getParameter("code"));
String lang = CommonUtil.toDefault(request.getParameter("lang"), "kor");
String value = null;
if (!CommonUtil.isEmpty(code)) {
	value = StoreUtil.getCodeValue(code, lang);
} else {
	code = "";
	value = "";
}
%>
<%@page import="com.maninsoft.smart.appstore.jsp.StoreUtil"%>
<%@page import="com.maninsoft.util.CommonUtil"%><html>
	<head>
	</head>
	<body>
		<form method="post">
			function getCodeValue(code, lang) <input type="submit" value="call"><br>
			parameters
			<table>
				<tr><td>code:</td><td><input name="code" type="text" value="<%=code%>"></td></tr>
				<tr>
					<td>lang:</td>
					<td>
						<select name="lang">
							<option value=""></option>
							<option value="kor"<%=lang.equalsIgnoreCase("kor")? " selected" : ""%>>kor</option>
							<option value="eng"<%=lang.equalsIgnoreCase("eng")? " selected" : ""%>>eng</option>
						</select>
					</td>
				</tr>
			</table>
			result: <input type="text" value="<%=value%>">
		</form>
	</body>
</html>