$(document).ready(function(){

var checkstring = /^(?!\s)([a-zA-Z ]){3,15}$/;
var check_integer = /^[0-9]*$/;
var email_regex=/^[0-9a-zA-Z_.]+@[a-zA-Z]+?\.[a-zA-Z]{2,3}$/;
var check_initial_whitespace = /^(?!\s)([a-zA-Z0-9 _.'"()!?&@]){1,}$/;


	$('.enq_submit').click(function(e){
		$('.error').hide();
		is_valid = true;

		if ( ($("#enquiry_name").val() == "")||(!checkstring.test($("#enquiry_name").val()))) {         
          $(".enquiry_name_err_field").html("please fill the valid input").show('slow');
        	is_valid = false;
        }

        if ( ($("#enquiry_phone_no").val() == "")||(!check_integer.test(parseInt($("#enquiry_phone_no").val())))) {         
          $(".enquiry_phone_no_err_field").html("please fill the valid input").show('slow');
        	is_valid = false;
        }

        if ( ($("#enquiry_email").val() == "")||(!email_regex.test($("#enquiry_email").val()))) {         
          $(".enquiry_email_err_field").html("please fill the valid input").show('slow');
        	is_valid = false;
        }

        $(".validate_field:visible").each(function(){
        	current_id = $(this).attr('id');
        	if ($(this).val()== ""){
        		$("."+current_id+"_err_field").html("please fill the valid input").show('slow');
        		is_valid = false;
        	}
        });

    
    if (is_valid){
  		return ;
		}

	else{
		  return false;
		}   

	});

$('.complaint_submit').click(function(){
    $('.error').hide();
        is_valid = true;
        if ( ($("#complaint_name").val() == "")||(!checkstring.test($("#complaint_name").val()))) {         
          $(".complaint_name_err_field").html("please fill the valid input").show('slow');
            is_valid = false;
        }

        if ( ($("#complaint_contact_no").val() == "")||(!check_integer.test(parseInt($("#complaint_contact_no").val())))) {         
          $(".complaint_contact_no_err_field").html("please fill the valid input").show('slow');
            is_valid = false;
        }

        if ( ($("#complaint_email").val() == "")||(!email_regex.test($("#complaint_email").val()))) {         
          $(".complaint_email_err_field").html("please fill the valid input").show('slow');
            is_valid = false;
        }

        if ($("#complaint_category").val() == "") {         
          $(".complaint_category_err_field").html("please fill the valid input").show('slow');
            is_valid = false;
        }

        if ($("#complaint_subject").val() == "") {         
          $(".complaint_subject_err_field").html("please fill the valid input").show('slow');
            is_valid = false;
        }

        if ($("#complaint_message").val() == "") {         
          $(".complaint_message_err_field").html("please fill the valid input").show('slow');
            is_valid = false;
        }
        


        if (is_valid){
        return ;
        }

        else{
          return false;
        }   
});

});
