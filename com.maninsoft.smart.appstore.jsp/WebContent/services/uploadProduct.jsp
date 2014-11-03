
<%@page import="java.util.Date"%>
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
%><%@page import="org.apache.commons.fileupload.DiskFileUpload"
%><%@page import="org.apache.commons.fileupload.FileUpload"
%><%@page import="java.util.List"
%><%@page import="org.apache.commons.fileupload.FileItem"
%><%@page import="java.io.File"
%><%@page import="java.io.IOException"
%><%@page import="java.util.Calendar"
%><%@page import="com.maninsoft.smart.market.model.SwmProductFile"
%><%!
	/**
	 * 파일 저장 디렉토리 - 기본 파일 저장 디렉토리에 현재 년, 현재 월로 카테고라이즈 하여 저장한다.
	 */
	private File getFileRepository() throws Exception {
		
		// 현재 년, 월 정보를 얻는다.
		Calendar currentDate = Calendar.getInstance();
		int year = currentDate.get(Calendar.YEAR);
		int month = currentDate.get(Calendar.MONTH) + 1;
	
		// 기본 파일 저장 디렉토리와 현재 년 정보로 파일 디렉토리를 설정한다.
		String storageDir = StoreUtil.appFileDirectory() + File.separator + "Y" + year;
		File storage = new File(storageDir);
		
		// 없다면 생성한다.
		if(!storage.exists())
			storage.mkdir();
		
		// 기본 파일 저장 디렉토리와 현재 월 정보로 파일 디렉토리를 설정한다.		
		storageDir = storageDir + File.separator + "M" + month;
		
		// 만일 디렉토리가 없다면 생성한다.
		storage = new File(storageDir);
		
		if(!storage.exists())
			storage.mkdir();
		
		return storage;
	}
%><%
	StringBuffer buffer = new StringBuffer("<?xml version=\"1.0\" encoding=\"UTF-8\"?>");
	String requestUrl = null;
	String result = null;

	try {
		ISwmManager swmMgr = SwManagerFactory.getInstance().getSwmManager();
		ILnkManager lnkMgr = MisManagerFactory.getInstance().getLnkManager();
		
		String packageXml = null;
		String productXml = null;
		String userId = null;
		String newProductObjId = CommonUtil.newId();
		
		if (FileUpload.isMultipartContent(request)){

			String tempFileDir = StoreUtil.asHome() + "/uploadDataTemp/";
			DiskFileUpload fileUpload = new DiskFileUpload();
			
			fileUpload.setRepositoryPath(tempFileDir);
			fileUpload.setSizeMax(1024 * 1024 * 20);
			fileUpload.setSizeThreshold(1024 * 100);
			
			if (request.getContentLength() < fileUpload.getSizeMax()) {
				
				List fileItemList = fileUpload.parseRequest(request);
				
				int size = fileItemList.size();
				
				for (int i = 0; i < size; i++) {
					FileItem fileItem = (FileItem) fileItemList.get(i);
					
					if (fileItem.isFormField()) {
						
						if (fileItem.getFieldName().equalsIgnoreCase("product")) {
							productXml = CommonUtil.toNull(fileItem.getString("UTF-8"));
						} else if (fileItem.getFieldName().equalsIgnoreCase("packages")) {
							packageXml = CommonUtil.toNull(fileItem.getString("UTF-8"));
						} else if (fileItem.getFieldName().equalsIgnoreCase("userId")) {
							userId = CommonUtil.toNull(fileItem.getString("UTF-8"));
						} else if (fileItem.getFieldName().equalsIgnoreCase("requestUrl")) {
							requestUrl = CommonUtil.toNull(fileItem.getString("UTF-8"));
						}
					} else {
						
						if (fileItem.getSize() > 0) {
							int idx = fileItem.getName().lastIndexOf("\\");
							if (idx == -1) {
								idx = fileItem.getName().lastIndexOf("/");
							}
							String fileName = fileItem.getName().substring(idx + 1);
							try {
								String type = null;
								String physicalFileName = null;

								if (fileItem.getFieldName().equalsIgnoreCase("movieguide")) {
									type = "movieguide";
									physicalFileName = "mov_" + newProductObjId;

								} else if (fileItem.getFieldName().equalsIgnoreCase("manualguide")) {
									type = "manualguide";
									physicalFileName = "manul_" + newProductObjId;
									
								}
								
								File tempUploadedFile = getFileRepository();
								String fileDir = tempUploadedFile.getAbsolutePath();
								String filePath = fileDir + File.separator + physicalFileName;
								String fileSize = fileItem.getSize() + CommonUtil.EMPTY;
								String extension = fileName.lastIndexOf(".") > 1 ? fileName.substring(fileName.lastIndexOf(".") + 1) : null;

								SwmProductFile productFile = new SwmProductFile();
								if (extension != null) {
									filePath = filePath + "." + extension;
									physicalFileName = physicalFileName + "." + extension;
									productFile.setFileType(extension);
								}
								productFile.setType(type);
								productFile.setProductId(newProductObjId);
								productFile.setFileName(fileName);
								productFile.setFilePath(filePath);
								productFile.setFileSize(fileSize);
								
								swmMgr.setProductFile(userId, productFile, IManager.LEVEL_ALL);
								
								fileItem.write(new File(fileDir, physicalFileName));
								
							} catch (IOException e) {
								throw e;
							}
						}
					}
				}
			} else {
				int overSize = (request.getContentLength() / 1000);
				throw new Exception("업로드 파일 용량 초과");
			}
		} else {
			throw new Exception("인코딩 타입이 multipart/form-data가 아닙니다.");
		}
		
		if (productXml == null)
			throw new Exception("product is null.");
		if (packageXml == null)
			throw new Exception("package is null.");
		
		SwmProduct productObj = (SwmProduct)SwmProduct.toObject(productXml);
		
		//프로덕트 아이디
		productObj.setObjId(newProductObjId);
		//프로덕트 코드
		long productCode = new Date().getTime();
		productObj.setProductCode(productCode + "");
		//패키지XML
		productObj.setValue(packageXml);
		//상태값
		productObj.setStatus("uploaded");
		
		productObj.setIsPublished("false");
		
		String pkgsStr = productObj.getValue();
		if (pkgsStr == null || pkgsStr.length() == 0) 
			throw new Exception("package is null");
		
		//다운로드시에 아이디변경작업
		//SwpPackages pkgs = (SwpPackages)((SwpPackages)SwpPackages.toObject(pkgsStr)).cloneNew();
		
		SwmProductProperty[] productProperties = productObj.getProductProperties();
		
		//폼정보를 바탕으로 이미지를 생성한다.
		String path = StoreUtil.asHome();
		String imagePath = path + "/systemImages/productDef";
		boolean overwrite = true;
		for (SwmProductProperty productProperty: productProperties) {
			String imageId = productProperty.getImageId();
			String base64 = productProperty.getImage();
			if (base64 != null && base64.length() != 0) {
				String tempPath = imagePath + "/" + productObj.getObjId() + "/" + imageId + ".png";
				FileUtil.writeByBase64(tempPath, base64, overwrite);
			}
			//thumbnail
			base64 = productProperty.getImageTn();
			if (base64 != null && base64.length() != 0) {
				String tempPath = imagePath + "/" + productObj.getObjId() + "/" + imageId + "_tn.png";
				FileUtil.writeByBase64(tempPath, base64, overwrite);
			}	
		}
		
		swmMgr.setProduct(productObj.getCreationUser(), productObj, IManager.LEVEL_ALL);
		
		buffer.append("<result status=\"OK\"/>");
		result= "OK";
	} catch (Exception e) {
		buffer.append("<result status=\"fail\">");
		buffer.append("<exception>");
		buffer.append(XmlUtil.toCDataString(CommonUtil.toStackTraceString(e)));
		buffer.append("</exception>");
		buffer.append("</result>");
		result = "fail";
	}
	response.sendRedirect(requestUrl+"?result="+result);
%>
