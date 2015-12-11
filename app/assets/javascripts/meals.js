$(document).ready(function(){

// global configuraiton
$('.other_meal_type').hide('slow');
$('.meal_error').hide('slow');

// other field textbox show and radio checked on edit mode
if ($('.other_meal_type').val() != ''){
	$('.meal_type').each(function(){
		if ($(this).data('other') == '') {
			$(this).attr('checked', 'checked');
			$('.other_meal_type').show('slow');
		}
	});
}

// other_meal_type show/hide
	$('.meal_type').click(function(){
		if ($(this).data('other') == '') {
			$('.other_meal_type').show('slow');
		}
		else{
			$('.meal_error').hide('slow');
			$('.other_meal_type').hide('slow');
		}
	});

// meals_submit event
	$('.meals_submit').click(function(e){
		$('.meal_error').hide('slow');
		is_valid = true;

		$('.meal_type:checked').each(function(){
			if ($(this).data('other') === ''){
				if ($('.other_meal_type').val() === '') {
					error_message = "Other field can't be blank."
					$(".meal_other_field_err").html(error_message).show('slow');
					is_valid = false;
				}
				else{
					$(this).val($('.other_meal_type').val());				
				}
			} 
		});

		if (is_valid){
			return ;
		}
		else{
			alertify.error('Please fill the required field!');
			return false;
		}

	// meals_submit click event ends here
	});

// ready block ends here
});


