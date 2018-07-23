function offsetCenter(map, offsetx, offsety) {
  var scale = Math.pow(2, map.getZoom());

  var worldCoordinateCenter = map.getProjection().fromLatLngToPoint(map.getCenter());
  var pixelOffset = new google.maps.Point((offsetx/scale) || 0,(offsety/scale) ||0);

  var worldCoordinateNewCenter = new google.maps.Point(
      worldCoordinateCenter.x - pixelOffset.x,
      worldCoordinateCenter.y + pixelOffset.y
  );

  var newCenter = map.getProjection().fromPointToLatLng(worldCoordinateNewCenter);

  map.setCenter(newCenter);
}

function initMap() {
  var map = new google.maps.Map(document.getElementById('map'), {
    center: {lat: 38.969892, lng: 38.311895},
    zoom: 6
  });

  var bounds = new google.maps.LatLngBounds();
  var locations = {
    pick_up_location: null,
    drop_off_location: null
  }

  geodesicPoly = new google.maps.Polyline({
    strokeColor: '#ff9900',
    strokeOpacity: 1.0,
    strokeWeight: 3,
    geodesic: true,
    map: map,
    icons: [{
      icon: {
        path: google.maps.SymbolPath.FORWARD_CLOSED_ARROW
      },
      offset: '100%'
    }]
  });

  function setMapFromInput(element, destination) {
    google.maps.event.addDomListener(element, 'keydown', function(event) { 
      if (event.keyCode === 13) { 
          event.preventDefault(); 
      }
    });

    var input = element;
    var autocomplete = new google.maps.places.Autocomplete(input);
    autocomplete.bindTo('bounds', map);

    var marker = new google.maps.Marker({ map: map });

    autocomplete.addListener('place_changed', function() {
      input.classList.remove("is-invalid");
      marker.setVisible(false);
      var place = autocomplete.getPlace();
      if (!place.geometry) {
        locations[destination] = null
        input.classList.add("is-invalid");

        if (destination == 'pick_up_location') {
          if (locations['drop_off_location'])
            map.setCenter(locations['drop_off_location']);
        } else {
          if (locations['pick_up_location'])
            map.setCenter(locations['pick_up_location']);
        }
        // map.setZoom(17);
        offsetCenter(map, -200, 0)

        return;
      }

      $("#car_rental_announcement_latitude").val(place.geometry.location.lat())
      $("#car_rental_announcement_longitude").val(place.geometry.location.lng())

      locations[destination] = place.geometry.location
      bounds.extend(place.geometry.location)

      if (locations['pick_up_location'] && locations['drop_off_location']) {
        // debugger
        map.fitBounds(bounds)
        map.setZoom(map.getZoom() - 1)
        var path = [locations['pick_up_location'], locations['drop_off_location']];
        geodesicPoly.setPath(path);
      } else {
        // If the place has a geometry, then present it on a map.
        if (place.geometry.viewport) {
          map.fitBounds(place.geometry.viewport);
        } else {
          map.setCenter(place.geometry.location);
          // map.setZoom(17);  // Why 17? Because it looks good.
        }
      }

      offsetCenter(map, -200, 0);

      marker.setPosition(place.geometry.location);
      marker.setVisible(true);
    });
  }

  var inputPickUp = document.getElementById('car_rental_announcement_pick_up_location');
  var inputDropOff = document.getElementById('car_rental_announcement_drop_off_location');

  setMapFromInput(inputPickUp, 'pick_up_location');
  setMapFromInput(inputDropOff, 'drop_off_location');

}