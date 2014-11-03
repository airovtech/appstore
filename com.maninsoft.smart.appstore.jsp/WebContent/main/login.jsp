<%@page language="java" pageEncoding="UTF-8" contentType="text/html;charset=UTF-8"%>
<%@include file="/common/config.jsp"%>
<div id="contents_wrap">
	<div id="list_title_area">
		<div id="list_title">
			<a href="<%=ROOT_DIR %>"><strong>HOME</strong></a> &gt;
			<span class="txlarge2">로그인</span>
			<%--<img src="<%=ROOT_DIR %>/images/sub_footer_ti02.gif" align="top" alt="개인정보취급방침"> --%>
		</div>
		<div><img src="<%=ROOT_DIR%>/images/m_line_01.jpg" alt=""></div>
	</div>
	<div id="tabs"> <!-- list_tab_menu_area -->
		<div id="contents_result_sub">
			<div id="info_tab_view">
				<div id="info_contents">
				
					<div style="margin:50px 0px 0px 90px;width:520px;">
						<div style="float:left;padding:46px 20px 0px 0px;">
							<img src="<%=ROOT_DIR %>/images/login_left_img.jpg" alt="login left img">
						</div>
						<div style="float:left;width:407px">
							<div>
								<img src="<%=ROOT_DIR %>/images/login_title.jpg" alt="login title">
							</div>
							<div style="padding:27px 0px 27px 0px;border:2px solid #c0dd9d">
								<div style="text-align:center;">
									<img src="<%=ROOT_DIR %>/images/login_title2.jpg" alt="login title">
								</div>
								<div style="padding-top:20px;margin:auto;width:250px;">
									<form name="loginForm" id="loginForm" method="post" action="" onsubmit="return false;">
										<fieldset>
									  		<legend>Login</legend>
									  		<input type="hidden" id="searchText" name="searchText" value="">
									  		<input type="hidden" id="typeCatId" name="typeCatId" value="">
									  		<input type="hidden" id="catId" name="catId" value="">
									  		<input type="hidden" id="objId" name="objId" value="">
									  		<input type="hidden" id="page" name="page" value="">
											<table width="250" border="0" cellpadding="0" cellspacing="0">
												<tr>
													<td width="80" height="24" align="right" style="padding-right:3px;"><img src="<%=ROOT_DIR %>/images/log_t03.gif"></td>
													<td colspan="2" height="24" align="left">
														<input type="text" class="login_input2" id="userCode" name="userCode" tabindex="1" onkeypress="if (event.keyCode==13) { PageUtil.loginExe(); }">
													</td>
												</tr>
												<tr>
													<td width="80" height="24" align="right" style="padding-right:2px;"><img src="<%=ROOT_DIR %>/images/log_t01.gif"></td>
													<td height="24" align="left">
														<input type="text" class="login_input2" id="userId" name="userId" tabindex="2" onkeypress="if (event.keyCode==13) { PageUtil.loginExe(); }">
													</td>
													<td>
														<div class="login_check01"><input type="checkbox" id="cookie_check" name="cookie_check" tabindex="3" value="Y"></div>
														<div class="login_check02">SAVE</div>
													</td>
												</tr>
												<tr>
													<td width="80" height="24" align="right" style="padding-right:2px;"><img src="<%=ROOT_DIR %>/images/log_t02.gif"></td>
													<td width="108" height="24" align="left">
														<input type="password" class="login_input2" id="userPass" name="userPass" tabindex="4" onkeypress="if (event.keyCode==13) { PageUtil.loginExe(); }">
													</td>
													<td height="24" align="left">
														<img src="<%=ROOT_DIR %>/images/btn_log.gif" width="51" height="25" align="middle" onclick="PageUtil.loginExe();" style="cursor:pointer;">
													</td>
												</tr>
											</table>
										</fieldset>
									</form>
								</div>
							</div>
							<div style="margin-top:3px;padding:4px 0px 20px 0px;border:2px solid #c0dd9d">
								<div style="text-align:center;">
									<img src="<%=ROOT_DIR %>/images/login_title3.jpg" alt="login title">
								</div>
								<div style="padding-top:20px;margin:auto;width:250px;">
									<form name="customerForm" method="post" action="" onsubmit="return false;">
										<fieldset>
									  		<legend>Customer</legend>
											<table width="250" border="0" cellpadding="0" cellspacing="0">
												<tr>
													<td align="left">&nbsp;</td>
													<td align="left">
														<input type="text" class="customer_input" id="customer" name="customer" tabindex="5" onkeypress="if(event.keyCode==13){ PageUtil.searchCustomer(); }">
													</td>
													<td width="52" align="left" style="padding-left:2px;">
														<img src="<%=ROOT_DIR %>/images/btn_search.gif" width="51" height="25" align="middle" onclick="PageUtil.searchCustomer();" style="cursor:pointer;">
													</td>
												</tr>
												<tr>
 													<td align="left">&nbsp;</td>
													<td colspan="2" align="left">
														<p style="padding:2px 0px 6px 0px;">예) 맨인소프트, 맨인</p>
												        <div id="customer_result">
												        	<ul id="customer_list" style="list-style:none;">
													        	<li>
																	회사이름을 입력하세요.
																</li>
															</ul>
												        </div>
													</td>
												</tr>
											</table>
										</fieldset>
									</form>
								</div>
							</div>
						</div>
					</div>
    			</div>
			</div>
		</div>
	</div>
</div>