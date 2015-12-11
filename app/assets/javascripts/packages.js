  $(document).ready(function(){
var check_integer = /^[0-9]*$/;
//$('#package_start_date').datepicker({dateFormat: 'dd-mm-yy'});
// $('#package_end_date').datepicker({dateFormat: 'dd-mm-yy'});


 // ($( "#label_for_city:visible:first" )).text('Origin city');

  
  
$( "[id ^=package_cities_attributes_]" ).autocomplete({
      source: availableTags
  });  

$(document).on('nested:fieldAdded:cities', function(event){
  var field = event.field; 
   // field.find('#label_for_city:visible:first').text('Origin city');
   field.find('[id ^=package_cities_attributes_]').autocomplete({
                    source: availableTags
                  });  
});

$('#place_from').autocomplete({source: availableTags});  

$('#package_start_date').datepicker({dateFormat: 'dd-mm-yy',
  onSelect:function( selectedDate ) {
    start = $("#package_start_date").val();
    today = $(this).data('time');
    if(start < today){
      $("#package_start_date").val("");
      alertify.alert("please select date greater than or equal to today");
    }
  }
});

$('#package_end_date').datepicker({dateFormat: 'dd-mm-yy',
  onSelect:function( selectedDate ) {
    start = $("#package_start_date").val();
    array_start_date = start.split("-");
    var s_date = new Date(array_start_date[2],array_start_date[1]-1,array_start_date[0]);
    end = $(this).val();  
    array_end_date = end.split("-");
    var e_date = new Date(array_end_date[2],array_end_date[1]-1,array_end_date[0]);
    if ((start == "")) {
      alertify.alert("Please select start date first");
      $(this).val('');   
    }
    else if ((end == "")||(s_date > e_date))
    {
      alertify.alert("End date should be greater than Start date");
      $(this).val('');
    }
  }
});


// $("#package_start_date").datepicker({dateFormat: 'dd-mm-yy',
//     onSelect:function( selectedDate ) {

//         start = $("#package_start_date").val();
//         today = $("#package_start_date").data('time');
//         if ($("#package_package_duration").val()== ""){
//         	$("#package_start_date").val("");
//         	alertify.alert('Please select the package duration first');
//         }

//         else if (start < today){
//         	$("#package_start_date").val("");
//         	alertify.alert("please select date greater than or equal to today");
//         }
//         else{
//         	array_duration = $("#package_package_duration").val().split(" ");
//         	days = array_duration[2];
//         	array_date = start.split("-");
//         	var date = new Date(array_date[2],array_date[1]-1,array_date[0]);
//         	end_date = addDays(date, parseInt(days))

//         	$('#package_end_date').val(end_date.getDate()+"-"+(end_date.getMonth()+1)+"-"+end_date.getFullYear());

//         }

// }
// });



// get input other field 
$('#get_input').hide();
$( '[id^=package_room_sharing]').click(function(){
	if ($(this).val() == ''){
		$('#get_input').show('slow');
	}
	else{
    $('#get_input').val('').hide('slow');
		$('.get_input_field').hide('slow');
	}
});

if ($('#get_input').val() != ""){
  $('#package_room_sharing_').prop('checked', true);
  $('#get_input').show();
}

//==============================
$('.submit_package').click(function(e){
	
	var float_regex= /^[1-9][0-9]*$/;
  var checkstring = /^(?!\s)([a-zA-Z ]){3,15}$/;
	$(".error").hide();
  $(".error").html('');
  var newjobErr = {};


  if ($('[id ^=package_cities_attributes_]:visible').length < 2 ){
    newjobErr['jnme'] = '<li>At least two cities are needed</li>';         
    $(".add_city_field").html("At least two cities are needed");
  }

  $('[id ^=package_cities_attributes_]:visible').each(function(){
    id  = $(this).attr('id');
        $(this).parent().addClass(id);
   if (($(this).val() == "") || (!checkstring.test($(this).val()))){
    newjobErr['jnme'] = '<li>please fill the valid input</li>';         
    $("."+id+" span.city_field").html("please fill the valid input");
  }
});

  if (($('#package_itinerary_name').val() === '' && $('#package_itinerary_name').val().length < 1 || $('#package_itinerary_name').val().length >150)){
     newjobErr['jnme'] = '<li>valid range is from 0 to 150 characters</li>';         
    $(".package_itinerary_field").html("Please fill the field (within 0-150 charachers)");
  } 
  // else 
  //   if (!checkstring.test($('#package_itinerary_name').val())) {
  //   newjobErr['jnme'] = '<li>please fill a valid input</li>';         
  //   $(".package_itinerary_field").html("please fill a valid input");
  // }


  if ($('.holydays_checks').find('.holiday:checked').length == 0 ) {
    newjobErr['jnme'] = '<li>please select at least one</li>';         
    $(".holidays_field").html("please select at least one");
  }

  if ($('.holyday_types_checks').find('.holiday_types:checked').length == 0 ) {
    newjobErr['jnme'] = '<li>please select at least one</li>';         
    $(".holiday_types_field").html("please select at least one");
  }


  if (!float_regex.test(parseFloat($('#package_price_per_person').val()))) {
    newjobErr['jnme'] = '<li>must be graeter than or equal to 1 </li>';         
    $(".price_per_person_field").html("must be graeter than or equal to 1");
  }

  if (($('[id^=package_room_sharing]:checked').val()== "") && ($('#get_input').val() == "")){
   newjobErr['jnme'] = '<li>please specify </li>';         
   $(".get_input_field").html("please specify");
 }

//  if($("#package_package_duration").val()== "") {
//   newjobErr['jnme'] = '<li>can not be blank</li>';         
//   $(".package_duration_field").html("can't be blank");
// }

if ($(".package_duration_night").val() == '' || $(".package_duration_day").val() == ''){
  newjobErr['jnme'] = '<li>can not be blank</li>';
  $(".package_duration_field").html("can't be blank");
}
else if (!check_integer.test($('.package_duration_night').val()) || !check_integer.test($('.package_duration_day').val())){
  newjobErr['jnme'] = '<li>should contain numeric only</li>';
  $(".package_duration_field").html("should contain numeric only");
}
else{
  $(".package_duration_day").val(parseInt($(".package_duration_night").val()) + 1);
  value = $(".package_duration_night").val() +' Nights '+ $(".package_duration_day").val() + ' Days'
  $("#package_package_duration").val(value);
}


if($("#package_start_date").val()== "") {
  newjobErr['jnme'] = '<li>can not be blank</li>';         
  $(".start_date_field").html("can't be blank");
}


if ($('[id ^=package_pictures_attributes_]:visible').length < 1 ){
  newjobErr['jnme'] = '<li>at least one image is needed</li>';         
  $(".add_picture_field").html("at least one image is needed");
}

  $('[id ^=package_pictures_attributes_]:visible').each(function(){
    id  = $(this).attr('id');

    $(this).parent().addClass(id);
    if($(this).attr('type') == 'file'){
      if ($(this).data('img_present') == false){
        fileExtension = ['jpg', 'jpeg', 'gif', 'png'];
        if ($.inArray($(this).val().split('.').pop().toLowerCase(), fileExtension) == -1) {
         newjobErr['jnme'] = "<li>please select 'jpg', 'jpeg', 'gif', 'png' </li>";         
         $("."+id+" span.pictures_field").html("Please select ("+fileExtension+")");
       }
     } 
   }
   else{
    if($(this).val() == ''){
      newjobErr['jnme'] = "<li>please fill the field  </li>";         
      $("."+id+" span.pictures_field").html("please fill the field ");
    }
  }
});

// if ($(".package_duration_night").val() == ''){
//   newjobErr['jnme'] = '<li>can not be blank</li>';
//   $(".package_duration_field").html("can't be blank");
// }
// else if (!check_integer.test($('.package_duration_night').val()) || !check_integer.test($('.package_duration_day').val())){
//   newjobErr['jnme'] = '<li>should contain numeric only</li>';
//   $(".package_duration_field").html("should contain numeric only");
// }
// else{
//   $(".package_duration_day").val(parseInt($(".package_duration_night").val()) + 1);
//   value = $(".package_duration_night").val() +' Nights '+ $(".package_duration_day").val() + ' Days'
//   $("#package_package_duration").val(value);
// }

var count = 0;
$.each(newjobErr, function(key, value) { 
  count = count + 1;      
});         
if(count >= 1) {
  $(".error").show();  
  alertify.alert("There are some validation errors in the form. Please correct it and then submit.")          
  return false;   
}
else
{
  $('.other_room_share').val($('#get_input').val());
} 

});

var _URL = window.URL || window.webkitURL;
$(document).on('change', '[id ^=package_pictures_attributes_]:visible', function(e){
  current_id = $(this).attr('id');
    var file, img;
    if ((file = this.files[0])) {
        img = new Image();
        img.onload = function() {
          if (this.width < 900 || this.height < 550){
            alertify.success("Please choose image greater than (900*550) in dimention !")
            $('#'+current_id).wrap('<form>').parent('form').trigger('reset');
            $('#'+current_id).unwrap();
          }
                    };
        img.onerror = function() {
            alertify.error( "not a valid file: " + file.type);
            $('#'+current_id).wrap('<form>').parent('form').trigger('reset');
            $('#'+current_id).unwrap();
        };
         img.src = _URL.createObjectURL(file);
    }
});



$("#nights").change(function(){
  if ($(this).val() =='' ){
    $(".package_duration_field").html("can't be blank");
    $(".package_duration_field").show("slow");
  }
  else if (!check_integer.test($('.package_duration_night').val()) ) {
    $(".package_duration_field").html("should contain numeric only");
    $(".package_duration_field").show("slow");
  }
  else{
    $(".package_duration_day").val(parseInt($(".package_duration_night").val()) + 1);
    $(".package_duration_field").hide("slow");
  }

});

$('.edit_inventory').change(function(){
    inventory = $(this).val();
    p_id = $(this).data('p-id');
    $.ajax({
          type: "post",
          url: "/inventory",
          data:{ package_id: p_id,  inventory: inventory},
          dataType: "json",
          success:function(data){
            alertify.success('Successfully updated..');
          },
          error: function() {
            alertify.error('Something went wrong. Please try again..');    
          }
        });
    

  });

});

