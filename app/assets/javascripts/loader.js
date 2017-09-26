$(document).ready(function() {

    // setTimeout(function(){
    //     $('body').addClass('loaded');
    //     // $('h1').css('color','#222222');
    // }, 3000);

  $("#loader-wrapper").hide();


  $(".event-search-button").click(function(){
    $("#loader-wrapper").show();
  });
})
