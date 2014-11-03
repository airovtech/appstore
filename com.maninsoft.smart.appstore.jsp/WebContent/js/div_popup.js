var PopupUtil = function() {

	var popup_req = null;
	var popup_script = null;
	var in_alertcount = 0;
	var dlg_bg = null;
	var dlg = null;
	var msg = null;

	/**
     * dialog init
     */
	this.init = function() {
		dlg_bg = $("dialogbackgroundlayer");
		dlg = $("dialoglayer");
		msg = $("message");
		dlg_bg.style.left = "0px";
		dlg_bg.style.top = "0px";
		dlg_bg.style.width = "100%";
		dlg_bg.style.background = "#bbbbbb";
		dlg_bg.style.opacity = "0.3";
		dlg_bg.style.MozOpacity = "0.3";
		dlg_bg.style.KhtmlOpacity = "0.3";
		dlg_bg.style.filter = "alpha(opacity=30)";
	};

	/**
     * dialog open
     */
    this.dialog_open = function(url, w_width, w_height, w_margin, run_script) {
		var objSelect = document.getElementsByTagName("select");
		for (var i=0; i < objSelect.length; i++) {
			objSelect[i].style.display = "none";
		}
		var bgHeight;
		if (document.documentElement.clientHeight > document.documentElement.scrollHeight) {
			bgHeight = document.documentElement.clientHeight;
		} else {
			bgHeight = document.documentElement.scrollHeight;
		}
		var width = document.documentElement.scrollWidth;
		var height = bgHeight;
        dlg_bg.style.width = width + "px";
        dlg_bg.style.height = height + "px";
        dlg_bg.style.display = "block";
		var cwidth = document.documentElement.clientWidth - w_margin;
		var cheight = document.documentElement.clientHeight - w_margin;
		var digWidth, digHeight;
		if (w_width > cwidth) {
			digWidth = cwidth;
			dlg.style.overflowX = "auto";
		} else {
			digWidth = w_width;
			dlg.style.overflowX = "hidden";
		}
		if (w_height > cheight) {
			digHeight = cheight;
			dlg.style.overflowY = "auto";
		} else {
			digHeight = w_height;
			dlg.style.overflowY = "hidden";
		}
		dlg.style.width = digWidth;
		dlg.style.height = digHeight;
		var p_left = document.documentElement.clientWidth/2 - digWidth/2;
		var p_top = document.documentElement.clientHeight/2 - digHeight/2 + document.documentElement.scrollTop;
		dlg.style.left = p_left + "px";
		dlg.style.top = p_top + "px";
		dlg.style.display = "block";
		if (run_script) {
			popup_script = run_script;
		} else {
			popup_script = false;
		}
		this.load(url);

	};		

	/**
	 * dialog close
	 */
	this.dialog_close = function() {
		var objSelect = document.getElementsByTagName("select");
        for (var i=0; i < objSelect.length; i++) {
          objSelect[i].style.display = "block";
        }
		dlg_bg.style.display = 'none';
		dlg.style.display = 'none';
		dlg.innerHTML = '';
		msg.style.display = 'none'; 
	};

    /**
     * dialog message
     */
	this.in_alert = function(message) {
		msg.innerHTML = message;
		if (document.body.scrollTop == 0) {
			msg.style.top = document.documentElement.scrollTop + "px";
		} else {
			msg.style.top = document.body.scrollTop + "px";
		}
		msg.style.display = "block";
		//window.setTimeout(this.in_alert_hidden, 5000);
		in_alertcount++;
	};

    /**
     * dialog message hidden
     */
	this.in_alert_hidden = function() {
		in_alertcount--;
		if(!in_alertcount) {
			msg.style.display = "none";
		}
	};

    /**
     * dialog ajax load
     */
	this.load = function(url) {
		popup_req = null;
		if (window.XMLHttpRequest) {
			try {
				popup_req = new XMLHttpRequest();
			} catch(e) {
				popup_req = null;
			}
		} else if (window.ActiveXObject) {
			try {
				popup_req = new ActiveXObject("Msxml2.XMLHTTP");
			} catch(e) {
				try {
					popup_req = new ActiveXObject("Microsoft.XMLHTTP");
				} catch(e) {
					popup_req = null;
				}
			}
		}
		if (popup_req) {
			popup_req.onreadystatechange = this.processPopup;
			popup_req.open("GET", url, true);
			popup_req.setRequestHeader("Content-Type", "application/x-www-form-urlencoded;charset=UTF-8");
			popup_req.send("");
		}
	};

    /**
     * dialog ajax process :: script & loading
     */
	this.processPopup = function() {
		if (popup_req.readyState == 4 && popup_req.status == 200) {
			dlg.innerHTML = popup_req.responseText;
			if (popup_script) {
				eval(popup_script);
            }
		}
	};
};
