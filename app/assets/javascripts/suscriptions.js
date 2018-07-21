$(document).on("turbolinks:load", function() {

  $("#car_announcement_make").change(function() {
    var make = $("#car_announcement_make option:selected").val()
    var subscribersPath = "/subscriptions?make="

    var queryPath = subscribersPath + make


    $.ajax({url: queryPath});
  });

});
