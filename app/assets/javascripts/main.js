
$('#sl2').slider();

var RGBChange = function() {
	$('#RGB').css('background', 'rgb('+r.getValue()+','+g.getValue()+','+b.getValue()+')')
};	
(function( $ ){
	$.fn.hoverGrid = function( options ) {  
		var settings = $.extend( {
			'itemClass' : '.item'
		}, options);
		
		return this.each(function() {       
			var hoverGrid = $(this);
			hoverGrid.addClass('hover-grid');
			hoverGrid.find(settings.itemClass).addClass('hover-grid-item');
			
			$(hoverGrid).find(settings.itemClass).hover(function () {
				$(this).find('div.caption').stop(false, true).fadeIn(200);
			},
			function () {
				$(this).find('div.caption').stop(false, true).fadeOut(200);
			});
		});
	};
})( jQuery );
/*scroll to top*/

$(document).ready(function(){

	$(function () {
		$.scrollUp({
	        scrollName: 'scrollUp', // Element ID
	        scrollDistance: 300, // Distance from top/bottom before showing element (px)
	        scrollFrom: 'top', // 'top' or 'bottom'
	        scrollSpeed: 300, // Speed back to top (ms)
	        easingType: 'linear', // Scroll to top easing (see http://easings.net/)
	        animation: 'fade', // Fade, slide, none
	        animationSpeed: 200, // Animation in speed (ms)
	        scrollTrigger: false, // Set a custom triggering element. Can be an HTML string or jQuery object
					//scrollTarget: false, // Set a custom target element for scrolling to the top
	        scrollText: '<i class="fa fa-angle-up"></i>', // Text for element, can contain HTML
	        scrollTitle: false, // Set a custom <a> title if required.
	        scrollImg: false, // Set true to use image
	        activeOverlay: false, // Set CSS color to display scrollUp active point, e.g '#00FFFF'
	        zIndex: 2147483647 // Z-Index for the overlay
	    });
	});
$("#flexiselDemo3").flexisel({
	visibleItems: 5,
	animationSpeed: 1000,
	autoPlay: true,
	autoPlaySpeed: 2000,            
	pauseOnHover: true,
	enableResponsiveBreakpoints: true,
	responsiveBreakpoints: { 
		portrait: { 
			changePoint:480,
			visibleItems: 1
		}, 
		landscape: { 
			changePoint:640,
			visibleItems: 2
		},
		tablet: { 
			changePoint:768,
			visibleItems: 3
		}
	}
});
$('#whatever').hoverGrid();
$('#whatever1').hoverGrid();


 $(document).on('hover', '.single-products', function(){

	// alert($(this).attr('id'));
	var dyanamic_val = $(this).attr('id');
	//alert(dyanamic_val);
	$('#content_'+dyanamic_val).slideToggle();
});


$('.single-productss').hover(function(){
	var dyanamic_val = $(this).attr('id');
	$('#content_'+dyanamic_val).slideToggle(300);
});	


});
