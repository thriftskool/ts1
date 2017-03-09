
//SETTING UP OUR POPUP
//0 means disabled; 1 means enabled;
var popupStatus = 0;
var topf ;
var leftf;

//set image to loader
function set_loader_image(path)
{
	 jQuery('#backgroundloader').html('<img src="'+path+'images/popup-top.gif.gif" />');
     jQuery("#popupContact").html('');
	//var divHeight = getDocHeight();
	//var divWidth = GetBodyWidth();
    var divHeight = screen.height;
	var divWidth = screen.width;
    
    //alert(divWidth);
    var divtop = 0;
	var divleft = 0;
	
	jQuery("#backgroundPopup").css({
		"position": 'fixed',
		"top": divtop,
		"left": divleft,
		"width":divWidth,
		"height":divHeight,
		"z-index": "3"
    });
	 
}

//loading loader image slow
function load_loader(){
	
		jQuery("#backgroundPopup").css({
			"opacity": "0.5",
			"z-index": "3"
		});
		
		centerloader();
		//jQuery("#backgroundPopup").fadeIn("slow");
		//jQuery("#backgroundloader").fadeIn("slow");
		
		jQuery("#backgroundPopup").show("slow");
		jQuery("#backgroundloader").show("slow");
		
}

//loading loader image fast
function load_loader_fast(){
		jQuery("#backgroundPopup").css({
			"opacity": "0.5",
			"z-index": "3"
		});
		centerloader();
		//jQuery("#backgroundPopup").fadeIn("fast");
		//jQuery("#backgroundloader").fadeIn("fast");
		
		jQuery("#backgroundPopup").show("fast");
		jQuery("#backgroundloader").show("fast");
}

// this will call after file is been load
function after_load_complete(var_pop_height,var_pop_width)
{
   //alert("in");
   jQuery("#backgroundloader").fadeOut("slow",centerPopup(var_pop_height,var_pop_width));
   //alert("out");
   
}
function disablePopup_loader(){
	//disables popup only if it is enabled
		jQuery("#backgroundloader").fadeOut("slow");	
}

// pop up will load
function loadPopup(){
	//loads popup only if it is disabled
	if(popupStatus==0){
		jQuery("#backgroundPopup").css({
			"opacity": "0.5",
			"z-index":"1"
		});
		//jQuery("#backgroundPopup").fadeIn("slow");
		//jQuery("#popupContact").fadeIn("slow");

		jQuery("#backgroundPopup").show("slow");
		jQuery("#popupContact").show("slow");
		popupStatus = 1;
	}
}

//disabling popup with jQuery magic!
function disablePopup(){
	//disables popup only if it is enabled
	//if(popupStatus==1){
		
		if(document.getElementById('popupContact')!=null)
		jQuery("#popupContact").html('');
		
		if(document.getElementById('backgroundPopup')!=null)
        jQuery("#backgroundPopup").fadeOut("slow");
		
		if(document.getElementById('popupContact')!=null)
		jQuery("#popupContact").fadeOut("slow");
		
		disablePopup_loader()
		popupStatus = 0;
	//}
}

//centering the loader
function centerloader(){
	//request data for centering
	var windowWidth = document.documentElement.clientWidth;
	var windowHeight = document.documentElement.clientHeight;
	var popupHeight = jQuery("#backgroundloader").height();
	var popupWidth = jQuery("#backgroundloader").width();
	//centering
        get_height_width(popupHeight,popupWidth);
	
        topf=CalculateTop_popup('32');
        
        jQuery("#backgroundloader").css({
		"position": "absolute",
		"top": topf,
		"left": leftf
	});
        
        /*
        jQuery("#backgroundloader").css({
		"position": "absolute",
		"top": windowHeight/2-popupHeight/2,
		"left": windowWidth/2-popupWidth/2
	});
        */
	//only need force for IE6
	
	jQuery("#backgroundPopup").css({
		"height": windowHeight,
		"z-index": "3"
	});
	
}
//centering popup
function centerPopup(var_pop_height,var_pop_width){
	//request data for centering
	
	var windowWidth = document.documentElement.clientWidth;
	var windowHeight = document.documentElement.clientHeight;
	
	var popupHeight = var_pop_height;
	var popupWidth = var_pop_width;
	
	/*var popupHeight = jQuery("#popupContact").height();
	var popupWidth = jQuery("#popupContact").width();*/
	
	get_height_width(popupHeight,popupWidth);
	

        topf=CalculateTop_popup('32');
        //alert(topf);
        topf=topf-200;
        //alert(leftf);
        if(ie)
            {
                    var ver = getInternetExplorerVersion();
                    //alert(ver);
                    if (ver > -1) {
                       if (ver >= 8.0)
                           {
                            
                           }
                            else
                            {
                                leftf=leftf-350;
                            }
                            
                        }
                //leftf=leftf-250;
				//leftf=191;
            }
		//alert(leftf);	
            
        /*
	jQuery("#popupContact").css({
		"position": "absolute",
		"top": windowHeight/2-popupHeight/2,
		"left": windowWidth/2-popupWidth/2
	});
	*/
       
	jQuery("#popupContact").css({
		"position": "absolute",
		"top": 150,
		"left": 525
		
	});
	
	//only need force for IE6
	
	jQuery("#backgroundPopup").css({
		"height": windowHeight
	});
	
	
	
	loadPopup();
}

// closing the popup
function styledPopupClose(evt)
{
	var key=(window.Event)?evt.which:evt.keyCode;
	if(key==27 && popupStatus==1)
	{
		disablePopup();
	}
}

// function to get top and left
function get_height_width(popupHeight,popupWidth)
{
	var popuph = popupHeight;
	var popupw = popupWidth;
	var popuph2 = popuph/2;
	var popupw2 = popupw/2;
	var winW = screen.width;
	var winH = screen.height;
	if (parseInt(navigator.appVersion)>3) {
		if (navigator.appName=="Netscape") {
			//winW = window.innerWidth;
			//winH = window.innerHeight;
			winW = document.body.offsetWidth;
			winH = document.body.offsetHeight;
		}
		if (navigator.appName.indexOf("Microsoft")!=-1) {
			winW = document.body.offsetWidth;
			winH = document.body.offsetHeight;
			//winW = window.innerWidth;
			//winH = window.innerHeight;
		}
	
	}
	//alert(window.innerWidth + ":" + window.innerHeight );
	var sh = winH;
	var sw = winW;
	var sh2 = sh/2;
	var sw2 = sw/2;
	
	topf = sh2 - popuph;
	leftf = sw2 - popupw2;
	
}

// this is used for ajax when click on submit
function loader_in(path)
{

	jQuery('#backgroundloader').html('<img src="'+path+'images/xajax-loader.gif" />');
	jQuery("#backgroundPopup").css({
			"opacity": "0.5",
			"z-index": "3",
            "width": GetBodyWidthNew(),
            "height": getDocHeight(),
            "top": 0,
            "left": 0
		});
	var windowWidth  = document.documentElement.clientWidth;
	var windowHeight = document.documentElement.clientHeight;
	var popupHeight  = jQuery("#backgroundloader").height();
	var popupWidth   = jQuery("#backgroundloader").width();
        
        get_height_width(popupHeight,popupWidth);
	
        topf=CalculateTop_popup('32');
        
        
    jQuery("#backgroundloader").css({
    "position": "absolute",
    "top": topf,
    "left": leftf
	});
	//centering
        
    /*
	jQuery("#backgroundloader").css({
		"position": "absolute",
		"top": windowHeight/2-popupHeight/2,
		"left": windowWidth/2-popupWidth/2
	});
   */
	//only need force for IE6
	
//	jQuery("#backgroundPopup").css({
//		"height": windowHeight,
//		"z-index": "3"
//	});
	
	//jQuery("#backgroundPopup").fadeIn("fast");
	//jQuery("#backgroundloader").fadeIn("fast");
	
	jQuery("#backgroundPopup").show("fast");
	jQuery("#backgroundloader").show("fast");
}

function CalculateTop_popup(Height)
{
	var ScrollTop=document.body.scrollTop;
	if(ScrollTop==0)
	{
		if(window.pageYOffset)
			ScrollTop=window.pageYOffset;
		else
			ScrollTop=(document.body.parentElement)?document.body.parentElement.scrollTop:0;
	}

	var BodyHeight=document.body.clientHeight;

	if(BodyHeight==0)
	{
		BodyHeight=window.innerHeight;
	}
	if(BodyHeight==0)
	{
		BodyHeight=document.documentElement.clientHeight
	}

	var myWidth = 0, myHeight = 0;
  	if( typeof( window.innerWidth ) == 'number' )
	{
		//Non-IE
		myWidth = window.innerWidth;
		myHeight = window.innerHeight;
	}
	else if( document.documentElement && ( document.documentElement.clientWidth || document.documentElement.clientHeight ) )
	{
    //IE 6+ in 'standards compliant mode'
		myWidth = document.documentElement.clientWidth;
		myHeight = document.documentElement.clientHeight;
	}
	else if( document.body && ( document.body.clientWidth || document.body.clientHeight ) )
	{
		//IE 4 compatible
		myWidth = document.body.clientWidth;
		myHeight = document.body.clientHeight;
	}

	var FinalTop=((myHeight-Height)/2)+ScrollTop;

	return FinalTop;
}

//CONTROLLING EVENTS IN jQuery
jQuery(document).ready(function(){
	
	
	//Press Escape event!
	jQuery(document).keypress(function(e){
		if(e.keyCode==27 && popupStatus==1){
			disablePopup();
		}
	});

});

function loader_in_new(path,elementid)
{
	jQuery('#backgroundloader').html('<img src="'+path+'images/xajax-loader.gif" />');
	jQuery("#backgroundPopup").css({
			"opacity": "0.5",
			"z-index": "3"
		});
	var divHeight = jQuery("#"+elementid+"").height();
	var divWidth = jQuery("#"+elementid+"").width();
    var divtop = getElTop(document.getElementById(''+elementid+''));
	var divleft = getElLeft(document.getElementById(elementid));
    topf=CalculateTop_popup('32');
    topf = divtop + divHeight/2;
    leftf = divleft + divWidth/2;
    jQuery("#backgroundloader").css({
    "position": "absolute",
    "top": topf,
    "left": leftf,
	"z-index": "3"
    });
    jQuery("#backgroundPopup").css({
    "position": "absolute",
    "width": divWidth,
    "height": divHeight,
    "top": divtop,
    "left": divleft,
	"z-index": "3"
    });
	jQuery("#backgroundPopup").show("fast");
	jQuery("#backgroundloader").show("fast");
}

var ns4 = (navigator.appName.indexOf("Netscape")>=0
          && parseFloat(navigator.appVersion) >= 4
          && parseFloat(navigator.appVersion) < 5)? true : false;
var ns6 = (parseFloat(navigator.appVersion) >= 5
          && navigator.appName.indexOf("Netscape")>=0 )? true: false;
var ns = (document.layers)? true:false;
var ie = (document.all)? true:false;

function getElLeft(el) {
    if (ns4) {return el.pageX;}
    else {
        xPos = el.offsetLeft;
        tempEl = el.offsetParent;
        while (tempEl != null) {
            xPos += tempEl.offsetLeft;
              tempEl = tempEl.offsetParent;
        }
        return xPos;
    }
}
function getElTop(el) {
    if (ns4) {return el.pageY;}
    else {
        yPos = el.offsetTop;
        tempEl = el.offsetParent;
        while (tempEl != null) {
            yPos += tempEl.offsetTop;
              tempEl = tempEl.offsetParent;
        }
        return yPos;
    }
}
function getInternetExplorerVersion() {

    var rv = -1; // Return value assumes failure.

    if (navigator.appName == 'Microsoft Internet Explorer') {

        var ua = navigator.userAgent;

        var re = new RegExp("MSIE ([0-9]{1,}[\.0-9]{0,})");

        if (re.exec(ua) != null)

            rv = parseFloat(RegExp.$1);

    }

    return rv;

}

//function GetBodyHeight()
//{
//    var theHeight1=0;
//    var theHeight2=0;
//    var theHeight3=0;
//
//    //alert(window.innerHeight);
//    if(window.innerHeight)
//    {
//        theHeight1=window.innerHeight;
//    }
//
//    if(document.documentElement&&document.documentElement.clientHeight)
//    {
//        //alert(document.documentElement.clientHeight);
//        theHeight2 = document.documentElement.clientHeight;
//    }
////    if(document.body)
////	 {
////       theHeight3=document.body.clientHeight;
////		if(isMozilla)
////		{
////		  var theHeight3 = 0;
////		}
////		else
////		{
////			theHeight3=document.body.scrollHeight;
////		}
////	}
//    var dsoctop=document.all? iebody.scrollTop : pageYOffset;
//    alert(dsoctop);
//    FinalHeight=Math.max(theHeight1,theHeight2,theHeight3);
//    FinalHeight=FinalHeight-70;
//    return FinalHeight;
//}
function getDocHeight() {
    var docHeight;
    if (typeof document.height != 'undefined') {
    docHeight = document.height;
    }
    else if (document.compatMode && document.compatMode != 'BackCompat') {
    docHeight = document.documentElement.scrollHeight;
    }
    else if (document.body && typeof document.body.scrollHeight !=
    'undefined') {
    docHeight = document.body.scrollHeight;
    }
    return docHeight;
}
function GetBodyWidthNew()
{
    var theWidth=0;
    if(document.body)
    {
        theWidth=document.body.clientWidth;
    }
    else if(document.documentElement&&document.documentElement.clientWidth)
    {
        theWidth=document.documentElement.clientWidth;
    }
    else if(window.innerWidth)
    {
        theWidth=window.innerWidth;
    }
    theWidth=theWidth;

    return theWidth - 5;
}

function disablePopupOnClose() {
    SetCookie('ratingpopupclosed', '1', 1);
    if (document.getElementById('popupContact') != null)
        jQuery("#popupContact").html('');
    if (document.getElementById('backgroundPopup') != null)
        jQuery("#backgroundPopup").fadeOut("slow");
    if (document.getElementById('popupContact') != null)
        jQuery("#popupContact").fadeOut("slow");
    disablePopup_loader()
    popupStatus = 0;
}

function SetCookie(cookieName, cookieValue, nDays) {
    var today = new Date();
    var expire = new Date();
    if (nDays == null || nDays == 0)
        nDays = 1;
    expire.setTime(today.getTime() + 3600000 * 24 * nDays);
    document.cookie = cookieName + "=" + escape(cookieValue)
            + ";expires=" + expire.toGMTString();
}
