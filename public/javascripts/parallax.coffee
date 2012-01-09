$(document).ready ->
	return if detect == 'iPhone'
	scrollBannerBG = ->
		width = $(window).width()
		bannerHeight = 560
		if width <= 1023
			bannerHeight = 500
		if width <= 500
			bannerHeight = 400
		bgHeight = bannerHeight * 1.2
		offset = ($(window).scrollTop()/$(document).height()) * 220
		bannerVerticalPos = Math.floor(((bannerHeight-bgHeight)/2) + offset)
		$("header").css
			'background-position': "50% #{bannerVerticalPos}px"
	
	$(window).bind "scroll", (e)->
		scrollBannerBG()
	
	$(window).bind 'resize', (e)->
		scrollBannerBG()
	
	scrollBannerBG()