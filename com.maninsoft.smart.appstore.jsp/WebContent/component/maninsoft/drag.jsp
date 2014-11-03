<%@ page language="java" pageEncoding="UTF-8" contentType="text/html;charset=UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<!-- reference javascript -->
		<script type="text/javascript" src="other/prototype/prototype-1.6.0.2.js"></script>
		<script type="text/javascript" src="maninsoft-1.0.0.js"></script>
		<script type="text/javascript" src="drag.js"></script>

		<script type="text/javascript">
		</script>
	</head>
	<body>

	<div id="dag1" onMousedown="initializedrag('dag1', event)" style="cursor:pointer;position:absolute;top:30px;left:100px;width:400px;height:300px;background-color:#ff9966;">
		DIV 1
	</div>
	
	<div id="dag2" onMousedown="initializedrag('dag2', event)" style="cursor:pointer;position:absolute;top:100px;left:300px;width:400px;height:300px;background-color:#009966;">
		DIV 2
	</div>
	</body>
</html>