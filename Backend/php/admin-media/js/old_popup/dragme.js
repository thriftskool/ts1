var ie = document.all;
var nn6 = document.getElementById &&! document.all;

var isdrag = false;
var x, y;
var dobj;

function movemouse( e ) {	
  if( isdrag ) {
    dobj.style.left = nn6 ? tx + e.clientX - x + "px" : tx + event.clientX - x + "px";
    dobj.style.top  = nn6 ? ty + e.clientY - y + "px" : ty + event.clientY - y + "px";
    return false;
  }
}
function move_popupContact(e)
{
	//alert("om");
	fobj=document.getElementById("popupContact");
        //alert(fobj.className)
	if (fobj.className=="dragme") {
		isdrag = true;
		dobj = document.getElementById("popupContact");
		tx = parseInt(dobj.style.left+0);
		ty = parseInt(dobj.style.top+0);
		x = nn6 ? e.clientX : event.clientX;
		y = nn6 ? e.clientY : event.clientY;
		document.onmousemove=movemouse;
		return false;
	}
}
function selectmouse( e ) {
  
  var fobj       = nn6 ? e.target : event.srcElement;
  //alert(fobj);
  var topelement = nn6 ? "HTML" : "BODY";
  if(fobj.parentElement == null ) { } else {
  
	  while (fobj.tagName != topelement && fobj.className != "dragme") {
		  //alert(fobj.parentElement);
		fobj = nn6 ? fobj.parentNode : fobj.parentElement;
	  }
  }
  
	  if (fobj.className=="dragme") {
		/*isdrag = true;
		dobj = document.getElementById("popupContact");
		tx = parseInt(dobj.style.left+0);
		ty = parseInt(dobj.style.top+0);
		x = nn6 ? e.clientX : event.clientX;
		y = nn6 ? e.clientY : event.clientY;
		document.onmousemove=movemouse;
		return false;*/
	  }
	  else
	  {
		  //alert("diffclass");
	  }
}
document.onmousedown=selectmouse;
document.onmouseup=new Function("isdrag=false");