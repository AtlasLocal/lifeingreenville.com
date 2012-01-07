(function() {

  $(document).ready(function() {
    var scrollBannerBG;
    scrollBannerBG = function() {
      var bannerHeight, bannerVerticalPos, bgHeight, offset, width;
      width = $(window).width();
      bannerHeight = 560;
      if (width <= 1023) bannerHeight = 500;
      if (width <= 500) bannerHeight = 400;
      bgHeight = bannerHeight * 1.5;
      offset = ($(window).scrollTop() / $(document).height()) * 220;
      bannerVerticalPos = ((bannerHeight - bgHeight) / 2) + offset;
      return $("header").css({
        'background-position': "50% " + bannerVerticalPos + "px"
      });
    };
    scrollBannerBG();
    $(window).bind("scroll", function(e) {
      return scrollBannerBG();
    });
    return $(window).bind('resize', function(e) {
      return scrollBannerBG();
    });
  });

}).call(this);
