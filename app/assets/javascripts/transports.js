$(document).ready(function(){
$('.datetimepicker').datetimepicker({
    // format:'Y-m-d H:i'
    closeOnDateSelect:true
});

//globel configration
$('.error').hide();

// onload in edit mode

// hide all other fields
$('.other_transport').hide();
$('[class^=input_transport_name_]').hide();
$('[id^=city_transfer_modes_]').hide();
$('[class^=input_transfer_mode_]').hide();
// $('[class^=time-of-onward_]').hide();

// input_transport MODE other option textbox
$("[class^=transport_mode_]").click(function(){
  transport_mode(this);
});

$("[class^=transport_mode_]:checked").each(function(){  
  transport_mode(this);
});

function transport_mode(obj){
  accodion_index = $(obj).data('accodion_index');
  div_id = $(obj).data('div_id');

  $('.'+'other_field_error_'+accodion_index).hide('slow');
  $('.'+'transport-mode_'+accodion_index).addClass('hide');

  if ($(obj).val() === 'No Transport' ){
    $('.time-of-onward_'+accodion_index).addClass('hide');
    $('[class^=time_of_onward_'+accodion_index+']').each(function(){
      $(this).prop("checked", false);
    });
  }
  else{
    $('.time-of-onward_'+accodion_index).removeClass('hide');
  }

  $('.'+div_id).removeClass('hide');

  if($(obj).val() == ''){
    $('#input_transport_mode_'+accodion_index).show('slow');
  }
  else{
    $('#input_transport_mode_'+accodion_index).hide('slow');
  }
}

// onload other field edit mode input_transport_mode_ done
$("[id^=input_transport_mode_]").each(function(){  
  accodion_index = $(this).attr('id').split('_');
  accodion_index = accodion_index[accodion_index.length-1];

  if ($(this).val() !== ""){
    $('.'+'transport-mode_'+accodion_index).addClass('hide');
    // $('.'+'time-of-onward_'+accodion_index).addClass('hide');
    $('#input_transport_mode_'+accodion_index).show();
    $('.transport_mode_'+accodion_index).prop("checked", true);
    // $('.transport-mode_'+accodion_index).hide();
    $(this).show();
  }
});

// for transport name...other field....edit

$("[class^=input_transport_name_]").each(function(){  
  accodion_index = $(this).attr('class').split('_');
  accodion_index = accodion_index[accodion_index.length-1]; // 1-1

  if ($(this).val() !== ""){
    $('.radio_'+accodion_index).prop("checked", true);
     $(this).show();
  }
});

// input_transport NAME other option textbox
$("[class^=radio_]").click(function(){
  $('[class^=input_transport_name_]').hide();
  // $('[class^=input_transport_name_]').val('').hide();
  
  transport_name_radio = $(this).attr('class').split('_');
  transport_name_radio = transport_name_radio[transport_name_radio.length-1]
  if($(this).data('other') == ''){
    $('.input_transport_name_'+transport_name_radio).show('slow');
  }
  else{
    $('.input_transport_name_'+transport_name_radio).hide('slow');
    $('.other_field_error_'+transport_name_radio).hide('slow');
  }

});

// TRANSFER MODE on load
$('[id^=city_transfer_]:checked').each(function(){
  index = $(this).data('index')
  if ($(this).val() === 'included'){
    $('#city_transfer_modes_'+index).show('slow');
  }
  else {
    $("#city_transfer_modes_"+index).hide('slow');
    // $(".transfer_modes_"+index).prop("checked", false);
  }
});

// TRANSFER MODE - show hide done
$('[id^=city_transfer_]').click(function(){
  index = $(this).data('index')
  if ($(this).val() === 'included'){
    $('#city_transfer_modes_'+index).show('slow');
  }
  else {
    $("#city_transfer_modes_"+index).hide('slow');
    // $(".transfer_modes_"+index).prop("checked", false);
  }
});

// transfer_modes_ on load other field

$("[class^=input_transfer_mode_]").each(function(){
  $('[class^=input_transfer_mode_]').hide();
  
  accodion_index = $(this).attr('class').split('_');
  accodion_index = accodion_index[accodion_index.length-1];
  // alert(accodion_index);
  if ($(this).val() !== ""){
    // alert('true');
    $('.transfer_modes_'+accodion_index).prop("checked", true);
     $(this).show();
  }

});

// transfer_modes other option textbox show hide
$("[class^=transfer_modes]").click(function(){
  transport_name_radio = $(this).attr('class').split('_');
  transport_name_radio = transport_name_radio[transport_name_radio.length-1]
  if($(this).data('other') == ''){
    $('.input_transfer_mode_'+transport_name_radio).show('slow');

  }
  else{
    $('.input_transfer_mode_'+transport_name_radio).hide('slow');
    $('.other_mode_field_error_'+transport_name_radio).hide('slow');
  }
});

// submit button validation
$(".save_tranport_btn").click(function(event){
  // event.preventDefault();
  $('.error').hide();
  is_valid = true;

  $("[class^=transport_mode_]:checked").each(function(){
    accodion_index = $(this).data('accodion_index');

    transport_name_radio = $(this).data('div_id').split('-');
    transport_name_radio = transport_name_radio[transport_name_radio.length-1]

      if ($(this).data('other') == ''){
        if($('#input_transport_mode_'+accodion_index).val() == ''){
          error_message = "Other field can't be blank."
          $(".other_field_error_"+accodion_index).html(error_message).show();
          is_valid = false;
        }
        $(this).val($('#input_transport_mode_'+accodion_index).val());
      }
      else if ($(this).val() === 'No Transport' ){
        // do nothing
      }
      else{
        if ($("[class^=radio_"+accodion_index+"-"+transport_name_radio+"]:checked").length == 0){
          error_message = "Please select atleast one."
          $(".error_"+accodion_index+"-"+transport_name_radio).html(error_message).show();
          is_valid = false;
          // need to toggle the accodion to errored accodion
          // $('#collapse_'+accodion_index).toggle();
        }
        else{
          $("[class^=radio_"+accodion_index+"-"+transport_name_radio+"]:checked").each(function(){
            if($(this).data('other') == ''){
              // blank other field error
              if($('.input_transport_name_'+accodion_index+'-'+transport_name_radio).val() == ''){
                $('.input_transport_name_'+accodion_index+'-'+transport_name_radio).show();
                error_message = "Other field can't be blank."
                $(".other_field_error_"+accodion_index+"-"+transport_name_radio).html(error_message).show();
                is_valid = false;
              }
              $(this).val($('.input_transport_name_'+accodion_index+'-'+transport_name_radio).val());
            }
          });
        }
        // date picker validation
          // if ($('.rdatetimepicker_'+accodion_index).val()===""){
          //   $('.time_field_error_'+accodion_index).html("Date can't be blank").show('slow');
          //   is_valid = false;
          // }
          // else{
          //   if (accodion_index !== 0){
          //     current_date_arr = $('.rdatetimepicker_'+accodion_index).val().split(" ");
          //     current_date_d = current_date_arr[0].split("/");
          //     current_date_t = current_date_arr[1].split(":");
          //     current_date = new Date(current_date_d[0],current_date_d[1]-1,current_date_d[2], current_date_t[0], current_date_t[1]);

          //     prev_date_arr = $('.rdatetimepicker_'+(accodion_index-1)).val().split(" ");
          //     if (prev_date_arr !=''){
          //       prev_date_d = prev_date_arr[0].split("/");
          //       prev_date_t = prev_date_arr[1].split(":");
          //       prev_date = new Date(prev_date_d[0],prev_date_d[1]-1,prev_date_d[2], prev_date_t[0], prev_date_t[1]);
          //       if (prev_date > current_date){
          //         $('.time_field_error_'+accodion_index).html("Dates should be in increasing order.").show('slow');
          //         is_valid = false;
          //       }
          //     }
          //   }
          // }

      }

      // time of onward checkbox validation
      if ($("[class^=time_of_onward_"+accodion_index+"]:checked").length === 0 && $(this).val() !== 'No Transport' ){
        error_message = "Please select atleast one."
        $(".time_field_error_"+accodion_index).html(error_message).show();
        is_valid = false;
      }

      if ($("#city_transfer_"+accodion_index).is(':checked')){
        if($("[class^=transfer_modes_"+accodion_index+"]:checked").length == 0){
          error_message = "Please select atleast one."
          $(".error_"+accodion_index).html(error_message).show();
          is_valid = false;
        }
        else{
          $("[class^=transfer_modes_"+accodion_index+"]:checked").each(function(){
           if($(this).data('other') == ''){
              // blank other field error
              if($('.input_transfer_mode_'+accodion_index).val() == ''){
                error_message = "Other field can't be blank."
                $(".other_mode_field_error_"+accodion_index).html(error_message).show();
                is_valid = false;
              }
              $(this).val($('.input_transfer_mode_'+accodion_index).val());
            }
            // alert("------------inner loop2- "+$(this).val());
          });
        }
      }
    });

if (is_valid){
  return ;

}
else{
 alertify.alert('Please fill the required field of each tab!')
  return false;
}

});


// ready block ends here
});

