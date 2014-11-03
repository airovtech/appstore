<%@ page language="java" pageEncoding="UTF-8" contentType="text/html;charset=UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<!-- reference javascript -->
		<script type="text/javascript" src="other/prototype/prototype-1.6.0.2.js"></script>
		<script type="text/javascript" src="maninsoft-1.0.0.js"></script>
		<script type="text/javascript" src="div_popup.js"></script>

		<script type="text/javascript">
			
			var voPopupCtrl;
			function startPopup() {
				voPopupCtrl = new PopupUtil();
				voPopupCtrl.init();		
			}
			
			function openPopup() {
				voPopupCtrl.dialog_open("div_popup_sub.jsp",500, 400, 10, "alert('열려라');");
				voPopupCtrl.in_alert("ESC를 누르시면 창이 닫힙니다.");
			}
			
						
			window.onload = startPopup;
			document.onkeydown = esc_close;

			/* esc key press popup window close*/
			function esc_close(nsEvent){
			    var event = nsEvent ? nsEvent : window.event;
			    var nKey = event.keyCode;
			    if(nKey == 27){                  //esc
			   		voPopupCtrl.dialog_close();
			    }
			}
			
		</script>
	</head>
	<body>

	<input type="button" id="popup" value="popup open!" onclick="openPopup()" />
	<div id="dialogbackgroundlayer" style="display:none;position:absolute;z-index:21;cursor:pointer" onclick="voPopupCtrl.dialog_close();"></div>
	<div id="dialoglayer" style="display:none;position:absolute;z-index:22;"></div>
	<div id="message" style="display:none;position:absolute;left:0px;top:0px;padding:3px 5px 0px 5px;background:#569fc7;color:#ffffff;font-size:12px;font-weight:bold;z-index:100;"></div>
	
	</body>
</html>