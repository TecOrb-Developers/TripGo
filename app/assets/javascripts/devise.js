$(document).ready(function(){

  // forgot password modal show/hide
	$('[id^=forgot_]').click(function(){
    $("#signup").modal('hide');
    $("#signup_default").modal('hide');
    $("#radio-user").prop("checked", true);
  });


	$('.login').click(function(){
    email_regex=/^[0-9a-zA-Z_.]+@[a-zA-Z]+?\.[a-zA-Z]{2,3}$/;
    $(".error").html('').hide();
    var newjobErr = {};
    id_postfix = '_consumer';
    if ($(this).hasClass('login-user')){
      id_postfix = '_suplier';
    }

    if ($("#user_email"+id_postfix).val() == '') {
      newjobErr['jnme'] = '<li>Please enter email.</li>';         
      $(".email_field").html("Please enter email");
    }

    else if (!email_regex.test($("#user_email"+id_postfix).val())){
     newjobErr['jnme'] = '<li>Please enter valid email.</li>';         
     $(".email_field").html("Please enter valid email");
  }

  if ($("#user_password"+id_postfix).val() == ''){
    newjobErr['jnme'] = '<li>Please enter password.</li>';         
    $(".password_field").html("Please enter password");
  }

  var count = 0;
  $.each(newjobErr, function(key, value) { 
    count = count + 1;      
  });         
  if(count >= 1) {
    $(".error").show('slow');        
    return false;   
  } 

// login action ends here
  });

  $('.forgot_pass').click(function(){
    email_regex=/^[0-9a-zA-Z_.]+@[a-zA-Z]+?\.[a-zA-Z]{2,3}$/;
    $(".error").hide();
    $(".error").html('');
    var newjobErr = {};

    if ($("#user_emailid").val() == '') {
      newjobErr['jnme'] = '<li>Please enter email.</li>';         
      $(".forgot_email_field").html("Please enter email");
    }
    else if (!email_regex.test($("#user_emailid").val())){
      newjobErr['jnme'] = '<li>Please enter valid email.</li>';         
      $(".forgot_email_field").html("Please enter valid email");
    }
    var count = 0;
    $.each(newjobErr, function(key, value) { 
      count = count + 1;      
    });         
    if(count >= 1) {
      $(".error").show();
      return false;   
    } 
// forgot password action ends here
  });

// consumer registration action

$('#consumer_registration_submit').click(function(e){
  $('.error').hide('slow');
  // e.preventDefault();

  name_regex=/^([a-zA-Z ]){3,15}$/;
  email_regex=/^[0-9a-zA-Z_.]+@[a-zA-Z]+?\.[a-zA-Z]{2,3}$/;
  phone_regex=/^([0-9]){10,15}$/;
  check_initial_whitespace = /^(?!\s)([a-zA-Z0-9 _.'"()!?&@]){8,}$/;
  ercount = 0;

  if($('#consumer_name').val() == ""){
    $("#consumer_name").next().html("can't be blank.").show('slow');
    ercount+=1;
  }
  else if (!name_regex.test($("#consumer_name").val())){
    $("#consumer_name").next().html("Invalid.(should contain 3 to 15 characters.)").show('slow');
    ercount+=1;
  }

  if($('#consumer_email').val() == ""){
    $('#consumer_email').next().html("can't be blank.").show('slow');
    ercount+=1;
  }
  else if (!email_regex.test($("#consumer_email").val())){
    $("#consumer_email").next().html("Invalid.").show('slow');
    ercount+=1;
  }
  else{
    $.ajax({
      type: "POST",
      async: false,
      url: "/users/check_email",
      data:{ email: $("#consumer_email").val()},
      dataType: "json",
      success:function(data){
        if(data == true){
         $("#consumer_email").next().html("Email already exist.").show('slow'); 
       }
     }
   });
  }

  if($('#consumer_contact_no').val() == ""){
    $('#consumer_contact_no').next().html("can't be blank.").show('slow');
    ercount+=1;
  }
  else if (!phone_regex.test($("#consumer_contact_no").val())){
    $("#consumer_contact_no").next().html("Invalid.(should contain 10 to 15 digits).").show('slow');
    ercount+=1;
  }  

  if($('#consumer_password').val() == ""){
    $('#consumer_password').next().html("can't be blank.").show('slow');
    ercount+=1;
  }
  else if (!check_initial_whitespace.test($("#consumer_password").val())){
    $("#consumer_password").next().html("Invalid.(should contain minimum 8 characters and shouldn't have leading space.)").show('slow');
    ercount+=1;
  }
  else if ($("#consumer_password").val() != $("#consumer_password_confirmation").val()) {
    $("#consumer_password_confirmation").next().html("Password and confirm password should be same.").show('slow');
    ercount+=1;
  }

  if(ercount == 0){
    return true;   
  }
  else{
    return false;
  }
  // alertify.error('end of submit');
});










	// ready block ends here
});
