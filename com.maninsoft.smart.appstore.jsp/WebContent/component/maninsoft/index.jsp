<%@ page language="java" pageEncoding="UTF-8" contentType="text/html;charset=UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<!-- reference javascript -->
		<script type="text/javascript" src="other/prototype/prototype-1.6.0.2.js"></script>
		
		<script type="text/javascript" src="maninsoft-1.0.0.js"></script>
		
		<script type="text/javascript">
		function popupModalDialog() {
			var url = Mis.toNull(document.popupModalDialogForm.url.value);
			var callback = Mis.toNull(document.popupModalDialogForm.callback.value);
			var preScript = Mis.toNull(document.popupModalDialogForm.preScript.value);
			
			var options = null;
			if (preScript != null) {
				options = new Object();
				if (preScript != null)
					options["preScript"] = preScript;
			}
			
			Mis.popupModalDialog(url, null, callback, options);
		}

		function popupNotification() {
			var message = Mis.toNull(document.popupNotificationForm.message.value);
			var callback = Mis.toNull(document.popupNotificationForm.callback.value);
			var minTime = Mis.toNull(document.popupNotificationForm.minTime.value);

			var options = null;
			if (minTime != null) {
				options = new Object;
				if (minTime != null)
					options["minTime"] = minTime;
			}
			
			Mis.popupNotification(message, callback, options);
		}

		function request() {
			var url = Mis.toNull(document.requestForm.url.value);
			var callback = Mis.toNull(document.requestForm.callback.value);
			var options = null;
			var result = Mis.request(url, null, callback, options);
			if (Mis.isNull(result)) {
				document.getElementById("requestResultScope").value = "";
			} else {
				document.getElementById("requestResultScope").value = result.responseText;
			}
		}
		
		function update0() {
			var url = Mis.toNull(document.updateForm.url.value);
			var targetId = Mis.toNull(document.updateForm.target.value);
			var progress = Mis.toNull(document.updateForm.progress.value);
			var error = Mis.toNull(document.updateForm.error.value);
			var callback = Mis.toNull(document.updateForm.callback.value);
			
			var options = null;
			if (progress != null || error != null || callback != null) {
				options = new Object();
				if (progress != null)
					options["progress"] = progress;
				if (error != null)
					options["error"] = error;
				if (callback != null)
					options["callback"] = callback;
			}
			
			Mis.update(url, null, targetId, options);
		}
		</script>
	</head>
	<body>
		<form name="popupModalDialogForm">
			<b>function popupModalDialog(url, parameters, callback, options)</b> <input type="button" value="call" onclick="popupModalDialog()"><br>
			<table>
				<tr><td>name</td><td>value</td></tr>
				<tr><td>url(string):</td><td><input name="url" type="text" value="example/dialog/confirmation.jsp" style="width: 500;"></td></tr>
				<tr><td>parameters(hash):</td><td><input name="parameters" type="text" style="width: 500;"></td></tr>
				<tr><td>callback(function):</td><td><input name="callback" type="text" style="width: 500;" value="alert('modal dialog ok');"></td></tr>
				<tr><td>options["preScript"]</td><td><input name="preScript" type="text" style="width: 500;" value="alert('modal dialog start');"></td></tr>
			</table>
		</form>
		
		<form name="popupNotificationForm">
			<b>function popupNotification(message, callback, options)</b> <input type="button" value="call" onclick="popupNotification()"><br>
			<table>
				<tr><td>name</td><td>value</td></tr>
				<tr><td>message(string):</td><td><input name="message" type="text" value="Testing" style="width: 500;"></td></tr>
				<tr><td>callback(function):</td><td><input name="callback" type="text" style="width: 500;" value="alert('notification ok');"></td></tr>
				<tr><td>options["minTime"]</td><td><input name="minTime" type="text" style="width: 500;"></td></tr>
			</table>
		</form>
		
		<form name="requestForm">
			<b>function request(url, parameters, callback, options)</b> <input type="button" value="call" onclick="request()"><br>
			<table>
				<tr><td>name</td><td>value</td></tr>
				<tr><td>url(string):</td><td><input name="url" type="text" style="width: 500;" value="example/successXML.jsp"></td></tr>
				<tr><td>parameters(hash):</td><td><input name="parameters" type="text" style="width: 500;"></td></tr>
				<tr><td>callback(function):</td><td><input name="callback" type="text" style="width: 500;" value="alert('request complete')"></td></tr>
				<tr><td>options["confirm"]</td><td><input name="confirm" type="text" style="width: 500;" value=""></td></tr>
				<tr><td>options["progress"]</td><td><input name="progress" type="text" style="width: 500;" value="In Progress..."></td></tr>
				<tr><td>options["error"]</td><td><input name="error" type="text" style="width: 500;" value="Error!!"></td></tr>
				<tr><td>options["asynchronous"]</td><td><input name="asynchronous" type="text" style="width: 500;"></td></tr>
			</table>
		</form>
		requestResultScope<br>
		<textarea id="requestResultScope" style="width: 100%; height: 100px;"></textarea>
		
		<form name="updateForm">
			<b>function update(url, parameters, targetId, options)</b> <input type="button" value="call" onclick="update0()"><br>
			<table>
				<tr><td>name</td><td>value</td></tr>
				<tr><td>url(string):</td><td><input name="url" type="text" value="example/success.jsp" style="width: 500;"></td></tr>
				<tr><td>parameters(hash):</td><td><input name="parameters" type="text" style="width: 500;"></td></tr>
				<tr><td>targetId(string):</td><td><input name="target" type="text" style="width: 500;" value="udpateTargetScope"></td></tr>
				<tr><td>options["progress"]</td><td><input name="progress" type="text" style="width: 500;" value="In Progress..."></td></tr>
				<tr><td>options["error"]</td><td><input name="error" type="text" style="width: 500;" value="Error!!"></td></tr>
				<tr><td>options["callback"]</td><td><input name="callback" type="text" style="width: 500;" value="alert('update complete');"></td></tr>
			</table>
		</form>
		udpateTargetScope<br>
		<div id="udpateTargetScope" style="border: 1px solid;">&nbsp;</div>
		
	</body>
</html>