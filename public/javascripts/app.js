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
  var detect = (ua.match(/iPad/i) || ua.match(/iPhone/i)) ? "iPhone" : "other";
  window.detect = detect;
  $('#toggle').click(function(e) {
    if ($('#footer').height() != '77') {      
      $('#footer').css('height','77px');
      $(this).removeClass('down').addClass('up')
    } else {
      $('#footer').css('height', $('#footer_nav').height()+77+'px');      
      if (detect != 'iPhone'){      
      	$.scrollTo('+='+$('#footer_nav').height()+'px', 300);
      } else {      
        mobileScroll = $('#wrapper').height() - $('#footer').height();
        $.scrollTo(mobileScroll+'px', 300);      
      }      
      $(this).removeClass('up').addClass('down');
    }
  });

});