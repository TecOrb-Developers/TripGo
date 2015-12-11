$(document).ready(function(){
	//globel configration
	$('.itinerary_error').hide();

	// onsubmit validdation done
	$('.itineraries_submit').click(function(e){
		// e.preventDefault();
		is_valid = true;
		$('.itinerary_error').hide('slow');

		$("[class*=itinerary_desc]").each(function(){
			if($(this).attr('type') == 'file'){
				// if ($(this).data('img_present') == false){
				// 	fileExtension = ['jpg', 'jpeg', 'gif', 'png'];
				// 	if ($.inArray($(this).val().split('.').pop().toLowerCase(), fileExtension) == -1) {
				// 		$(".error-"+$(this).attr('id')).html("Please select ("+fileExtension+")").show('slow');
				// 		is_valid = false;
				// 	}
				// }	
			}
			else{
				if($(this).val() == ''){
					$(".error-"+$(this).attr('id')).html("Please fill the field.").show('slow');
					is_valid = false;
				}
			}
		});

		if (is_valid){
			return ;
		}
		else{
			alertify.error('Please fill the required field of each tab!');
			return false;
		}
	});

//ready block ends here error-itineraries_1_description
});
