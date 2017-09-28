



$( document ).ready(function() {



  $('#datetimepicker1').datetimepicker({
        format: 'YYYY-MM-DD'

  });
  $('#datetimepicker2').datetimepicker({
      format: 'YYYY-MM-DD'


  });

  $("#datetimepicker1").on("dp.change", function (e) {
  $('#datetimepicker2').data("DateTimePicker").minDate(e.date);
  });

});












$('.js-anchor-link').click(function(e){
  e.preventDefault();
  var target = $($(this).attr('href'));
  if(target.length){
    var scrollTo = target.offset().top;
    $('body, html').animate({scrollTop: scrollTo+'px'}, 800);
  }
});
