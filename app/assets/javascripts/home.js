$(document).ready(function(){

	$(".user-type-suplier").bind("click" ,function(){
		$('#signup_default').modal('hide');
		$('.error').hide();
		$("#radio-suplier").prop("checked", true);
		$("#signup").modal('show');	
	});

	$(".user-type-user").bind("click" ,function(){
		$("#signup").modal('hide');
		$('.error').hide();
		$("#radio-user").prop("checked", true);
		$('#signup_default').modal('show');
	});

	//dashbord search datepicker 
	$('.custom_datepicker').datetimepicker({
		defaultDate: new Date(),
		timepicker: false,
		format:'D M d Y',
		closeOnDateSelect:true
	});

	$('.custom_datepicker').val($('.custom_datepicker').val() || new Date().toDateString());

	// landing page search 
	$('#landing_page_search_btn').click(function(){
		$('.erorrr').html('');
		is_valid = true;
		name_regex=/^([a-zA-Z ]){3,15}$/;

		if ($('#landing_page_search_base_city').val() == ''){
			$('.error_search_base_city').html("can't be blank.");
			is_valid = false;
		}
		else if ($('#landing_page_search_base_city').val().length <3 || $('#landing_page_search_base_city').val().length > 15){
			$('.error_search_base_city').html("length should be 3-15");
			is_valid = false;
		}
		else if (!name_regex.test($('#landing_page_search_base_city').val())){
			$('.error_search_base_city').html("Invalid entry.");
			is_valid = false;
		}

		if ($('#landing_page_search_date').val() == ''){
			$('.error_search_date').html("can't be blank.");
			is_valid = false;
		}

		if ($('#landing_page_search_destination').val() != '' && ($('#landing_page_search_destination').val().length <3 || $('#landing_page_search_destination').val().length > 15)){
			$('.error_search_destination').html("length should be 3-15");
			is_valid = false;
		}
		else if ($('#landing_page_search_destination').val() != '' && !name_regex.test($('#landing_page_search_destination').val())){
			$('.error_search_destination').html("Invalid entry.");
			is_valid = false;
		}

		check_integer = /^[0-9]*$/;
		if ( $('#landing_page_search_duration').val() != '' && !check_integer.test($('#landing_page_search_duration').val())){
			$('.error_search_transport').html("Invalid entry.");
			is_valid = false;
		}


		if (is_valid){
			$('.err_container').hide('slow');
			return true;
		}
		else{
			$('.err_container').show('slow');
			return false;
		}
	});


	// home search reset and select all event
	$('.reset-select').click(function(){
		if ($(this).data('type') == 'reset'){
			$('.filter-by').prop('checked', false);
			$('#is_filter').val('false');
		}
		else{
			$('.filter-by').prop('checked', true);
			$('#is_filter').val('true');
		}
		$('#filter-by').submit();
	});

	//  home screen filter submit on change
	$('.filter-by').change(function(){
		$('#is_filter').val('true');
		$('#filter-by').submit();
		// alertify.success('started');
		// setTimeout(function(){ }, 2000);
	});

	$('.jslider-pointer').mouseup(function(){
		$('#is_filter').val('true');
		$('#filter-by').submit();
	});


// --------------------------------wishlist page
// wishlist link

$('.wishlist-link').click(function(e){
	signed_in = $(this).data('signed_in');
	if (signed_in){
		return true;
	}
	else{
		alertify.error('You need to signup first');
		$('#signup_default').modal('show');
		return false;
	}

});

$('.session-data').click(function(e){
	e.preventDefault();
	signed_in = $(this).data('signed_in');
	package_id = $(this).data('package-id');
	show = $(this).data('show');
	type = $(this).data('type');
	// $('.package_data').click(function(e){
	// 	e.preventDefault();
	// 	signed_in = $(this).data('signed_in');
	// 	package_id = $(this).data('package-id');
	// 	package_name = $(this).data('package-name');
	// 	if (signed_in){
	// 		$('.inq_of_package').text("Enquiry for " + package_name);
	// 		$('#enquiry_package_id').val(package_id);
	// 		 $('#enquiry-form').modal('show');
	// 	}
	// 	else{
	// 		$('#signup_default').modal('show');
	
	// 	}
	// });


$thiss = $(this).parent().parent().parent().parent().parent();
		// dark the color of 'this' as marked
		if (show){$parent = $(this);}else{$parent = $(this).parent();}
		if (signed_in){
			if (type == 'my-wishlist'){
				in_wishlist = $(this).data('in-wishlist');

				$.ajax({
					type: "POST",
					url: "/add-to-wishlist",
					data:{package_id: package_id},
					dataType: "json",
					success:function(data){
						if (data.status){
							$('.wishlist_bucket_count').html(data.count);
							$parent.addClass('in-wishlist');
							alertify.success('Item is being added to your Wishlist.');       
						}
						else{
							$('.wishlist_bucket_count').html(data.count);
							$parent.removeClass('in-wishlist');
							if (in_wishlist){$thiss.fadeOutAndRemove('slow');}
							alertify.success('Item is being removed from your Wishlist');  
						}
					},
					erorr:function(data){
						alertify.success('You are not allowed to do this.');
					}
				});
			}
			else{
				in_comparelist = $(this).data('in-comparelist');
				if (in_comparelist){
					if (is_valid_to_compare()-1 >= 2){
						window.location.href = '/comparision?package_id='+package_id;
					}
					else{
						alertify.error('You need atleast 2 packages in comparision');						
					}
				}
				else if (is_valid_to_compare() >=3){
					alertify.error('You can only have 3 packages in comparision bucket');	
				}
				else
				{
					$.ajax({
						type: "POST",
						url: "/add-to-comparision",
						data:{package_id: package_id},
						dataType: "json",
						success:function(data){
							if (data.status){
								$('.compare_bucket_count').html(data.count);
								$parent.addClass('in-wishlist');
								alertify.success('Item is being added to your Comparision Bucket.');       
							}
							else{
								$('.compare_bucket_count').html(data.count);
								$parent.removeClass('in-wishlist');
								alertify.success('Item is being removed from your Comparision Bucket.');  
							}
						},
						error: function (jqXHR, status, err) {
							alertify.alert('You are not authorized to perform this action!');
						}
					});
				}
			}
			// else ends for type 
		}
		else{
			alertify.error('You need to sign in as user!!');
			$('#signup_default').modal('show');
		}

	});

// remove from wish list x button in wishlist  NEED TO COMPACT THE CODE TO PREVIOUS remove all
$('.wishlist-remove').click(function(e){
	e.preventDefault();
	signed_in = $(this).data('signed_in');
	is_all = $(this).data('is_all') || false;
	package_id =$(this).data('package');
	thiss = $(this);
	$.ajax({
		type: "DELETE",
		url: "/delete-wishlist",
		data:{ package_id: package_id, is_all: is_all},
		dataType: "json",
		success:function(data){
			if (is_all){
				$('.wishlist').each(function(){
					$(this).fadeOutAndRemove('slow');
				});
			}
			else{
				$(thiss).parent().parent().fadeOutAndRemove('slow');
			}
			$('.wishlist_bucket_count').html(data.count);
			$('.wishlist_total_package').html(data.count+ " Packages");
			alertify.success('Package is being removed from Bucket.');
		}
	});

});

$.fn.fadeOutAndRemove = function(speed){
	$(this).fadeOut(speed,function(){
		$(this).remove();
	})
}





// // wishlist save changes 
// 	$('.wishlist-save-changes').click(function(e){
// 		e.preventDefault();
// 		ids = $.cookie('wishlist_bucket') || '';

// 		if (ids != ''){
// 			$.ajax({
// 				type: "POST",
// 				url: "/save-changes",
// 				data:{ids: ids},
// 				dataType: "json",
// 				success:function(data){   
// 					$.removeCookie('wishlist_bucket');
// 					alertify.success('Wishlist data is being saved.');
// 					// $('.wishlist_bucket_count').html('sim');               
// 				}
// 			});
// 		}
// 		else{
// 			alertify.success("Wishlist Bucket is allready upto date.");
// 		}
// 	});


// Comparision of packages

$('.comparision-bucket').click(function(e){
	if (is_valid_to_compare() >= 2){
		return true;
	}
	else{
		alertify.error('You need atleast 2 packages for comparision.');
		return false;
	}
});

function is_valid_to_compare() {
	var count = 0;
	$.ajax({
		type: "GET",
		url: "/is-valid-to-compare",
		data:{},
		async: false,
		dataType: "json",
		success:function(data){ 
			count = data.count;
		}
	});
	return count;
}

// compare page wishlist buttton

$('.add-wishlist-in-compare').click(function(e){
	e.preventDefault();

	$thiss = $(this).parent();
	package_id = $(this).data('package-id');
	$.ajax({
		type: "POST",
		url: "/add-to-wishlist",
		data:{package_id: package_id},
		dataType: "json",
		success:function(data){
			if (data.status){
				$('.wishlist_bucket_count').html(data.count);
				$thiss.fadeOutAndRemove('slow');
				alertify.success('Item is being added to your Wishlist.');       
			}
		}
	});


});

// ready ends here
});

