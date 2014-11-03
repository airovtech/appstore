<%@ page language="java" pageEncoding="UTF-8" contentType="text/html;charset=UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		
		<style>
		.tabs{
			width : 300px;
			height : 400px;
			border : 1px solid #000000;
			float : left;
		}

		.tabs div{
			display : block;
		}
		.yellow{
			background-color : yellow;
		}
		.blue{
			background-color : blue;
		}
		
		.divStyle{
			width:50px;
			height:50px;
			border: 1px solid #000;
		}
		
		</style>
		
		<!-- reference javascript -->
		<script type="text/javascript" src="other/prototype/prototype-1.6.0.2.js"></script>
		<script type="text/javascript" src="maninsoft-1.0.0.js"></script>
		<script type="text/javascript" src="tab.js"></script>
		<script type="text/javascript">

			function startTab(){
				voTabCtrl1 = new TabUtil("tabs1");
				voTabCtrl1.init();

				voTabCtrl2 = new TabUtil("tabs2");
				voTabCtrl2.init();
			}

			window.onload = startTab;
			
		</script>
	</head>
	<body>
		<div id="tabs1" class="tabs">
			<ul>
				<li><a id="1" href="#tab1.jsp" hideFocus="true">Nunc tincidunt</a></li>
				<li><a id="2" href="#tab2.jsp">Ajax Tab 1</a></li>
				<li><a id="3" href="#tab3.jsp">Ajax Tab 2</a></li>
			</ul>
			<div id="tabs1-1">
				
			</div>
		</div>
		
		<div id="tabs2" class="tabs">
			<ul>
				<li><a id="1" href="#tab1.jsp" hideFocus="true">Nunc tincidunt</a></li>
				<li><a id="2" href="#tab2.jsp">Ajax Tab 1</a></li>
				<li><a id="3" href="#tab3.jsp">Ajax Tab 2</a></li>
			</ul>
			<div id="tabs2-1">
				
			</div>
		</div>
		
	</body>
</html>

