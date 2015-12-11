// #= require active_admin/base

$(document).ready(function(){
	$('.package-imagee').change(function(){
	    package_id = $(this).data('package-id');
	    recommended_for = $(this).data('recommended-for');
	   		$.ajax({
			      type: "put",
			      data: {package_id: package_id, recommended_for: recommended_for },
			      url: '/recommended_side',
			      dataType: "json",
			      success:function(data){ 
			   			data.status

			        }
      		});
	    
	});
});
