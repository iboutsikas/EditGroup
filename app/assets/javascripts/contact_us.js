'use strict'
function init_map() {
  var var_location = new google.maps.LatLng(40.6374684,22.9346953);
  var var_mapoptions = {
    center: var_location,
    zoom: 14
  };

  var var_marker = new google.maps.Marker({
    position: var_location,
    map: var_map,
    title:"Thess"});



  var var_map = new google.maps.Map(document.getElementById("map-container"),
    var_mapoptions);

  var_marker.setMap(var_map);

}

$(function () { init_map() });

