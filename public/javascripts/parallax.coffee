$(document).ready ->
	return if detect == 'iPhone'
	scrollBannerBG = (animate=yes)->
		width = $(window).width()
		bannerHeight = 560
		if width <= 1023
			bannerHeight = 500
		if width <= 500
			bannerHeight = 400
		bgHeight = bannerHeight * 1.2
		offset = ($(window).scrollTop()/$(document).height()) * 500
		bannerVerticalPos = (((bannerHeight-bgHeight)/2) + offset)
		if animate
			$("header").stop().animate(
				'background-position-y': "#{bannerVerticalPos}",
				60,
				'easeOutQuad'
			)
		else
			$("header").css
				'background-position': "50% #{bannerVerticalPos}px"
	
	$(window).bind "scroll", (e)->
		scrollBannerBG(animate=yes)
	
	$(window).bind 'resize', (e)->
		scrollBannerBG()
	
	scrollBannerBG(animate=no)