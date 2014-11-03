<%@page language="java" pageEncoding="UTF-8" contentType="text/html;charset=UTF-8"%>
<%@page import="com.maninsoft.framework2smart.StoreApi"%>
<%@page import="com.maninsoft.smart.organization.model.SwoUser"%>
<%@page import="com.maninsoft.util.CommonUtil"%>
<%@page import="com.maninsoft.smart.customer.model.SwcCustomer"%>
<%@page import="com.maninsoft.smart.customer.model.SwcCustomerCond"%>
<%@page import="java.util.Map"%>
<%@include file="/common/config.jsp"%>
<%
	String userId = "";
	String userPass = "";
	String userCode = "";
	
	if (request.getParameter("userId") != null) {
		userId = request.getParameter("userId").trim();
	}
	if (request.getParameter("userPass") != null) {
		userPass = request.getParameter("userPass").trim();
	}
	if (request.getParameter("userCode") != null) {
		userCode = request.getParameter("userCode").trim();
	}

	//String strSearchText = "";
	//String strTypeCatId = "";
	//String strCatId = "";
	String strObjId = "";
	//int curPage = 1;
	
	//if (request.getParameter("searchText") != null) {
	//	strSearchText = request.getParameter("searchText");
	//}
	//if (request.getParameter("typeCatId") != null) {
	//	strTypeCatId = request.getParameter("typeCatId");
	//}
	//if (request.getParameter("catId") != null) {
	//	strCatId = request.getParameter("catId");
	//}
	if (request.getParameter("objId") != null) {
		strObjId = request.getParameter("objId");
	}
	//if (request.getParameter("page") != null) {
	//	curPage = Integer.parseInt(request.getParameter("page"));
	//}
	
	if (userCode.equals("maninsoft_super")) {
		session.setAttribute("S_ID", userId);                           //세션을 생성한다.
	    session.setAttribute("S_NAME", "관리자");
		session.setAttribute("S_PASS", userPass);
	    session.setAttribute("S_COMPANYID", "Maninsoft");
	    session.setAttribute("S_POSITION", "Master");
	    session.setAttribute("S_URL", "http://maninsoft.smartworks.net/smartserver");
	    session.setAttribute("S_AUTHID", "ADMINISTRATOR");
	    
	    if (strObjId.equals("")) {
	    	response.sendRedirect(ROOT_DIR);	
	    } else {
	    	response.sendRedirect(ROOT_DIR + "/?objId=" + strObjId);
	    }
	} else {
		String userUrl = "";
		if (userCode.startsWith("http://")) {
			userUrl = userCode;
		} else {
			SwcCustomerCond cond = new SwcCustomerCond();
			cond.setCustomerCode(userCode);

			SwcCustomer[] objs = StoreApi.getCustomers(S_ID, cond);
			userUrl = objs[0].getSmartworksUrl();
		}
		Map resultMap = StoreApi.login(userUrl, userId, userPass);

		String objStr = "";
		String status = (String)resultMap.get("status");

		String resultStr = null;
		if (status.equalsIgnoreCase("ok")) {       //success
			SwoUser obj = (SwoUser)resultMap.get("result");
			
			session.setAttribute("S_ID", obj.getId());                           //세션을 생성한다.
		    session.setAttribute("S_NAME", obj.getName());
			session.setAttribute("S_PASS", obj.getPassword());
		    session.setAttribute("S_COMPANYID", obj.getCompanyId());
		    session.setAttribute("S_POSITION", obj.getPosition());
		    session.setAttribute("S_URL", userUrl);
		    session.setAttribute("S_AUTHID", obj.getAuthId());
		    
		    //session.setMaxInactiveInterval(24*60*60);
			
		    if (strObjId.equals("")) {
		    	response.sendRedirect(ROOT_DIR);	
		    } else {
		    	response.sendRedirect(ROOT_DIR + "/?objId=" + strObjId);
		    }
		    	    
		} else {
			resultStr = (String)resultMap.get("result");  //fail
			if (resultStr.equals("INVALIDUSERID")) {
				out.println("<script type='text/javascript'>");
				out.println("alert('존재하지 않는 아이디 입니다.')");
				out.println("top.location.href='" + ROOT_DIR + "'");
				out.println("</script>");
			} else if (resultStr.equals("INVALIDPASSWORD")) {
				out.println("<script type='text/javascript'>");
				out.println("alert('비밀번호가 맞지 않습니다.')");
				out.println("top.location.href='" + ROOT_DIR + "'");
				out.println("</script>");
			} else {
				out.println("<script type='text/javascript'>");
				out.println("alert('잘못된 COMPANY ID 입니다.')");
				out.println("top.location.href='" + ROOT_DIR + "'");
				out.println("</script>");
			}
		}
	}
	
	
%>

