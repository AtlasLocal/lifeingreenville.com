$(document).ready(function() {
  
  $('#toggle').click(function() {
    if ($('#footer_nav').css('display') == 'none') {
      $('#footer_nav').show();
      $.scrollTo('100%', 600);
      $(this).removeClass('up').addClass('down')

    } else {
      $('#footer_nav').hide('slow');
      $(this).removeClass('down').addClass('up')
    }
  });

});