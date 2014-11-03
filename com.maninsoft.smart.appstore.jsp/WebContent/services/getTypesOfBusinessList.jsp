<%@ page language="java" contentType="text/xml; charset=UTF-8"%><%
	request.setCharacterEncoding("UTF-8");
%><%@ page import="com.maninsoft.util.CommonUtil"  
%><%@ page import="com.maninsoft.util.XmlUtil"
%><%@ page import="com.maninsoft.smart.market.manager.ISwmManager" 
%><%@ page import="com.maninsoft.smart.market.model.SwmProduct" 
%><%@ page import="com.maninsoft.smart.factory.SwManagerFactory" 
%><%@ page import="com.maninsoft.link.model.LnkListCond" 
%><%@ page import="com.maninsoft.link.model.LnkList" 
%><%@ page import="com.maninsoft.factory.MisManagerFactory" 
%><%@ page import="com.maninsoft.link.manager.ILnkManager" 
%><%
	try {
		ILnkManager lnkMgr = MisManagerFactory.getInstance().getLnkManager();
		LnkListCond cond = new LnkListCond();
		cond.setType("appstore.category.businessTypes");
		LnkList[] lists = lnkMgr.getLists("admin", cond, lnkMgr.LEVEL_ALL);
		LnkList list = null;
		if (lists != null && !CommonUtil.isEmpty(lists)) {
			list = lists[0];
		} else {
			throw new Exception("Product category list is Null!");
		}
		out.print(list.toString());
	} catch (Exception e) {
		StringBuffer buf = new StringBuffer();
		buf.append("<exception>");
		buf.append(XmlUtil.toCDataString(CommonUtil.toStackTraceString(e)));
		buf.append("</exception>");
		out.print(buf);
	}
%>
