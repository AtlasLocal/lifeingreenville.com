$(document).ready ->
	
	scrollBannerBG = ->
		width = $(window).width()
		bannerHeight = 560
		if width <= 1023
			bannerHeight = 500
		if width <= 500
			bannerHeight = 400
		bgHeight = bannerHeight * 1.2
		offset = ($(window).scrollTop()/$(document).height()) * 500
		bannerVerticalPos = (((bannerHeight-bgHeight)/2) + offset)
		$("header").css
			'background-position': "50% #{bannerVerticalPos}px"
	
	if not ios
		$(window).bind "scroll", (e)->
			scrollBannerBG()
		
		$(window).bind 'resize', (e)->
			scrollBannerBG()
	else
		window.lsp = 0
		$(document).bind 'touchmove', (e)->
			scrollBannerBG()
			window.lsp = $(window).scrollTop()
		window.usp = ->  scrollBannerBG() if $(window).scrollTop() != window.lsp
		setInterval('usp()', 300)
		
		
	scrollBannerBG()