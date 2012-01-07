(function() {

  $(document).ready(function() {
    var scrollBannerBG;
    scrollBannerBG = function() {
      var bannerHeight, bannerVerticalPos, height, offset, scroll;
      height = $(document).height();
      bannerHeight = 500;
      scroll = $(window).scrollTop();
      offset = (scroll / height) * 220;
      console.log("offset: " + offset);
      bannerVerticalPos = -(bannerHeight / 2) + offset;
      return $("header").css({
        'background-position': "50% " + bannerVerticalPos + "px"
      });
    };
    scrollBannerBG();
    return $(window).bind("scroll", function(e) {
      return scrollBannerBG();
    });
  });

}).call(this);
