function initAutocomplete() {
  autocompleteFor(document.getElementById('car_rental_announcement_pick_up_location'), true)
  autocompleteFor(document.getElementById('car_rental_announcement_drop_off_location'), false)
  autocompleteFor(document.getElementsByClassName('gmap-autocomplete-field')[0], true)
}

function autocompleteFor(input, changeLatLng = false) {
  if (!input)
    return;

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


  autocomplete.addListener('place_changed', function() {
    var place = autocomplete.getPlace();
    if (!place.geometry) {
      return;
    }

    if (changeLatLng) {
      $(".latitude-input").val(place.geometry.location.lat()).trigger('change')
      $(".longitude-input").val(place.geometry.location.lng()).trigger('change')
    }

  });
}