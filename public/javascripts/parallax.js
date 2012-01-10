(function() {
  $(document).ready(function() {
    var interval, scrollBannerBG;
    scrollBannerBG = function() {
      var bannerHeight, bannerVerticalPos, bgHeight, offset, width;
      width = $(window).width();
      bannerHeight = 560;
      if (width <= 1023) {
        bannerHeight = 500;
      }
      if (width <= 500) {
        bannerHeight = 400;
      }
      bgHeight = bannerHeight * 1.2;
      offset = ($(window).scrollTop() / $(document).height()) * 500;
      bannerVerticalPos = ((bannerHeight - bgHeight) / 2) + offset;
      return $("header").css({
        'background-position': "50% " + bannerVerticalPos + "px"
      });
    };
    if (!ios) {
      $(window).bind("scroll", function(e) {
        return scrollBannerBG();
      });
      $(window).bind('resize', function(e) {
        return scrollBannerBG();
      });
    } else {
      window.lastScrollPosition = 0;
      window.doMobileParallax = function() {
        if ($(window).scrollTop() !== window.lastScrollPosition) {
          window.lastScrollPosition = $(window).scrollTop();
          return scrollBannerBG();
        }
      };
      interval = setInterval('doMobileParallax()', 30);
    }
    return scrollBannerBG();
  });
}).call(this);
