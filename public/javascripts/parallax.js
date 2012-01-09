(function() {

  $(document).ready(function() {
    var animate, scrollBannerBG;
    if (detect === 'iPhone') return;
    scrollBannerBG = function(animate) {
      var bannerHeight, bannerVerticalPos, bgHeight, offset, width;
      if (animate == null) animate = true;
      width = $(window).width();
      bannerHeight = 560;
      if (width <= 1023) bannerHeight = 500;
      if (width <= 500) bannerHeight = 400;
      bgHeight = bannerHeight * 1.2;
      offset = ($(window).scrollTop() / $(document).height()) * 500;
      bannerVerticalPos = ((bannerHeight - bgHeight) / 2) + offset;
      if (animate) {
        return $("header").stop().animate({
          'background-position-y': "" + bannerVerticalPos
        }, 60, 'easeOutQuad');
      } else {
        return $("header").css({
          'background-position': "50% " + bannerVerticalPos + "px"
        });
      }
    };
    $(window).bind("scroll", function(e) {
      var animate;
      return scrollBannerBG(animate = true);
    });
    $(window).bind('resize', function(e) {
      return scrollBannerBG();
    });
    return scrollBannerBG(animate = false);
  });

}).call(this);
