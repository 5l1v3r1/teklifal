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
  var autocomplete = new google.maps.places.Autocomplete(input);
}