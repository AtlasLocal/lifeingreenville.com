$(document).ready(function() {
  $("#video").fitVids();

  var seanFit = function() {
    if ($(window).width() < $(window).height()) {
      $('#video').width($(window).height()*2+'px');
    }
  }

  $(window).resize(function(){
    seanFit();
  });

  $('#toggle').click(function() {
    if ($('#footer').height() != '77') {
      $('#footer').css('height','77px');
      $(this).removeClass('down').addClass('up')
    } else {
      $('#footer').css('height', '420px');
      $.scrollTo('100%', 600);
      $(this).removeClass('up').addClass('down')
    }
  });

});