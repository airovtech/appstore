<%@page language="java" pageEncoding="UTF-8" contentType="text/html;charset=UTF-8"%>
<%@include file="/common/config.jsp"%>
<%
	int pagingTotalCount = 0;
	int pagingPageSize = 0;
	int pagingPage = 1;
	String fnc = "";
	
	if (request.getParameter("pagingTotalCount") != null) {
		pagingTotalCount = Integer.parseInt(request.getParameter("pagingTotalCount"));
	}
	if (request.getParameter("pagingPageSize") != null) {
		pagingPageSize = Integer.parseInt(request.getParameter("pagingPageSize"));
	}
	if (request.getParameter("pagingPage") != null) {
		pagingPage = Integer.parseInt(request.getParameter("pagingPage"));
	}
	if (request.getParameter("fnc") != null) {
		fnc = request.getParameter("fnc");
	}
	
	int blockCount = 10;                               				//블락의 단위(다음/이전 큰페이지)
	int pageCount = (pagingTotalCount-1)/pagingPageSize + 1;       	//전체 페이지의 수
	int blockPage = ((pagingPage-1)/blockCount)*blockCount + 1;     //전체 블럭의 수

	String strPaging = "";
	//처음
	if(pagingPage == 1) {
		strPaging = "<img src='" + ROOT_DIR + "/images/btn_prev02.gif' align='top' alt='first page'> ";
	} else {
		strPaging = "<a href='javascript:" + fnc + "(1)'><img src='" + ROOT_DIR + "/images/btn_prev02.gif' align='top' alt='first page'></a> ";
	}

	//이전 blockCount 개
	if( pagingPage == 1 || (blockPage - blockCount) < 1) {
		strPaging += "<img src='" + ROOT_DIR + "/images/btn_prev01.gif' align='top' alt='prev page'> ";
	} else {
		int blockLinkPage = blockPage - 1;// - blockCount;
		strPaging += "<a href='javascript:" + fnc + "(" + blockLinkPage + ")'><img src='" + ROOT_DIR + "/images/btn_prev01.gif' align='top' alt='prev page'></a> ";
	}

	strPaging += "&nbsp;";

	//각 PAGE
	int i = 1;
	int forPage = blockPage;
	if (forPage > 0 ) {
		while( !(i > blockCount || forPage > pageCount)) {
			if (forPage == pagingPage) {
				strPaging += " <b>" + forPage + "</b> ";
			} else {
				strPaging += " <a href='javascript:" + fnc + "(" + forPage + ")'>" + forPage + "</a> ";
			}
			forPage++;
			i++;
		}
	}

	strPaging += "&nbsp;";
	
	//다음 blockCount 개
	if( (blockPage + blockCount) > pageCount) {
		strPaging += " <img src='" + ROOT_DIR + "/images/btn_next01.gif' align='top' alt='next page'> ";
	} else {
		int blockLinkPage = blockPage+blockCount;
		strPaging += " <a href='javascript:" + fnc + "(" + blockLinkPage + ")'><img src='" + ROOT_DIR + "/images/btn_next01.gif' align='top' alt='next page'></a> ";
	}

	//마지막
	if(pagingPage == pageCount) {
		strPaging += "<img src='" + ROOT_DIR + "/images/btn_next02.gif' align='top' alt='last page'>";
	} else {
		strPaging += "<a href='javascript:" + fnc + "(" + pageCount + ")'><img src='" + ROOT_DIR + "/images/btn_next02.gif' align='top' alt='last page'></a>";
	}
	
	out.print(strPaging);
	
%>



