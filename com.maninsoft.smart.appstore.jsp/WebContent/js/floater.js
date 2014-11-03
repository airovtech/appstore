var FloaterUtil = function(psId, psTop) {
	var id = psId;
	var voFloater = null;
	var interId = null;
	var diffY = 0;
	var lastScrollY = 1;
	var startY = 0;
	
	this.init = function() {
		voFloater = $(id);
		startY = psTop;
		this.interval();
	};

	this.interval = function() {
		interId = setInterval(this.floating, 1);
	};
	
	this.floating = function() {
		if (document.body.scrollTop == 0) {
			diffY = document.documentElement.scrollTop;
		} else {
			diffY = document.body.scrollTop;
		}
		if (diffY != lastScrollY) {
            var percent = .1 * (diffY - lastScrollY);
            if (percent > 0) percent = Math.ceil(percent);
            else percent = Math.floor(percent);		                
            startY += percent;
            voFloater.style.top = startY + "px";	
			lastScrollY = lastScrollY + percent;
	    }
	};
};