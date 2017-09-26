


// $("#datepicker1").datepicker({
//   showOn: "both",
//   onSelect: function(dateText, inst){
//      $("#datepicker2").datepicker("option","minDate",
//      $("#datepicker1").datepicker("getDate"));
//   }
// });

// $("#datepicker2").datepicker();


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









//
//   $('.datepicker1').datepicker();
//   $('.datepicker2').datepicker();

//   $(".datepicker1").on("dp.change", function (e) {
//   $('.datepicker2').data("DatePicker").minDate(e.date);
//   });
// });


// $( document ).ready(function() {

// $( ".datepicker1" ).datepicker({
//     minDate: 0,
//     maxDate: "+2Y",
//     showWeek: true,
//     weekHeader: 'Wk',
//     onSelect: function( selectedDate ) {
//         $( ".datepicker2" ).datepicker("option", "minDate", selectedDate );
//         setTimeout(function(){
//             $( ".datepicker2" ).datepicker('show');
//         }, 16);
//     }
// });

// $( ".datepicker2" ).datepicker({
//     maxDate: "+2Y",
//     showWeek: true,
//     weekHeader: 'Wk'
// });

// });



$('.js-anchor-link').click(function(e){
  e.preventDefault();
  var target = $($(this).attr('href'));
  if(target.length){
    var scrollTo = target.offset().top;
    $('body, html').animate({scrollTop: scrollTo+'px'}, 800);
  }
});
