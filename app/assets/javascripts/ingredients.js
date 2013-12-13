$(document).ready(function() {
  $("form").on("ajax:success", function(e, data, status, xhr) {
    $("#ingredients").append(data)
  })
})