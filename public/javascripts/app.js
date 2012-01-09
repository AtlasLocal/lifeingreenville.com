$(document).ready(function() {
  // $("#video").fitVids();

  var seanFit = function() {
    // if ($(window).width() < $(window).height()) {
    //   $('#video').width($(window).height()*2+'px');
    // }
    $('#video').height($(window).height()+'px');
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
  
  var footerHeight =  $('#footer_nav').height();
  $('#footer_nav').hide();
  
  $('#toggle').toggle(function(e) {
      $('#footer_nav').slideDown(800);
      $.scrollTo('+='+footerHeight+'px', 800);
      $(this).removeClass('up').addClass('down');
    }, function(e) {
      $('#footer_nav').slideUp(300);
      $(this).removeClass('down').addClass('up')
    }
  );
  
  /**
   * Detect user agent so we can correctly set footer height for iphone and ipad.
   */
  // var ua = navigator.userAgent
  // var detect = (ua.match(/iPad/i) || ua.match(/iPhone/i)) ? "iPhone" : "other";
  // window.detect = detect;
  // $('#toggle').click(function(e) {
  //   if ($('#footer').height() != '59') {
  //     $('#footer').css('height','59px');
  //     $(this).removeClass('down').addClass('up')
  //   } else {
  //     $('#footer').css('height', $('#footer_nav').height()+59+'px');
  //     if (detect != 'iPhone'){
  //       $.scrollTo('+='+$('#footer_nav').height()+'px', 300);
  //     } else {
  //       mobileScroll = $('#wrapper').height() - $('#footer').height();
  //       $.scrollTo(mobileScroll+'px', 300);
  //     }
  //     $(this).removeClass('up').addClass('down');
  //   }
  // });

});