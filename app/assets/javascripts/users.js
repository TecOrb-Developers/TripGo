
$(document).ready(function(){

//Regex used

//var url_regex=/^http\:\/\/[a-zA-Z0-9\-\.]+\.[a-zA-Z]{2,3}(\/\S*)?$/;
var email_regex=/^[0-9a-zA-Z_.]+@[a-zA-Z]+?\.[a-zA-Z]{2,3}$/;
var check_initial_whitespace = /^(?!\s)([a-zA-Z0-9 _.'"()!?&@]){1,}$/;
var checkstring = /^(?!\s)([a-zA-Z ]){3,15}$/;
var check_integer = /^[0-9]*$/;
 

    $(function() {
     $( "#user_profile_attributes_based_out_of" ).autocomplete({
        source: availableTags
      });    
    });


// clear signup forms on click
$('.user-signup').click(function(){
  $('.signup-signin-form').each(function(){
    $(this)[0].reset();
  });
  $('.error').hide();
});

// for other Categories
$('#user_profile_attributes_category').hide();

$('input#other_category').click(function(){
  if ($(this).is(':checked')) {
    $('#user_profile_attributes_category').show('slow');
}
else {
  $('#user_profile_attributes_category').val('').hide('slow');
  $('.pr_error_label19').hide('slow');
}
});

// in case of edit user
 if($("#user_profile_attributes_category").val() != ''){
  $("#other_category").prop('checked', true);
  $("#user_profile_attributes_category").show();
}

// for other specilization

$('#user_profile_attributes_specilized_in').hide();

$('input#other').click(function(){
  if ($(this).is(':checked')) {
    $('#user_profile_attributes_specilized_in').show('slow');
}
else {
  $('#user_profile_attributes_specilized_in').val('').hide('slow');
  $('.pr_error_label18').hide();
}
});

// in case of edit user
 if($("#user_profile_attributes_specilized_in").val() != ''){
  $("#other").prop('checked', true);
  $("#user_profile_attributes_specilized_in").show();
}

$('#next_one').click(function(e){
e.preventDefault()  

        email = $("#user_email_id").val();
        $(".error").hide();
        $(".error").html('');
        var newjobErr = {};

        
        if ( ($("#user_name").val() == "")||(!checkstring.test($("#user_name").val()))) {
          newjobErr['jnme'] = '<li>please fill the valid name</li>';         
          $(".pr_error_label").html("please fill the valid name");
        }
         
      if(document.getElementById("password"))

      {

        if ($("#password").val() == '') {
          newjobErr['jnme'] = '<li>password can not be blank.</li>';         
          $(".pr_error_label1").html("password can't be blank");
        }

        else if (!check_initial_whitespace.test($("#password").val())){
          newjobErr['jnme'] = '<li>password can not start with white spaces.</li>';         
          $(".pr_error_label1").html("password can't start with white spaces");
        }

        else if ($("#password").val().length < 8){
          newjobErr['jnme'] = '<li></li>';         
          $(".pr_error_label1").html("password can't be less than 8 in length");
        }

        if ($("#confirm_password").val() != $("#password").val()) {
          newjobErr['jnme'] = '<li>password and confirm password should be same.</li>';         
          $(".pr_error_label2").html('password and confirm password should be same');
        }

      }

        if (($("#user_contact_no").val() == '')||(!check_integer.test($("#user_contact_no").val()))) {
          newjobErr['jnme'] = '<li>please fill a valid contect no.</li>';         
          $(".pr_error_label4").html("please fill a valid contect no");
        }

        if (($("#user_profile_attributes_agency_name").val() == '') || (!checkstring.test($("#user_profile_attributes_agency_name").val())) ) {
          newjobErr['jnme'] = '<li>please fill the valid name.</li>';         
          $(".pr_error_label5").html("please fill the valid name");
        }

        if ($("#user_profile_attributes_based_out_of").val() == '') {
          newjobErr['jnme'] = '<li>can not be blank.</li>';         
          $(".pr_error_label6").html("can't be blank");
        }

        if ($("#user_profile_attributes_head_office_address").val() == '') {
          newjobErr['jnme'] = '<li> can not be blank.</li>';         
          $(".pr_error_label7").html(" can't be blank");
        }

        if ($("#user_profile_attributes_branch_location").val() == '') {
          newjobErr['jnme'] = '<li> can not be blank.</li>';         
          $(".pr_error_label8").html(" can't be blank");
        }


        if ($("#user_profile_attributes_website_name").val() == '') {
          newjobErr['jnme'] = '<li> can not be blank.</li>';         
          $(".pr_error_label9").html(" can't be blank");
        }

  //           if($('#user_profile_attributes_logo').attr('type') == 'file'){
  //     if ($('#user_profile_attributes_logo').data('img_present') == false){
  //       fileExtension = ['jpg', 'jpeg', 'gif', 'png'];
  //       if ($.inArray($('#user_profile_attributes_logo').val().split('.').pop().toLowerCase(), fileExtension) == -1) {
  //        newjobErr['jnme'] = "<li>please select 'jpg', 'jpeg', 'gif', 'png' </li>";         
  //        $('.profile_logo_error').html("Please select ("+fileExtension+")");
  //      }
  //    } 
  //  }
  //  else{
  //   if($('#user_profile_attributes_logo').val() == ''){
  //     newjobErr['jnme'] = "<li>please fill the field  </li>";         
  //     $(".profile_logo_error").html("please fill the field ");
  //   }
  // }
      
      if( !($('#user_email_id').is(':disabled')))

      {
        
        if (email == '') {
          newjobErr['jnme'] = '<li> can not be blank.</li>';         
          $(".pr_error_label3").html(" can't be blank");
        }

        else if(!email_regex.test(email)){
        	newjobErr['jnme'] = '<li>please enter a valid email.</li>';
			$(".pr_error_label3").html("please enter a valid email");
		}
		else
		{

			$.ajax({
        type: "POST",
        async: false,
        url: "/users/check_email",
        data:{ email: email},
        dataType: "json",
        success:function(data){         
          {
          	 if(data == true){
          	 	newjobErr['jnme'] = '<li>email already exist.</li>';
          	 	$(".pr_error_label3").html("email already exist");
          	 }
          }                   
        }
      });
		}
  }

       
        var count = 0;
        $.each(newjobErr, function(key, value) { 
          count = count + 1;      
        });         
        if(count >= 1) {
                        $(".error").show();
                        alertify.alert("There are some validation errors in the form. Please correct it and then submit.")       
                        return false;   
                       } 
        else {     
               $('#form_one').hide();     
               $('#form_two').show();
              }         
      });


var _URL = window.URL || window.webkitURL;

$("#user_profile_attributes_logo").change(function(e) {
    var file, img;
    if ((file = this.files[0])) {
        img = new Image();
        img.onload = function() {
          if (this.width < 175 || this.height < 120){
            alertify.success("Please choose image greater than (175*120) in dimention !")
            $('#user_profile_attributes_logo').wrap('<form>').parent('form').trigger('reset');
            $('#user_profile_attributes_logo').unwrap();
          }
                    };
        img.onerror = function() {
            alertify.error( "not a valid file: " + file.type);
            $('#user_profile_attributes_logo').wrap('<form>').parent('form').trigger('reset');
            $('#user_profile_attributes_logo').unwrap();
        };
        img.src = _URL.createObjectURL(file);
    }
});


$('#submit_sign_up').click(function(){  
	
        
        $(".error").hide();
        $(".error").html('');
        var newjobErr = {};

        
        if ($("#user_profile_attributes_about_us").val() === '') {
          newjobErr['jnme'] = '<li>About us can not be blank.</li>';         
          $(".pr_error_label10").html("can't be blank");
        }

        // if (($("#user_profile_attributes_fb_profile_page").val() === '') && ($("#user_profile_attributes_ln_profile_page").val() === '') && ($("#user_profile_attributes_twitter_profile_page").val() === '')) {
        //   newjobErr['jnme'] = '<li>at least one profile page link is needed.</li>';         
        //   $(".pr_error_label13").html("at least one profile page link is needed");
        // }

        // else{
        //  $('[class^=profile_link_]').each(function(){
        //   alert($(this).val());
        //     if ($(this).val() !== ''){
        //       value = $(this).val();
        //       if (!url_regex.test(value)){
        //         newjobErr['jnme'] = '<li>please enter a valid url</li>';         
        //   $(".pr_error_label13").html("please enter a valid url");
        //       }
        //     }
        //  });
        //  }
        
        // if ($("#user_profile_attributes_fb_profile_page").val() == '') {
        //   newjobErr['jnme'] = '<li>Facebook profile_attributes page can not be blank.</li>';         
        //   $(".pr_error_label11").html("can't be blank");
        // }

        // else if (!url_regex.test($("#user_profile_attributes_fb_profile_page").val())) {
        //   newjobErr['jnme'] = '<li>please enter a valid url.</li>';         
        //   $(".pr_error_label11").html("please enter a valid url");
        // }

        // if ($("#user_profile_attributes_ln_profile_page").val() == '') {
        //   newjobErr['jnme'] = '<li>can not be blank.</li>';         
        //   $(".pr_error_label12").html('can not be blank');
        // }

        // else if (!url_regex.test($("#user_profile_attributes_ln_profile_page").val())) {
        //   newjobErr['jnme'] = '<li> please enter a valid url.</li>';         
        //   $(".pr_error_label12").html('please enter a valid url');
        // }

        // if ($("#user_profile_attributes_twitter_profile_page").val() == '') {
        //   newjobErr['jnme'] = '<li> can not be blank.</li>';         
        //   $(".pr_error_label13").html("can't be blank");
        // }
        
        // else if (!url_regex.test($("#user_profile_attributes_twitter_profile_page").val())) {
        //   newjobErr['jnme'] = '<li>please enter a valid url.</li>';         
        //   $(".pr_error_label13").html("please enter a valid url");
        // }

        // if ($("#user_profile_attributes_tour_locations option:selected").length==0) {
        //   newjobErr['jnme'] = '<li>Tour location can not be blank.</li>';         
        //   $(".pr_error_label14").html("Tour location can't be blank");
        // }

      if ($("#user_profile_attributes_tour_locations").val()=="") {
          newjobErr['jnme'] = '<li> can not be blank.</li>';         
          $(".pr_error_label14").html("can't be blank");
        }

        if($('.set_categories').find('.category:checked').length == 0 && ($('#user_profile_attributes_category').val() == "")){
          newjobErr['jnme'] = '<li> can not be blank.</li>';         
          $(".pr_error_label15").html("can't be blank");
        }

        if ($("#user_profile_attributes_awards").val() == '') {
          newjobErr['jnme'] = '<li> can not be blank.</li>';         
          $(".pr_error_label16").html("can't be blank");
        }

        if (($('.set_specilized').find('.specilized:checked').length == 0) && ($('#user_profile_attributes_specilized_in').val() == "")) {
          newjobErr['jnme'] = '<li>can not be blank.</li>';         
          $(".pr_error_label17").html("can't be blank");
        }
        
        if ($('input#other').is(':checked')) {
          if ($('#user_profile_attributes_specilized_in').val() == "") {
              newjobErr['jnme'] = '<li>please specify.</li>';         
          $(".pr_error_label18").html("please specify");
          }
        }

        if ($('input#other_category').is(':checked')) {
          if ($('#user_profile_attributes_category').val() == "") {
              newjobErr['jnme'] = '<li>please specify.</li>';         
          $(".pr_error_label19").html("please specify");
          }
        }


        var count = 0;
        $.each(newjobErr, function(key, value) { 
          count = count + 1;      
        });         
        if(count >= 1) {
                        $(".error").show();        
                        return false;   
                       } 
        else {     
               return true;
              }         
      });
  

    $('#Privious').click(function(){
        $('#form_one').show();     
        $('#form_two').hide();
    });
  

  $('.change_pass').click(function(){
        
        $(".error").hide();
        $(".error").html('');
        var newjobErr = {};
        
        if ($("#current_password").val() == '') {
          newjobErr['jnme'] = '<li>please enter existing password.</li>';         
          $(".err_current_password_field").html("please enter existing password");
        }

        if ($("#password").val() == ''){
          newjobErr['jnme'] = '<li>please enter new password.</li>';         
          $(".err_new_password_field").html("please enter new password");
        }

        else if (!check_initial_whitespace.test($("#password").val())){
          newjobErr['jnme'] = '<li>password can not start with white spaces.</li>';         
          $(".err_new_password_field").html("password can't start with white spaces");
        }

        else if ($("#password").val().length < 8){
          newjobErr['jnme'] = '<li></li>';         
          $(".err_new_password_field").html("password can't be less than 8 in length");
        }

        if ($("#password_confirmation").val() == ''){
          newjobErr['jnme'] = '<li>please enter confirm password.</li>';         
          $(".err_confirm_password_field").html("please enter confirm password");
        }

        else if (($("#password").val()) != ($("#password_confirmation").val())){
          newjobErr['jnme'] = '<li>password and confirm password does not match.</li>';         
          $(".err_confirm_password_field").html("password and confirm password doesn't match");
        }

        var count = 0;
        $.each(newjobErr, function(key, value) { 
          count = count + 1;      
        });         
        if(count >= 1) {
                        $(".error").show(); 
                        
                        return false;   
                       } 
       
  });
  



  


});
















// $("#user_email_id").blur(function() {
// 		email = $(this).val();
// 		var email_regex=/^[0-9a-zA-Z_.]+@[a-zA-Z]+?\.[a-zA-Z]{2,3}$/;
// 		if (email == ""){
// 			$(".pr_error_label3").html("Email can not be blank");
// 			$(".pr_error_label3").show();
// 		}
// 		else if (!email_regex.test(email)){
// 			$(".pr_error_label3").html("please enter a valid email");
// 			$(".pr_error_label3").show()
// 		}
// 		else{
// 		$.ajax({
//         type: "POST",
//         url: "/users/check_email",
//         data:{ email: email},
//         dataType: "json",
//         success:function(data){         
//           {
//           	 if(data == true){
//           	 	$(".pr_error_label3").html("Email already exist");
// 				$(".pr_error_label3").show()
//           	 }
//           	 else{
//           	 	$(".pr_error_label3").html("");
//           	 	$(".pr_error_label3").hide();
//           	 }
//           }                   
//         }
//       });
// 		}
// });