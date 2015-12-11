$(document).ready(function(){

$('.submit_inclusion').click(function(){
 	
	$(".error").hide();
    $(".error").html('');
    var newjobErr = {};

    if ($('#inclusion_conditions').val() == '') {
          newjobErr['jnme'] = '<li>itinerary name can not be blank</li>';         
          $(".inclusion_conditions_field").html("can't be blank");
        }

    if ($('#inclusion_cancallation_policy').val() == '') {
          newjobErr['jnme'] = '<li>itinerary name can not be blank</li>';         
          $(".inclusion_cancallation_policy_field").html("can't be blank");
        }

    // if ($('#inclusion_extra').val() == '') {
    //       newjobErr['jnme'] = '<li>itinerary name can not be blank</li>';         
    //       $(".inclusion_extra_field").html("can't be blank");
    //     }

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