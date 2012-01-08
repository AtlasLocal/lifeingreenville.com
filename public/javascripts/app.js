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
 * Detect user agent so we can correctly set footer height for iphone and ipad.
 */
var ua = navigator.userAgent
// TODO: This should be refactored. We really need to get away from these static values. -Mason
var detect = (ua.match(/iPad/i) || ua.match(/iPhone/i)) ? "540px" : "420px";
  $('#toggle').click(function() {
    if ($('#footer').height() != '77') {
      $('#footer').css('height','77px');
      $(this).removeClass('down').addClass('up')
    } else {
      $('#footer').css('height', detect);
      if (detect != '540px'){
      	$.scrollTo('+=420px', 800);
      } else {
        // This is not really wise, IMO (Speaking to myself, since I wrote it) -Mason
        mobileScroll = $('#wrapper').height() - $('#footer').height();
        $.scrollTo(mobileScroll+'px', 800);
      }
      $(this).removeClass('up').addClass('down');
    }
  });

});