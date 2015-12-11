// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require bootstrap-tagsinput
//= require jquery_nested_form
//= require jquery-ui
//= require jquery_ujs
// require turbolinks
//= require_tree .

var availableTags = [];             

    $.ajax({
      type: "GET",
      url: '/home/find_city',
      async: false,                
      dataType: "json",
      success:function(data){        
        availableTags = $.grep(data.cities,function(n){ return(n) });
        }
      });
// flash in alert
$(document).ready(function(){
	$("[class^=flash_notice]").each(function(){
		if ($(this).html() != ''){
			if ($(this).data('type') == "notice") {
				alertify.success($(this).text());
			}
			else{
				alertify.error($(this).text());
			}
		}
	});
	//logger
	function logger(msg){
		alertify.success(msg);
	}

	// globel configration

	// hide error container in search page
	$('.err_container').hide();




});