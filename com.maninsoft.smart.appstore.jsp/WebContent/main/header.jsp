<%@page language="java" pageEncoding="UTF-8" contentType="text/html;charset=UTF-8"%>
<%@include file="/common/config.jsp"%>
<div id="header_wrap">
	<div id="header_menu_area">
		<div id="header_menu">
			<span class="txblue"><a href="<%=HOMEPAGE_URL%>" target="_blank">스마트웍스닷넷<strong>홈</strong></a></span>
			|
			<% if (S_ID.equals("")) { %>
			<span class="txblue"><a href="javascript:PageUtil.goLogin();"><strong>My</strong>스마트웍스닷넷</a></span>
			<% } else { %>
			<span class="txblue"><a href="javascript:PageUtil.goMySmartWorks()"><strong>My</strong>스마트웍스닷넷</a></span>
			<% } %>
			|
			<span class="txblue"><a href="<%=HOMEPAGE_URL%>/bbs/list.jsp?masBbsId=bbs_notice" target="_blank">고객센터</a></span>
			| 
			<% if (S_ID.equals("")) { %>
			<span class="txblue"><a href="javascript:PageUtil.goLogin();">로그인</a></span>
			<% } else { %>
			<span class="txblue"><a href="javascript:PageUtil.goLogout();">로그아웃</a></span>
			<% } %>
		</div>
		<div id="header_search_area">
			<form name="searchForm" method="post" action="" onsubmit="return PageUtil.goSearch();">
				<fieldset>
			  		<legend>Login</legend>
		         	<div id="header_search_field">
						<input type="text" name="search" id="search">
					</div>
					<div id="header_search_button">
						<input type="image" src="<%=ROOT_DIR %>/images/btn_search.jpg" alt="Search button image">
					</div>
				</fieldset>
			</form>
		</div>
	</div>
</div>