$(document).ready(function() {
  $("#video").fitVids();

  var seanFit = function() {
    if ($(window).width() < $(window).height()) {
      $('#video').width($(window).height()*2+'px');
    }
  }
  
  // var seanFit = function() {
  //   if ( $(window).width() < ( ($(window).height() - 200) * 1.77) ) {
  //     $('#video').width($(window).height()*1.77+'px');
  //   }
  // }
  
  seanFit();

  $(window).resize(function(){
    seanFit();
  });

/**
 * Detect user agent so we can set correct event handler for iphone and ipad.
 * 'event' is used in the main document event handler and the close fuction
 * for our $message boxes.
 */
var ua = navigator.userAgent
var detect = (ua.match(/iPad/i) || ua.match(/iPhone/i)) ? "inherit" : "420px";

  $('#toggle').click(function() {
    if ($('#footer').height() != '77') {
      $('#footer').css('height','77px');
      $(this).removeClass('down').addClass('up')
    } else {
      $('#footer').css('height', detect);
      $.scrollTo('+=420px', 800);
      $(this).removeClass('up').addClass('down');
    }
  });

});