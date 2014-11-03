var FloaterUtil = function(psId){
	var id = psId;
	var voFloater = null;
	var interId = null;
	var diffY = 0;
	var lastScrollY = 1;
	var startY = 0;
	
	this.init = function(){
		voFloater = $(id);
		startY = parseInt(voFloater.style.top);
		this.interval();
	};

	this.interval = function() {
		interId = setInterval(this.floating, 1);
	};
	
	this.floating = function() {
		diffY = document.documentElement.scrollTop;
		if(diffY != lastScrollY) {
            var percent = .1 * (diffY - lastScrollY);
            if(percent > 0) percent = Math.ceil(percent);
            else percent = Math.floor(percent);		                
            startY += percent;
            voFloater.style.top = startY + "px";	
			lastScrollY = lastScrollY + percent;
	    }
	};
};