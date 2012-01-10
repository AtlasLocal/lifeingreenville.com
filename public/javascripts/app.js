$(document).ready(function() {
  var seanFit = function() {
    $('#video').height($(window).height()+'px');
  }
  seanFit();

  $(window).resize(function(){
    seanFit();
  });
  
  var ua = navigator.userAgent
  window.ios = (ua.match(/iPad/i) || ua.match(/iPhone/i)) ? true : false;



  if ($.browser.mobile)
    $("a#visit").css("position", "absolute")

  if ($.browser.mobile || ios)
    $("#footer").css("position", "static")

  if (!$.browser.mobile && !ios) {
    var footerHeight =  $('#footer_nav').height();
    $('#footer_nav').hide();
    
    $('#toggle').toggle(function(e) {
        $('#footer_nav').slideDown(500);
        // $.scrollTo('+='+footerHeight+'px', 500, {easing: 'swing'});
        $(this).removeClass('up').addClass('down');
      }, function(e) {
        $('#footer_nav').slideUp(300, 'swing');
        $(this).removeClass('down').addClass('up')
      }
    );
  }

});