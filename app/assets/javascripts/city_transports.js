$(document).ready(function(){

	$('.error').hide();
	 $('[id^=get_ct_input_]').hide();

	$('[id^=city_transpotation_]').click(function(){
		index = $(this).data('city_index')
		if ($(this).val() === 'included'){
			$('#city_transport_modes_'+index).show('slow');
		}

		else {
			$("#city_transport_modes_"+index).hide('slow');
			$(".modes_"+index).prop("checked", false);
		}
		
	});

	$(window).load(function(){
		$('[id^=city_transpotation_]:checked').each(function(){
			index = $(this).data('city_index')
			if ($(this).val() !== 'included'){
			$("#city_transport_modes_"+index).hide();
			$(".modes_"+index).prop("checked", false);
			}

		});

		$('[id^=get_ct_input_]').each(function(){
			array_ct_input = $(this).attr('id').split('_');
			array_ct_input = array_ct_input[array_ct_input.length-1]
			if ($(this).val() !== ""){
				$('.modes_'+array_ct_input).prop("checked", true);
				$(this).show();
			}

		});
			
	});

	$('.update_in_city_transport').click(function(e){
		is_valid = true;
		$('.error').hide();
		$('[id^=city_transpotation_]:checked').each(function(){
			index = $(this).data('city_index');
			if($(this).val() === 'included'){
				if($('[class^=modes_'+index+']:checked').length === 0){
				$('.city_transport_error_'+index).html('please select the transpotation mode').show();
				is_valid = false;
				}
				else{	
					if ($('.modes_'+index+':checked').val() === ''){
						if ($('#get_ct_input_'+index).val() === ''){
							$('.input_city_transport_error_'+index).html("can't be blank").show();
							is_valid = false;
							}
						$('.modes_'+index+':checked').val($('#get_ct_input_'+index).val());
					}
					
				}
			}
		});
		if (is_valid){
			return true;
		}
		else
		{	alertify.alert('Please fill the required field of each tab!')
			return false;
		}
	});

	
$("[class^=modes_]").click(function(){  
  transport_name_radio = $(this).attr('class').split('_');
  transport_name_radio = transport_name_radio[transport_name_radio.length-1]
  if($(this).val() === ''){
    $('#get_ct_input_'+transport_name_radio).show('slow');
  }
  else{
    $('#get_ct_input_'+transport_name_radio).val('').hide('slow');
    $('.input_city_transport_error_'+transport_name_radio).val('').hide('slow');
  }
});

});
