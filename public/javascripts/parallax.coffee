$(document).ready ->
	scrollBannerBG = ->
		height = $(document).height()
		bannerHeight = 500
		scroll = $(window).scrollTop()
		offset = (scroll/height) * 220
		bannerVerticalPos = -(bannerHeight/2) + offset
		$("header").css
			'background-position': "50% #{bannerVerticalPos}px"
	scrollBannerBG()
	$(window).bind "scroll", (e)->
		scrollBannerBG()

		
