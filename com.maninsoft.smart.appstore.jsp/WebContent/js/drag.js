var dragapproved = false;
var voDrag = null;

function initializedrag(psId, ev) {
	voDrag = $(psId);
	startX = ev.clientX;
	startY = ev.clientY;
	tempX = voDrag.style.left;
	tempY = voDrag.style.top;
	dragapproved = true;

	document.onmousemove = drag_drop;
}

function drag_drop(e) {
	var ev = (window.event) ? window.event : e;
	if (dragapproved && voDrag) {
		voDrag.style.left = parseInt(tempX) + ev.clientX - startX + "px";
		voDrag.style.top = parseInt(tempY) + ev.clientY - startY + "px";
		return false;
	}
}

document.onmouseup = new Function("dragapproved=false");
document.onmouseup = new Function("voDrag=null");