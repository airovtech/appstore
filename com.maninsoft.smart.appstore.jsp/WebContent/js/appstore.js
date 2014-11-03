String.prototype.trim = function() {
	return this.replace(/(^[ \f\n\r\t]*)|([ \f\n\r\t]*$)/g, "");
};
String.prototype.replaceAll = function(str1, str2) {
	var temp_str = "";
	if (this.trim() != "" && str1 != str2) {
		temp_str = this.trim();
		while (temp_str.indexOf(str1) > -1) {
			temp_str = temp_str.replace(str1, str2);
		}
	}
	return temp_str;
};
function getCookie(name) {
	var arg = name + "=";
	var alen = arg.length;
	var clen = document.cookie.length;
	var i = 0;
	while (i < clen) {
		var j = i + alen;
		if (document.cookie.substring(i, j) == arg)
			return getCookieVal (j);
		i = document.cookie.indexOf(" ", i) + 1;
		if (i == 0) break;
	}
	return null;
}
function getCookieVal(offset) {
	var endstr = document.cookie.indexOf (";", offset);
	if (endstr == -1)
		endstr = document.cookie.length;
	return unescape(document.cookie.substring(offset, endstr));
}
function setCookie(name, value) {
	var argv = setCookie.arguments;
	var argc = setCookie.arguments.length;
	var expires = (argc > 2) ? argv[2] : null;
	var path = (argc > 3) ? argv[3] : null;
	var domain = (argc > 4) ? argv[4] : null;
	var secure = (argc > 5) ? argv[5] : false;
	document.cookie = name + "=" + escape(value) +
	((expires == null) ? "" : ("; expires=" + expires.toGMTString())) +
	((path == null) ? "" : ("; path=" + path)) +
	((domain == null) ? "" : ("; domain=" + domain)) +
	((secure == true) ? "; secure" : "");
}
function deleteCookie(name) {
	var exp = new Date();
	exp.setTime (exp.getTime() - 1);
	var cval = getCookie(name);
	document.cookie = name + "=" + cval + "; expires=" + exp.toGMTString() + "; path=/";
}
function isEMail(obj){
	var str = obj.value ;
	if(str == "") return true;
	emailEx1 = /[A-Za-z0-9_\-]@[A-Za-z0-9_\-]+\.[A-Za-z]+/;
	emailEx2 = /[A-Za-z0-9_\-]@[A-Za-z0-9_\-]+\.[A-Za-z0-9_\-]+\.[A-Za-z]+/;
	emailEx3 = /[A-Za-z0-9_\-]@[A-Za-z0-9_\-]+\.[A-Za-z0-9_\-]+\.[A-Za-z0-9_\-]+\.[A-Za-z]+/;
	if(emailEx1.test(str)){ return true;}
	if(emailEx2.test(str)){ return true;}
	if(emailEx3.test(str)){ return true;}
	alert ("전자우편이 형식에 맞지 않습니다. \n\n 예)smartworks@maninsoft.co.kr");
	obj.focus();
	return false;
}
function setEmbed() {
	var obj;
	var parameter;
	var embed;
	var html;
	var allParameter;
	var clsid;
	var codebase;
	var pluginspace;
	var embedType;
	var src;
	var width;
	var height;

	// Main function
	this.init = function(getType , s ,w , h) {
		switch (getType) {
			case "flash":
				clsid = "D27CDB6E-AE6D-11cf-96B8-444553540000";
				codebase = "http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=6,0,29,0";
				pluginspage = "http://www.macromedia.com/go/getflashplayer";
				embedType = "application/x-shockwave-flash";
				break;
			default:
		}

		parameter = "<param name='movie' value='"+ s + "'>\n";
		parameter += "<param name='quality' value='high'>\n";

		src = s;
		width = w;
		height = h;
	};

	// Get parameters
	this.parameter = function(parm , value) {
		parameter += "<param name='" + parm + "' value='" + value + "'>\n";
		allParameter += " " + parm + "='" + value + "'";
	};

	// Show function
	this.show = function() {
		if (clsid) {
			obj = "<object classid=\"clsid:" + clsid + "\" codebase=\"" + codebase + "\" width='" + width + "' height='" + height + "'>\n";
		}
		embed = "<embed src='" + src + "' pluginspage='" + pluginspage + "' type='" + embedType + "' width='" + width + "' height='" + height + "'" + allParameter + "></embed>\n";
		if (obj) {
			embed += "</object>\n";
		}
		html = obj + parameter + embed;
		document.write(html);
	};
}

var voPopupCtrl;
function startPopup() {
	voPopupCtrl = new PopupUtil();
	voPopupCtrl.init();		
}
function startFloater() {	
	var voFloaterCtrl = new FloaterUtil("quick_menu", 0);
	voFloaterCtrl.init();
}
function esc_close(e){
	var ev = window.event ? window.event : e;
	var nKey = ev.keyCode;
	if(nKey == 27){
		voPopupCtrl.dialog_close();
	}
}

document.onkeydown = esc_close;

//global 변수 설정
var indexObjId = top.indexObjId;
var homepageUrl = top.homepageUrl;
var strSearchText = top.strSearchText;
window.onload = function() {
	$("search").focus();
	startPopup();
	if (document.documentElement.clientWidth >= 1024) {
		$("quick_menu").className = "quick_menu_absolute_right";
	} else {
		$("quick_menu").className = "quick_menu_absolute_left";
	}
	startFloater();
	PageUtil.getCookieProducts();
	if (indexObjId) {
		PageUtil.goDetail(indexObjId);
	}
	if (strSearchText) {
		$("search").value = strSearchText;
		PageUtil.goSearch();
	}
	//PageUtil.setLoginBox();
};

var PageUtil = {
		
	searchText : "",
	typeCatId : "a",
	catId : "a",
	page : "1",
	order : "downCount",
	asc : "false",
	status : "published",
	arrHistory : new Array(10),
	comment : "",
	xmlObjId : "",
	mypage : "1",
	detailObjId : "",
	
	goSearch : function() {
		//if ($("search").value.trim() == "") {
		//	alert("검색값을 입력하세요!");
		//	$("search").value = "";
		//	return false;
		//}
		
		this.page = "1";
		//this.order = "downCount";
		this.asc = "false";
		if (this.order == "name") { this.asc = "true"; } 
		this.status = "published";
		this.searchText = $("search").value.trim();

		var url = Mis.getPath() + "/main/contentsList.jsp";
		var param = {searchText: this.searchText, typeCatId: this.typeCatId, catId: this.catId, order: this.order, asc: this.asc};
		var targetId = "contents_result";
		var options = {progress: "처리중입니다. 잠시만 기다려주십시오."};
		Mis.update(url, param, targetId, options);
		return false;
	},
	goLeftMenu : function(psTypeCatId, psCatId, psPage) {
		if (psTypeCatId)
			this.typeCatId = psTypeCatId;
		if (psCatId)
			this.catId = psCatId;
		if (psPage) {
			this.page = psPage;
		} else {
			this.page = "1";
		}
		//this.order = "downCount";
		this.asc = "false";
		if (this.order == "name") { this.asc = "true"; } 
		this.status = "published";
		
		var url =  Mis.getPath() + "/main/contentsList.jsp";
		var param = {searchText: this.searchText, typeCatId: this.typeCatId, catId: this.catId, page: this.page, order: this.order, asc: this.asc};
		var targetId = "contents_result";
		var options = {progress: "처리중입니다. 잠시만 기다려주십시오."};
		Mis.update(url, param, targetId, options);
		this.changeLeftMenu(this.typeCatId, this.catId);
	},
	changeLeftMenu : function(psTypeCatId, psCatId){
		var typeCategory = $("left_menu_list01").getElementsByTagName("li");
		for (var i = 0; i < typeCategory.length; i++) {
			if (typeCategory[i].id.split("_")[1] == psTypeCatId) {
				if (i == typeCategory.length - 1) {
					typeCategory[i].className = "last_item";
					typeCategory[i].getElementsByTagName("span")[0].className = "bold";
				} else {
					typeCategory[i].className = "";
					typeCategory[i].getElementsByTagName("span")[0].className = "bold";
				}
			} else {
				if (i == typeCategory.length - 1) {
					typeCategory[i].className = "last_item";
					typeCategory[i].getElementsByTagName("span")[0].className = "normal";
				} else {
					typeCategory[i].className = "normal";
					typeCategory[i].getElementsByTagName("span")[0].className = "normal";
				}
			}
		}
		var category = $("left_menu_list02").getElementsByTagName("li");
		for (var i = 0; i < category.length; i++) {
			if (category[i].id.split("_")[1] == psCatId) {
				if (i == category.length - 1) {
					category[i].className = "last_item";
					category[i].getElementsByTagName("span")[0].className = "bold";
				} else {
					category[i].className = "";
					category[i].getElementsByTagName("span")[0].className = "bold";
				}
			} else {
				if (i == category.length - 1) {
					category[i].className = "last_item";
					category[i].getElementsByTagName("span")[0].className = "normal";
				} else {
					category[i].className = "";
					category[i].getElementsByTagName("span")[0].className = "normal";
				}
			}
		}
	},
	goDetail : function(psObjId) {
		//$("search").focus();
		this.addCookieProduct(psObjId);
		
		var url =  Mis.getPath() + "/main/contentsDetail.jsp";
		var param = {searchText: this.searchText, typeCatId: this.typeCatId, catId: this.catId, objId: psObjId, page: this.page};
		var targetId = "contents_result";
		var options = new Object();
		options["progress"] = "처리중입니다. 잠시만 기다려주십시오.";
		options["callback"] = "PageUtil.showRefTree();";
		Mis.update(url, param, targetId, options);
		this.xmlObjId = psObjId;
	},
	showRefTree : function() {
		
		var srcXSL = Mis.getPath() + "/main/refTree.xsl";
		var srcXML = Mis.getPath() + "/main/refTree.jsp?objId=" + this.xmlObjId;//result.responseXML;

		var xml = loadXMLDoc(srcXML);
		var xsl = loadXMLDoc(srcXSL);
		displayResult(xml, xsl, "ref_task");

		closeXMLDoc(srcXML);
		closeXMLDoc(xsl);

	},
	changeTask : function(psImgId) {
		var links = $("ref_task").getElementsByTagName("li");
		for (var i = 0; i < links.length; i++) {
			links[i].className = "normal";
		}
		$("link_"+psImgId).className = "bold";
		//var tasks = $("detail_view_content03").getElementsByTagName("li");
		var tasks = $("detail_view_content03").cleanWhitespace().childNodes;
		for (var i = 0; i < tasks.length; i++) {
			tasks[i].style.display = "none";
		}
		if (psImgId == "main") {
			for (var i = 0; i < tasks.length; i++) {
				if (tasks[i].id.slice(0, 10) == "task_main_") {
					tasks[i].style.display = "inline-block";
				}
			}
		} else {
			$("task_"+psImgId).style.display = "inline-block";
		}
	},
	addCookieProduct : function(psObjId) {
		var todayDate = new Date();
		todayDate.setTime(todayDate.getTime() + (24*60*60*1000));
		for (var i = 0; i < this.arrHistory.length; i++) {
			if (this.arrHistory[i] == psObjId) {
				return;
			}
		}
		this.arrHistory.unshift(psObjId);				
		this.arrHistory.pop();
		for (var i = 0; i < this.arrHistory.length; i++) {
			if (this.arrHistory[i]) {
				setCookie("C_OBJID_"+i, this.arrHistory[i], todayDate, "/");
			}
		}
		this.nextCookieProducts(2);
	},
	getCookieProducts : function() {
		for (var i = 0; i < this.arrHistory.length; i++) {
			if (getCookie("C_OBJID_"+i) != null) {
				this.arrHistory[i] = getCookie("C_OBJID_"+i);
			}
		}
	},
	showQuickMenu : function() {
		if ($("quick_body").style.display == "block") {
			$("quick_body").style.display = "none";
		} else {
			$("quick_body").style.display = "block";
		}
	},
	nextCookieProducts : function(psLastIndex) {
		var url =  Mis.getPath() + "/main/quickMenu.jsp";
		var param = "?lastIndex=" + psLastIndex;
		var targetId = "quick_menu";
		Mis.update(url, param, targetId);
	},
	goTab : function(psOrder, status) {
		if (this.order == psOrder) {	//toggle asc
			if (this.asc == "false") {	
				this.asc = "true";
			} else {
				this.asc = "false";
			}
		} else {
			switch (psOrder) {
				case "downCount" : 
					this.asc = "false";
					break;
				case "creationDate" : 
					this.asc = "false";
					break;
				case "score" : 
					this.asc = "false";
					break;
				case "hitCount" : 
					this.asc = "false";
					break;
				case "name" : 
					this.asc = "true";
					break;
			}
		}
		//this.page = "1";
		this.order = psOrder;
		this.status = status;
		
		var url =  Mis.getPath() + "/main/contentsList_sub.jsp";
		var param = {searchText: this.searchText, typeCatId: this.typeCatId, catId: this.catId, page: this.page, order: this.order, asc: this.asc, status: this.status};
		var targetId = "contents_result_sub";
		var options = new Object();
		options["progress"] = "처리중입니다. 잠시만 기다려주십시오.";
		options["callback"] = "PageUtil.changeTab();";
		Mis.update(url, param, targetId, options);
		//this.changeTab();
	},
	changeTab : function() {
		$('btn_tab01').className = "imgTab_out";
		$('btn_tab02').className = "imgTab_out";
		$('btn_tab03').className = "imgTab_out";
		$('btn_tab04').className = "imgTab_out";
		$('btn_tab05').className = "imgTab_out";
		
		switch (this.order) {
			case "downCount" : 
				$('btn_tab01').className = "imgTab_over";
				if (this.asc == "false") {
					$("btn_label01").innerHTML = "인기도 ▼";
				} else {
					$("btn_label01").innerHTML = "인기도 ▲";
				}			
				break;
			case "creationDate" : 
				$('btn_tab02').className = "imgTab_over";
				if (this.asc == "false") {
					$("btn_label02").innerHTML = "등록순 ▼";
				} else {
					$("btn_label02").innerHTML = "등록순 ▲";
				}
				break;
			case "score" : 
				$('btn_tab03').className = "imgTab_over";
				if (this.asc == "false") {
					$("btn_label03").innerHTML = "평점순 ▼";
				} else {
					$("btn_label03").innerHTML = "평점순 ▲";
				}
				break;
			case "hitCount" : 
				$('btn_tab04').className = "imgTab_over";
				if (this.asc == "false") {
					$("btn_label04").innerHTML = "조회순 ▼";
				} else {
					$("btn_label04").innerHTML = "조회순 ▲";
				}
				break;
			case "name" : 
				$('btn_tab05').className = "imgTab_over";
				if (this.asc == "false") {
					$("btn_label05").innerHTML = "가나다순 ▼";
				} else {
					$("btn_label05").innerHTML = "가나다순 ▲";
				}
				break;
		}
	},
	/*
	changeTab : function() {
		$('btn_tab01').className = "tab_out";
		$('btn_tab02').className = "tab_out";
		$('btn_tab03').className = "tab_out";
		$('btn_tab04').className = "tab_out";
		$('btn_tab05').className = "tab_out";
		$('btn_label01').style.paddingTop = "2px";
		$('btn_label02').style.paddingTop = "2px";
		$('btn_label03').style.paddingTop = "2px";
		$('btn_label04').style.paddingTop = "2px";
		$('btn_label05').style.paddingTop = "2px";
		
		switch (this.order) {
			case "downCount" : 
				$('btn_tab01').className = "tab_over";
				$('btn_label01').style.paddingTop = "7px";
				break;
			case "creationDate" : 
				$('btn_tab02').className = "tab_over";
				$('btn_label02').style.paddingTop = "7px";
				break;
			case "score" : 
				$('btn_tab03').className = "tab_over";
				$('btn_label03').style.paddingTop = "7px";
				break;
			case "hitCount" : 
				$('btn_tab04').className = "tab_over";
				$('btn_label04').style.paddingTop = "7px";
				break;
			case "name" : 
				$('btn_tab05').className = "tab_over";
				$('btn_label05').style.paddingTop = "7px";
				break;
		}
	},
	*/
	goPage : function(psPage) {
		//$("search").focus();
		this.page = psPage;
		var url =  Mis.getPath() + "/main/contentsList_sub.jsp";
		var param = {searchText: this.searchText, typeCatId: this.typeCatId, catId: this.catId, page: this.page, order: this.order, asc: this.asc, status: this.status};
		var targetId = "contents_result_sub";
		var options = {progress: "처리중입니다. 잠시만 기다려주십시오."};
		Mis.update(url, param, targetId, options);
	},
	setProductScore : function(psObjId) {
		var url = Mis.getPath() + "/main/setProductScore.jsp";
		var param = {objId: psObjId, selScore: document.scoreForm.selScore.value};
		var targetId = "score_result";
		var options = {progress: "처리중입니다. 잠시만 기다려주십시오."};
		Mis.update(url, param, targetId, options);
	},
	setPublishProduct : function(psObjId) {
		var url = Mis.getPath() + "/main/setPublishProduct.jsp";
		var param = {objId: psObjId};
		var targetId = "publish_result_" + psObjId;
		var options = new Object();
		options["progress"] = "처리중입니다. 잠시만 기다려주십시오.";
		options["callback"] = "PageUtil.setWaterMark('" + psObjId + "', 'published');";
		Mis.update(url, param, targetId, options);
	},
	setUnPublishProduct : function(psObjId) {
		var url = Mis.getPath() + "/main/setUnPublishProduct.jsp";
		var param = {objId: psObjId};
		var targetId = "publish_result_" + psObjId;
		var options = new Object();
		options["progress"] = "처리중입니다. 잠시만 기다려주십시오.";
		options["callback"] = "PageUtil.setWaterMark('" + psObjId + "', 'uploaded');";
		Mis.update(url, param, targetId, options);
	},
	setWaterMark : function(psObjId, psStatus) {
		if (psStatus == "notShared") {
			$("warter_" + psObjId).innerHTML = "<img src='" + Mis.getPath() + "/images/water_not.gif'>";
			var viewComment = this.comment;
			viewComment = viewComment.replaceAll("<", "&lt;");
			viewComment = viewComment.replaceAll(">", "&gt;");
			$("comment_" + psObjId).innerHTML = viewComment;
			$("comment_area_" + psObjId).style.display = "block";
		} else if (psStatus == "uploaded") {
			$("warter_" + psObjId).innerHTML = "<img src='" + Mis.getPath() + "/images/water_wait.gif'>";
			$("comment_area_" + psObjId).style.display = "none";
		} else if (psStatus == "published") {
			$("warter_" + psObjId).innerHTML = "<img src='" + Mis.getPath() + "/images/water_ing.gif'>";
			$("comment_area_" + psObjId).style.display = "none";
		}
	},
	setRemoveProduct : function(psObjId) {
		if(confirm("정말 삭제하시겠습니까?")) {
			var url = Mis.getPath() + "/main/setRemoveProduct.jsp";
			//return;
			var callback = "PageUtil.goMyProductPage(" + this.mypage + ");";
			var param = {objId: psObjId};
			var options = new Object();
			options["progress"] = "처리중입니다. 잠시만 기다려주십시오.";
			Mis.request(url, param, callback, options);
		}
	},
	openNotSharedComment : function(psObjId) {
		if (voPopupCtrl) {
			var url = Mis.getPath() + "/main/notSharedComment.jsp?objId=" + psObjId;
			voPopupCtrl.dialog_open(url, 404, 214, 10, "$('comment').focus();");
			voPopupCtrl.in_alert("ESC를 누르시면 창이 닫힙니다.");
		}
	},
	commentExe : function(psObjId) {
		if ($("comment").value.trim() == "") {
			alert("공유불가사유를 입력해주세요!");
			$("comment").value = "";
			$("comment").focus();
			return;
		}
		var psComment = $("comment").value;
		voPopupCtrl.dialog_close();
		this.setNotSharedProduct(psObjId, psComment);
	},
	setNotSharedProduct : function(psObjId, psComment) {
		var url = Mis.getPath() + "/main/setNotSharedProduct.jsp";
		var param = {objId: psObjId, comment: psComment};
		var targetId = "publish_result_" + psObjId;
		var options = new Object();
		options["progress"] = "처리중입니다. 잠시만 기다려주십시오.";
		options["callback"] = "PageUtil.setWaterMark('" + psObjId + "', 'notShared');";
		Mis.update(url, param, targetId, options);
		this.comment = psComment;
	},
	goMyProduct : function() {
		var url =  Mis.getPath() + "/main/myProduct.jsp";
		var targetId = "contents_result";
		var options = {progress: "처리중입니다. 잠시만 기다려주십시오."};
		Mis.update(url, null, targetId, options);
	},
	goMyProductPage : function(psPage) {
		//$("search").focus();
		this.mypage = psPage;
		var url =  Mis.getPath() + "/main/myProduct.jsp";
		var param = {page: psPage};
		var targetId = "contents_result";
		var options = {progress: "처리중입니다. 잠시만 기다려주십시오."};
		Mis.update(url, param, targetId, options);
	},
	goMyProductDetail : function(psObjId) {
		//$("search").focus();
		this.addCookieProduct(psObjId);
		
		var url =  Mis.getPath() + "/main/myProductDetail.jsp";
		var param = {searchText: this.searchText, typeCatId: this.typeCatId, catId: this.catId, objId: psObjId, page: this.mypage};
		var targetId = "contents_result";
		var options = new Object();
		options["progress"] = "처리중입니다. 잠시만 기다려주십시오.";
		options["callback"] = "PageUtil.showRefTree();";
		Mis.update(url, param, targetId, options);
		this.xmlObjId = psObjId;
	},
	downloadProduct : function(psObjId){
		var url = Mis.getPath() + "/main/downloadProduct.jsp";
		var param = {objId: psObjId};
		var result = Mis.request(url, param, null, null);
		var resultStr = result.responseText.trim();
		if (resultStr == "OK") {
			alert("내려받기가 정상적으로 완료되었습니다!");
		} else {
			alert("내려받기에 실패하였습니다!");
		}
	},
	alertLogin : function(psObjId) {
		if(confirm("로그인이 필요한 서비스입니다.\n\n로그인하시겠습니까?")) {
			this.detailObjId = psObjId;
			this.goLogin();
		}
	},
	goLogin : function(){
		//if (voPopupCtrl) {
		//	var url = Mis.getPath() + "/main/login.jsp";
		//	voPopupCtrl.dialog_open(url, 355, 320, 10, "PageUtil.setLoginBox();");
		//	voPopupCtrl.in_alert("ESC를 누르시면 창이 닫힙니다.");
		//}
		//$("search").focus();

		var url =  Mis.getPath() + "/main/login.jsp";
		var targetId = "contents_result";
		var options = new Object();
		options["progress"] = "처리중입니다. 잠시만 기다려주십시오.";
		options["callback"] = "PageUtil.setLoginBox();";
		Mis.update(url, null, targetId, options);
	},
	goMySmartWorks : function(){
		document.refererForm.submit();
	},
	loginformBgChange : function(psObj, psAction) {
		if (psAction == "F") {
			psObj.style.backgroundImage = "none";
		} else {
			if (psObj.name == "userId") {
				if (psObj.value == "") {
					psObj.style.backgroundImage = "url(images/login_id.gif)";
				}
			} else {
				if (psObj.value == "") {
					psObj.style.backgroundImage = "url(images/login_pass.gif)";
				}
			}
		}
	},
	loginExe : function() {
		if (document.loginForm.userCode.value.trim() == "") {
			alert("COMPANY ID를 입력해주세요!");
			document.loginForm.userCode.value = "";
			document.loginForm.userCode.focus();
			return false;
		}
		if (document.loginForm.userId.value.trim() == "") {
			alert("아이디를 입력해주세요!");
			document.loginForm.userId.value = "";
			document.loginForm.userId.focus();
			return false;
		}
		if(!isEMail(document.loginForm.userId)) return false;
		if (document.loginForm.userPass.value.trim() == "") {
			alert("패스워드를 입력해주세요!");
			document.loginForm.userPass.value = "";
			document.loginForm.userPass.focus();
			return false;
		}
		
		var url = Mis.getPath() + "/main/login_exe.jsp";
		var param = {userId: document.loginForm.userId.value.trim(), userPass: document.loginForm.userPass.value.trim(), userCode: document.loginForm.userCode.value.trim()};
		var result = Mis.request(url, param, null, null);
		var resultStr = result.responseText.trim();

		if (resultStr == "OK") {
			if (document.loginForm.cookie_check.checked) {
				var todayDate = new Date();
				todayDate.setTime(todayDate.getTime() + (24*60*60*1000));
				
				var arrTmpId = document.loginForm.userId.value.trim().split("@");
				setCookie("C_ID_01", arrTmpId[0], todayDate, "/");
				setCookie("C_ID_02", arrTmpId[1], todayDate, "/");
				setCookie("C_CODE", document.loginForm.userCode.value.trim(), todayDate, "/");
				
			} else {
				deleteCookie("C_ID_01");
				deleteCookie("C_ID_02");
				deleteCookie("C_CODE")
			}
			document.loginForm.action = Mis.getPath() + "/main/login_ok.jsp";
			//document.loginForm.searchText.value = this.searchText;
			//document.loginForm.typeCatId.value = this.typeCatId;
			//document.loginForm.catId.value = this.catId;
			document.loginForm.objId.value = this.detailObjId;
			//document.loginForm.page.value = this.page;
			
			document.loginForm.submit();
		} else if (resultStr == "INVALIDUSERID") {
			alert("존재하지 않는 아이디 입니다.");
			return false;
		} else if (resultStr == "INVALIDPASSWORD") {
			alert("비밀번호가 맞지 않습니다.");
			return false;
		} else {
			alert("잘못된 COMPANY ID 입니다.");
			return false;
		}
	},
	setLoginBox : function() {
		var C_ID = "";
		var C_CODE = "";
		if (document.loginForm.userId && getCookie("C_ID_01") && getCookie("C_ID_02")) {
			C_ID = getCookie("C_ID_01") + "@" + getCookie("C_ID_02");
			C_CODE = getCookie("C_CODE");
			document.loginForm.userId.value = C_ID;
			document.loginForm.userCode.value = C_CODE;
			$("cookie_check").checked = true;
			document.loginForm.userPass.focus();
		} else {
			document.loginForm.userCode.focus();
		}
		//if (document.loginForm.userId && document.loginForm.userId.value.trim() != "" ){
		//	this.loginformBgChange(document.loginForm.userId, "F");
		//	$("cookie_check").checked = true;
		//}
	},
	goLogout : function() {
		top.location.href = Mis.getPath() + "/main/logout_ok.jsp";
	},
	openSearchCustomer : function(ev) {
		if ($("customerForm_area").style.display == "none") {
			var mouseX = ev.clientX + document.documentElement.scrollLeft;
			var mouseY = ev.clientY+ document.documentElement.scrollTop;
			$("customerForm_area").style.left = ev.clientX + document.documentElement.scrollLeft + "px";
			$("customerForm_area").style.top = ev.clientY + document.documentElement.scrollTop + "px";		
			$("customerForm_area").style.display = "block";
			$("customer").focus();
		} else {
			$("customerForm_area").style.display = "none";
		}
	},
	closeSearchCustomer : function() {
		$("customerForm_area").style.display = "none";
	},
	searchCustomer : function() {
		if ($("customer").value.trim() == "") {
			alert("회사이름을 입력해주세요!");
			$("customer").value = "";
			$("customer").focus();
			return false;
		}
		
		var url =  Mis.getPath() + "/main/loginCustomerSearch.jsp";
		var targetId = "customer_result";
		var param = {customer: $("customer").value};
		//var options = {progress: "처리중입니다. 잠시만 기다려주십시오."};
		Mis.update(url, param, targetId, null);
	},
	setCustomer : function(psUserCode) {
		document.loginForm.userCode.value = psUserCode;
		//$("customerForm_area").style.display = "none";
		document.loginForm.userCode.focus();
	},
	go_info : function(psId) {
		var windowBodyTop = window.screen.availHeight/2 - 350;
		var windowBodyLeft = window.screen.availWidth/2 - 490;
		
		var url = homepageUrl + "/info/company.jsp";
		if (psId == "company") {
			url = homepageUrl + "/info/company.jsp";
		} else if (psId == "agreement") {
			url = homepageUrl + "/info/agreement.jsp";
		} else if (psId == "privacy") {
			url = homepageUrl + "/info/privacy.jsp";
		} else if (psId == "contact") {
			url = homepageUrl + "/info/contact.jsp";
		}
		window.open(url, "info", "width=980,height=700,resizable=yes,scrollbars=yes,top=" + windowBodyTop + ", left=" + windowBodyLeft);
	},
	goInfoCompany : function(){
		//$("search").focus();
		var url =  Mis.getPath() + "/main/info_company.jsp";
		var targetId = "contents_result";
		var options = {progress: "처리중입니다. 잠시만 기다려주십시오."};
		Mis.update(url, null, targetId, options);
	},
	goInfoAgreement : function(){
		//$("search").focus();
		var url =  Mis.getPath() + "/main/info_agreement.jsp";
		var targetId = "contents_result";
		var options = {progress: "처리중입니다. 잠시만 기다려주십시오."};
		Mis.update(url, null, targetId, options);
	},
	goInfoPrivacy : function(){
		//$("search").focus();
		var url =  Mis.getPath() + "/main/info_privacy.jsp";
		var targetId = "contents_result";
		var options = {progress: "처리중입니다. 잠시만 기다려주십시오."};
		Mis.update(url, null, targetId, options);
	}
};
