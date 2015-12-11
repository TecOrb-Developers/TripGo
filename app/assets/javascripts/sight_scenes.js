$(document).ready(function(){
	// globel configuration
	$('.error_sight').hide();

	// sight_scenes_inclued show hide div onload and click ==> done

	$("[class^=sight_scenes_inclued-]:checked").each(function(){
		accodion_index = $(this).data('accodion_index');
		if ($(this).val() === 'included'){
			$('#sight_scenes_div-'+accodion_index).show('slow');
		}
		else {
			$("#sight_scenes_div-"+accodion_index).hide('slow');
		}
	});

	$("[class^=sight_scenes_inclued-]").click(function(){
		accodion_index = $(this).data('accodion_index');
		if ($(this).val() === 'included'){
			$('#sight_scenes_div-'+accodion_index).show('slow');
		}
		else {
			$("#sight_scenes_div-"+accodion_index).hide('slow');
		}
	});

// sight_secne_submit onclick validation
	$('.sight_secne_submit').click(function(e){
		// e.preventDefault();
		is_valid = true;
		$('.error_sight').hide();

		$("[class^=sight_scenes_inclued-]:checked").each(function(){
			accodion_index = $(this).data('accodion_index');

			if ($("#sight_scene_included-"+accodion_index).is(':checked')){
				error_message = "Please select.";
				error_message2 = "Please fill the field.";

				// if($('#sight_scene_field-'+accodion_index+" :selected").val() == ''){
				// 	$(".error_sight_scene_field-"+accodion_index).html(error_message).show('slow');
				// 	is_valid = false;
				// }
				// if ($('#sight_scene_guide-'+accodion_index+" :selected").val() == ''){
				// 	$(".error_sight_scene_guide-"+accodion_index).html(error_message).show('slow');
				// 	is_valid = false;
				// }
				if ($('#sight_scene_destination-'+accodion_index).val() == ''){
					$(".error_sight_scene_destination-"+accodion_index).html(error_message2).show('slow');
					is_valid = false;
				}
				if ($('#sight_scene_description-'+accodion_index).val() == ''){
					$(".error_sight_scene_description-"+accodion_index).html(error_message2).show('slow');
					is_valid = false;
				}
				if ($('#sight_scene_picture-'+accodion_index).data('img_present') == false){
					fileExtension = ['jpg', 'jpeg', 'gif', 'png'];
					if ($.inArray($('#sight_scene_picture-'+accodion_index).val().split('.').pop().toLowerCase(), fileExtension) == -1) {
						$(".error_sight_scene_picture-"+accodion_index).html("Please select ("+fileExtension+")").show('slow');
						is_valid = false;
					}
				}
			}

		});

	if (is_valid){ 
		// alertify.success('success!');
		return ;
	}
	else{
		alertify.error('Please fill the required field of each tab!');
		return false;
	}

	});

// ready block ends here
});
