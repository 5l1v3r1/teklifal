$(document).on("turbolinks:load", function() {

  $("#slider-buttons [data-target]").on('click', function(event) {
    $("#slider-buttons [data-target]").removeClass("bg-light-primary")
    $(this).addClass("bg-light-primary")
  })

  $('#carouselExampleIndicators').on('slide.bs.carousel', function (e) {
    $("#slider-buttons [data-target]").removeClass("bg-light-primary")
    $("#slider-buttons [data-target]:eq(" + e.to +")").addClass("bg-light-primary")
  })

})