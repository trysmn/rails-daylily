$(document).ready(function() {
  // setTimeout(function(){
  //     $('body').addClass('loaded');
  //     // $('h1').css('color','#222222');
  // }, 3000);

  // $(".event-search-button").click(function() {
  //   $("#loader-wrapper").show();
  // });

  var $searchButton = $(".event-search-button");

  // catch the click on hompage (search)
  $searchButton.on("click", function(e) {
    e.preventDefault();

    // get the values from the form:
    var city = $("[name='search[origin_iata]']").val();
    var departureDate = $("[name='search[departure]']").val();
    var returnDate = $("[name='search[return]']").val();

    console.log(city);
    console.log(departureDate);
    console.log(returnDate);

    // Display the loader
    $("#loader-wrapper").fadeIn(200);

    // do the ajax request to get results:
    var resultURL = `/events?search[origin_iata]=${city}&search[departure]=${departureDate}&search[return]=${returnDate}`;

    $.ajax({
      type: "GET",
      url: resultURL,
      success: function(data) {
        // console.log(data);

        // // hide the loader
        $("#loader-wrapper").fadeOut(200);

        // change the HTML inside the page:

        // 1) parse the HTML response and only take the "body" content
        var body = data.substring(
          data.indexOf("<body>") + 6,
          data.indexOf("</body>")
        );

        // 2) replace the current body by the new one from events#index
        $("body").html(body);

        // change the URL to reflect the new one (search) using HTML5
        window.history.pushState("results", "Results", resultURL);
      },
      error: function() {
        // something bad happened.
      }
    });

    return false;
  });
});
