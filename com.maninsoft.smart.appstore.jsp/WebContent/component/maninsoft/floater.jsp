<%@ page language="java" pageEncoding="UTF-8" contentType="text/html;charset=UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<!-- reference javascript -->
		<script type="text/javascript" src="other/prototype/prototype-1.6.0.2.js"></script>
		<script type="text/javascript" src="maninsoft-1.0.0.js"></script>
		<script type="text/javascript" src="floater.js"></script>
		<script type="text/javascript">

			function startFloater(){
				voFloaterCtrl1 = new FloaterUtil("floater1");
				voFloaterCtrl1.init();
				
				voFloaterCtrl2 = new FloaterUtil("floater2");
				voFloaterCtrl2.init();
			}
			
			window.onload = startFloater;
		
			
		</script>
	</head>
	<body>
	<div id="debuger" style="height:1000px;">
		하하하!!!<br>
		하하하!!!
	</div>
	<div id="floater1" style="position:absolute; left:200px; top:190px; z-index:13; border:1px solid #ff0000; display:block;">
		<div id=""></div>
		<div id=""></div>
		scroll!!!!<br>
		scroll!!!!<br>
		scroll!!!!<br>
		scroll!!!!<br>
	</div>
	<div id="floater2" style="position:absolute; left:400px; top:300px; z-index:13; border:1px solid #ff0000; display:block;">
		<div id=""></div>
		<div id=""></div>
		scroll!!!!<br>
		scroll!!!!<br>
		scroll!!!!<br>
		scroll!!!!<br>
	</div>
	</body>
</html>