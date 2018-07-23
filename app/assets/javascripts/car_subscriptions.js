$(document).on("turbolinks:load", function() {

  $("#car_announcement_make").change(function() {
    var make = $("#car_announcement_make option:selected").val()
    var subscribersPath = "/subscriptions"
    subscribersPath += "?make=" + make
    subscribersPath += "&type=CarAnnouncementSubscription"
    
    var queryPath = subscribersPath

    $.ajax({url: queryPath});
  });

});
