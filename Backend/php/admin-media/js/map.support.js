///* 
// * To change this template, choose Tools | Templates
// * and open the template in the editor.
// */


var map;
var marker;
var infowindow = new google.maps.InfoWindow();
var centerPoint;
var points;
var geocoder;
var elat = $('#int_lat').val();
var elng = $('#int_lng').val();
var elnglatAddr = $('#txt_latlan_address').val();
var elatArr = elat.split("#");
var elngArr = elng.split("#");
var elnglatAddrArr = elnglatAddr.split("$#$");
var markersArray = [];

function initialize() {

    geocoder = new google.maps.Geocoder();
    var elat = $('#int_lat').val("");
    var elng = $('#int_lng').val("");
    var elnglatAddr = $('#txt_latlan_address').val("");

    var centerPoint = new google.maps.LatLng(19.31717,-81.240578);   //Default
    var mapOptions = {
        zoom: 11,
        center: centerPoint,
        mapTypeId: google.maps.MapTypeId.ROADMAP
    };
    map = new google.maps.Map(document.getElementById("map"),mapOptions);

    if(elat != "" && elng!= ""){
        for(var i=1; i<elatArr.length; i++){
            //setTimeout('test1()',10000);
            addMarker(new google.maps.LatLng(elatArr[i],elngArr[i]));
        }
    }

    google.maps.event.addListener(map, 'click', function(event) {
        addMarker(event.latLng);
    });
}

function loadPoints(){
    elat = $('#int_lat').val();
    elng = $('#int_lng').val();
    elnglatAddr = $('#txt_latlan_address').val();
    elatArr = elat.split("#");
    elngArr = elng.split("#");
    elnglatAddrArr = elnglatAddr.split("$#$");
}

function addMarker(points){
    //setTimeout('test1()',10000);
    if(document.getElementById('int_lat').value == '' && document.getElementById('int_lng').value == '')
        codeLatLng(points);
    else
        alert('You can select only one location.');
}
						
function loadMarker(){
    $.each(markersArray, function(key, value) {
        google.maps.event.addListener(value, 'click', function(event) {
            loadPoints();
            removeMarker(value);
            $("#int_lat").val(elatArr.join("#"));
            $("#int_lng").val(elngArr.join("#"));
            $("#txt_latlan_address").val(elnglatAddrArr.join("$#$"));
        });


        google.maps.event.addListener(value, 'mouseover', function(event) {
            infowindow.setContent(value.address);
            infowindow.open(map, value);
        });

        google.maps.event.addListener(value, 'mouseout', function(event) {
            infowindow.close(map, value);
        });

    // google.maps.event.addListener(infowindow, 'closeclick', function() {
    //  alert(infowindow.content);
    // });
    });
}

function removeMarker(marker){
							
    var valCheckVar=new Array();
    var i=0;
								
    $.each(marker.position, function(key, value) {
        valCheckVar[i]=value;
        i++;
    });
								
    elatArr = jQuery.grep(elatArr, function(value) {
        var checkVar = valCheckVar[0];
        return value != checkVar.toFixed(15);
    });
    elngArr = jQuery.grep(elngArr, function(value) {
        var checkVar1 =valCheckVar[1];
        return value != checkVar1.toFixed(15);
    });
    /*elatArr = jQuery.grep(elatArr, function(value) {
									var checkVar = marker.position.Na;
									return value != checkVar.toFixed(15);
								});
								elngArr = jQuery.grep(elngArr, function(value) {
									var checkVar1 = marker.position.Oa;
        							return value != checkVar1.toFixed(15);
 	     						});
							  */
    elnglatAddrArr = jQuery.grep(elnglatAddrArr, function(value) {
        return value != marker.address;
    });
    marker.setMap(null);
}

function addLatLang(points,marker){
    $('#int_lat').val( $('#int_lat').val() + '#' + points.lat().toFixed(15));
    $('#int_lng').val( $('#int_lng').val() + '#' + points.lng().toFixed(15));

}

function codeLatLng(points,marker) {
    geocoder = new google.maps.Geocoder();
    geocoder.geocode({
        'latLng': points
    }, function(results, status) {
        if (status == google.maps.GeocoderStatus.OK) {
            if (results[1]) {
                marker = new google.maps.Marker({
                    position: points,
                    map: map
                });
                infowindow.setContent(results[0].formatted_address);
                $('#txt_latlan_address').val( $('#txt_latlan_address').val() + '$#$' + results[0].formatted_address);
                marker.address = results[0].formatted_address;
										
                markersArray.push(marker);
                loadMarker();
                addLatLang(points,marker);
            } else {
                alert("No address found.");
            }
        }else{
    //alert("Geocoder failed due to: " + status);
    }
    });
}