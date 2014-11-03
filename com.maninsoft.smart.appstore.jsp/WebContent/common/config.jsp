<%@ page language="java" pageEncoding="UTF-8" contentType="text/html;charset=UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	
	response.setHeader("Pragma","No-cache");
	response.setHeader("Cache-Control","No-cache");
	response.setHeader("Expires","1");
	
	String SITE_TITLE = "업무앱스토어 - 스마트웍스닷넷";

	// ROOT directory
	String ROOT_DIR = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+request.getContextPath();
	String CON_DIR = request.getContextPath();

	// CUR PAGE
	String CUR_PAGE = request.getRequestURI();

	// Admin ID
	//String SUPER_USER = "kmyu@maninsoft.co.kr";
	
	//Session info
	String S_ID = (String)session.getAttribute("S_ID");
	String S_PASS = (String)session.getAttribute("S_PASS");
	String S_NAME = (String)session.getAttribute("S_NAME");
	String S_COMPANYID = (String)session.getAttribute("S_COMPANYID");
	String S_POSITION = (String)session.getAttribute("S_POSITION");
	String S_URL = (String)session.getAttribute("S_URL");
	String S_AUTHID = (String)session.getAttribute("S_AUTHID");
	
	if (S_ID == null) { S_ID = ""; }
	if (S_PASS == null) { S_PASS = ""; }
	if (S_NAME == null) { S_NAME = ""; }
	if (S_COMPANYID == null) { S_COMPANYID = ""; }
	if (S_POSITION == null) { S_POSITION = ""; }
	if (S_URL == null) { S_URL = ""; }
	if (S_AUTHID == null) { S_AUTHID = ""; };
	
	String HOMEPAGE_URL = "http://www.smartworks.net";
%>