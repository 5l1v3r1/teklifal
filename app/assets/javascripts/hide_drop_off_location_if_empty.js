$(function() {
  hideDropOffLocation();
  
  $(document).on("turbolinks:load", function() {
    hideDropOffLocation();
  });
})

function hideDropOffLocation() {
  if (!$('#car_rental_announcement_different_location').is(':checked')) {
    $('#dropOffField').hide();
  }

  $('#car_rental_announcement_different_location').click(function() {
    // if(!this.checked) {
    //   $("#car_rental_announcement_drop_off_location").val("");
    // }

    $("#dropOffField").toggle(this.checked);
  })
}