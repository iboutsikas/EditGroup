$(function() {
  function initContactMap() {
    var mLocation = new google.maps.LatLng(40.6374643,22.9346953);

    var mOptions = {
      center: mLocation,
      zoom: 14
    };

    var mMarker = new google.maps.Marker({
      position: mLocation,
      map: mMap,
      title:"Leontos Sofou Building"
    });

    var mMap = new google.maps.Map(document.getElementById("contact-map"),
            mOptions);

		mMarker.setMap(mMap);
  }
  google.maps.event.addDomListener(window, 'load', initContactMap);
});
