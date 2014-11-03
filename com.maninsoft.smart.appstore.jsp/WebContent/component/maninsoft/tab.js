var TabUtil = function(psId){
	this.id = psId;
	this.voTab = null;
	var voTargetId = null;
	var focusId = null;
	
	this.init = function(){
		this.voTab = $(this.id);
		voTargetId = this.voTab.getElementsByTagName("div")[0].id;
		var targetPageUrl = this.voTab.getElementsByTagName("a")[0].href.split("#")[1];

		Mis.update(targetPageUrl, null, voTargetId);
		focusId = this.voTab.getElementsByTagName("a")[0].id;
		this.appendEvent();
	};
	
	this.appendEvent = function(){
		var Buttons = this.voTab.getElementsByTagName("li");
		var Event = this.onclick;
		for(var i=0, il=Buttons.length; i<il; i++){
			Buttons[i].onclick = Event;
		}
	};
	
	this.onclick = function(e){
		el = window.event ? window.event.srcElement : e.target;
		var targetPageUrl = el.href.split("#")[1];
		if(focusId == el.id) return;
		
		Mis.update(targetPageUrl, null, voTargetId);
		focusId = el.id;
	};
};