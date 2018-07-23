$(document).on("turbolinks:load", function() {

  $("#car_rental_announcement_longitude").change(function() {
    var lon = $("#car_rental_announcement_longitude").val()
    var lat = $("#car_rental_announcement_latitude").val()
    var subscribersPath = "/subscriptions"
    subscribersPath += "?type=CarRentalAnnouncementSubscription"
    subscribersPath += "&longitude=" + lon
    subscribersPath += "&latitude=" + lat

    var queryPath = subscribersPath


    $.ajax({url: queryPath});
  });

});
