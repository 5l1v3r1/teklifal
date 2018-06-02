$(function() {
  document.addEventListener("trix-focus", function(event) {
    $(event.target.toolbarElement).slideDown()
    // event.target.toolbarElement.style.display = "block";
  });

  document.addEventListener("trix-blur", function(event) {
    $(event.target.toolbarElement).hide()
    // event.target.toolbarElement.style.display = "none";
  });
})