
<%@ page language="java" contentType="text/xml; charset=UTF-8"%><%
	request.setCharacterEncoding("UTF-8");
%><%@ page import="com.maninsoft.util.CommonUtil" 
%><%@ page import="com.maninsoft.util.XmlUtil" 
%><%@ page import="com.maninsoft.smart.market.manager.ISwmManager" 
%><%@ page import="com.maninsoft.smart.market.model.SwmProduct" 
%><%@page import="com.maninsoft.link.model.LnkObject"
%><%@page import="com.maninsoft.link.model.LnkListCond"
%><%@page import="com.maninsoft.link.model.LnkList"
%><%@page import="com.maninsoft.factory.MisManagerFactory"
%><%@page import="com.maninsoft.smart.appstore.jsp.StoreUtil"
%><%@page import="com.maninsoft.link.manager.ILnkManager"
%><%@page import="com.maninsoft.util.FileUtil"
%><%@page import="com.maninsoft.framework2smart.StoreApi"
%><%@page import="com.maninsoft.smart.market.model.SwmProductProperty"
%><%@page import="com.maninsoft.manager.IManager"
%><%@page import="com.maninsoft.smart.factory.SwManagerFactory"
%><%
	StringBuffer buffer = new StringBuffer("<?xml version=\"1.0\" encoding=\"UTF-8\"?>");
	try {
		String productXml = CommonUtil.toNull(request.getParameter("product"));
		String packageXml = CommonUtil.toNull(request.getParameter("packages"));
		
		if (productXml == null)
			throw new Exception("product is null.");
		
		SwmProduct productObj = (SwmProduct)SwmProduct.toObject(productXml);
		
		productObj.setValue(packageXml);
		
		//이미지 폴더를 아이디로 만들기 위해 저장하기전에 아이디가 필요하다
		if (productObj.getObjId() == null) {
			productObj.setObjId(CommonUtil.newId());
		}	
		//상태값
		productObj.setStatus("uploaded");
		
		String pkgsStr = productObj.getValue();
		if (pkgsStr == null || pkgsStr.length() == 0) 
			throw new Exception("package is null");
		
		//카테고리 조회 후 없으면 추가 
		ILnkManager lnkMgr = MisManagerFactory.getInstance().getLnkManager();
		LnkListCond cond = new LnkListCond();
		cond.setTypeLike("appstore.published.category");
		LnkList[] categoryLists = lnkMgr.getLists("misadmin", cond, IManager.LEVEL_ALL);
		
		for (LnkList list: categoryLists) {
			if (list.getType().equalsIgnoreCase(StoreApi.PUBLISHED_BUSINESSTYPEKEY)) {//업종
				LnkObject[] lnkObjs = list.getItems();
				boolean isExistCtg = false;
				for (LnkObject lnkObj: lnkObjs) {
					if (lnkObj.getType().equalsIgnoreCase(productObj.getBusinessTypeCtgId())) {
						isExistCtg = true;
						break;
					}
				}
				if (!isExistCtg) {
					String label = StoreApi.getCtgNameByCode("misadmin", StoreApi.BUSINESSTYPEKEY, productObj.getBusinessTypeCtgId());
					if (label != null && label.length() != 0) {
						LnkObject item = new LnkObject();
						item.setLabel(label);
						item.setType(productObj.getBusinessTypeCtgId());
						list.addItem(item);
						lnkMgr.setList("misadmin", list, IManager.LEVEL_ALL);
					}
				}
			} else if (list.getType().equalsIgnoreCase(StoreApi.PUBLISHED_BUSINESSKEY)) {
				LnkObject[] lnkObjs = list.getItems();
				boolean isExistCtg = false;
				for (LnkObject lnkObj: lnkObjs) {
					if (lnkObj.getType().equalsIgnoreCase(productObj.getBusinessCtgId())) {
						isExistCtg = true;
						break;
					}
				}
				if (!isExistCtg) {
					String label = StoreApi.getCtgNameByCode("misadmin", StoreApi.BUSINESSKEY, productObj.getBusinessCtgId());
					if (label != null && label.length() != 0) {
						LnkObject item = new LnkObject();
						item.setLabel(label);
						item.setType(productObj.getBusinessCtgId());
						list.addItem(item);
						lnkMgr.setList("misadmin", list, IManager.LEVEL_ALL);
					}
				}
			}
		}
		
		//다운로드시에 아이디변경작업
		//SwpPackages pkgs = (SwpPackages)((SwpPackages)SwpPackages.toObject(pkgsStr)).cloneNew();
		
		SwmProductProperty[] productProperties = productObj.getProductProperties();
		
		//폼정보를 바탕으로 이미지를 생성한다.
		String path = StoreUtil.asHome();
		String imagePath = path + "\\systemImages\\productDef";
		boolean overwrite = true;
		for (SwmProductProperty productProperty: productProperties) {
			String imageId = productProperty.getImageId();
			String base64 = productProperty.getImage();
			if (base64 != null && base64.length() != 0) {
				String tempPath = imagePath + "\\" + productObj.getObjId() + "\\" + imageId + ".png";
				FileUtil.writeByBase64(tempPath, base64, overwrite);
			}
			//thumbnail
			base64 = productProperty.getImageTn();
			if (base64 != null && base64.length() != 0) {
				String tempPath = imagePath + "\\" + productObj.getObjId() + "\\" + imageId + "_tn.png";
				FileUtil.writeByBase64(tempPath, base64, overwrite);
			}	
		}
		
		ISwmManager swmMgr = SwManagerFactory.getInstance().getSwmManager();
		swmMgr.setProduct(productObj.getCreationUser(), productObj, IManager.LEVEL_ALL);
		buffer.append("<result status=\"OK\"/>");
	} catch (Exception e) {
		buffer.append("<result status=\"fail\">");
		buffer.append("<exception>");
		buffer.append(XmlUtil.toCDataString(CommonUtil.toStackTraceString(e)));
		buffer.append("</exception>");
		buffer.append("</result>");
	}
	out.print(buffer);
%>
