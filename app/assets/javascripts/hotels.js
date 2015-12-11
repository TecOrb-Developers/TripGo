$(document).ready(function(){

	$('.submit_hotel').click(function(e){
    var check_integer = /^[0-9]*$/;
	$(".error_hotel").hide();
    $(".error_hotel").html('');
    var newjobErr = {};

    var cities = $("[id^='package_hotels_attributes_']:first>option").map(function() { return $(this).val(); });
	    if ($('[id^=package_hotels_attributes_][id*=_city]:visible').length < cities.length ){
       newjobErr['jnme'] = '<li>At least one hotel is required for each city so, Please click on add hotel!</li>';         
          alertify.alert('At least one hotel is required for each city so, Please click on add hotel !')
    }


    else{
    selected_cities = $("[id^='package_hotels_attributes_'][id*='_city']").map(function() { return $(this).val(); });
    rest_cities = $(cities).not(unique(selected_cities)).get();
    	if (rest_cities.length > 0){
				newjobErr['jnme'] = "<li>Please add hotel for </li>";
			    alertify.alert('Please select the cities '+rest_cities.join()+' to add hotel.')
			}
    }

    $("[id^='package_hotels_attributes_'][id*='_hotel_name']").each(function(){
    	id  = $(this).attr('id');
    	$(this).parent().addClass(id);
    	if ($(this).val() == "") {
    		newjobErr['jnme'] = "<li>can't be blank </li>";
    		$("."+id+" span.error_hotel").addClass(id +'_errfield').html("can't be blank");
    		
    	}
    });

    $("[id^='package_hotels_attributes_'][id*='_number_of_days']").each(function(){
      id  = $(this).attr('id');
      $(this).parent().addClass(id);
      if (($(this).val() == "")||(!check_integer.test($(this).val()))) {
        newjobErr['jnme'] = "<li>number of days should be integer </li>";
        $("."+id+" span.error_hotel").addClass(id +'_errfield').html("please enter the valid input");
        
      }
    });

    $("[id^='package_hotels_attributes_'][id*='_hotel_address']").each(function(){
    	id  = $(this).attr('id');
    	$(this).parent().addClass(id);
    	if ($(this).val() == "") {
    		newjobErr['jnme'] = "<li>can't be blank </li>";
    		$("."+id+" span.error_hotel").addClass(id +'_errfield').html("can't be blank");
    		
    	}
    });
    

    $("[id^='package_hotels_attributes_'][id*='_room_type']").each(function(){
        id  = $(this).attr('id');
        $(this).parent().addClass(id);
        if ($(this).val() == "") {
            newjobErr['jnme'] = "<li>can't be blank </li>";
            $("."+id+" span.error_hotel").addClass(id +'_errfield').html("can't be blank");
            
        }
    });
    
    if ($('[id^=package_hotels_attributes_][id*=_pictures_attributes_]:visible').length == 0 ){
       newjobErr['jnme'] = '<li>at least one picture necessary for the hotel</li>';         
       alertify.alert("at least one picture necessary for each hotel")
    }

    $("[id^='package_hotels_attributes_'][id*='_pictures_attributes_']:visible").each(function(){


        id  = $(this).attr('id');
        $(this).parent().addClass(id);



    if($(this).attr('type') == 'file'){
        if ($(this).data('img_present') == false){
          fileExtension = ['jpg', 'jpeg', 'gif', 'png'];
          if ($.inArray($(this).val().split('.').pop().toLowerCase(), fileExtension) == -1) {
             newjobErr['jnme'] = "<li>please select 'jpg', 'jpeg', 'gif', 'png'</li>";         
              $("."+id+" span.error_hotel").addClass(id +'_errfield').html("please select 'jpg', 'jpeg', 'gif', 'png'");
          }
        } 
      }
      else{
        if($(this).val() == ''){
          newjobErr['jnme'] = "<li>please fill the field for each field </li>";         
              $("."+id+" span.error_hotel").addClass(id +'_errfield').html("please fill the field");
        }
      }

    });


    var count = 0;
        $.each(newjobErr, function(key, value) { 
          count = count + 1;      
        });         
        if(count >= 1) {
                        $(".error_hotel").show();
                        alertify.alert("There are some validation errors in the form. Please correct it and then submit.")        
                        return false;   
                       }
                       


	});
	

function unique(list) {
  var result = [];
  $.each(list, function(i, e) {
    if ($.inArray(e, result) == -1) result.push(e);
  });
  return result;
}

});



