$(document).on("turbolinks:load", function() {
  if (document.getElementById("typed") != null) {
    new Typed("#typed", {
      strings: [
        "kolay ulaşılabilir olacak.",
        "daha profesyonel görünecek.",
        "daha yenilikçi olacak.",
      ],
      typeSpeed: 60,
      loop: true,
      backSpeed: 25,
      backDelay: 1500
    });
  }
});
