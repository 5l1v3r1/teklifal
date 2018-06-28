function initAutocomplete() {
  autocompleteFor(document.getElementById('car_rental_announcement_pick_up_location'))
  autocompleteFor(document.getElementById('car_rental_announcement_drop_off_location'))
}

function autocompleteFor(input) {
  google.maps.event.addDomListener(input, 'keydown', function(event) { 
    if (event.keyCode === 13) { 
        event.preventDefault(); 
    }
  });
  var bounds = new google.maps.LatLngBounds();
  bounds.extend(new google.maps.LatLng(38.969892, 38.311895))
  var autocomplete = new google.maps.places.Autocomplete(input, {
    bounds: bounds
  });
}