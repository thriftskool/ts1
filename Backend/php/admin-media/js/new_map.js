/* 
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

    var map;
    var marker;
    var centerPoint
    var points;
    var elat = $('#int_lat').val();
    var elng = $('#int_lng').val();
    var elatArr = elat.split("#");
    var elngArr = elng.split("#");
    var markersArray = [];

    function initialize() {

        var elat = $('#int_lat').val("");
        var elng = $('#int_lng').val("");

        var centerPoint = new google.maps.LatLng(19.31717,-81.240578);   //Default
        var mapOptions = {
              zoom: 11,
              center: centerPoint,
              mapTypeId: google.maps.MapTypeId.ROADMAP
        };
        map = new google.maps.Map(document.getElementById("map"),mapOptions);

        if(elat != "" && elng!= "")
        {
            for(var i=1; i<elatArr.length; i++)
            {
                addMarker(new google.maps.LatLng(elatArr[i],elngArr[i]));
            }
        }

        google.maps.event.addListener(map, 'click', function(event) {
            addMarker(event.latLng);
        });
    }


    function loadPoints()
    {
        elat = $('#int_lat').val();
        elng = $('#int_lng').val();
        elatArr = elat.split("#");
        elngArr = elng.split("#");
    }

    function addMarker(points)
    {
        marker = new google.maps.Marker({
                    position: points,
                    map: map
                });
        markersArray.push(marker);
        loadMarker();
        addLatLang(points);
    }

    function loadMarker()
    {
        $.each(markersArray, function(key, value) {
            google.maps.event.addListener(value, 'click', function(event) {
                loadPoints();
                removeMarker(value);
                $("#int_lat").val(elatArr.join("#"));
                $("#int_lng").val(elngArr.join("#"));
            });
        });
    }

    function removeMarker(marker)
    {
        elatArr = jQuery.grep(elatArr, function(value) {
                var checkVar = marker.position.ua;
                return value != checkVar.toFixed(15);

        });

        elngArr = jQuery.grep(elngArr, function(value) {
                var checkVar1 = marker.position.wa;
                return value != checkVar1.toFixed(15);
        });
        marker.setMap(null);
    }

    function addLatLang(points)
    {
        $('#int_lat').val( $('#int_lat').val() + '#' + points.lat().toFixed(15));
        $('#int_lng').val( $('#int_lng').val() + '#' + points.lng().toFixed(15));
    }

