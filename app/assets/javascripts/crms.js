$(document).ready(function(){
// $(document).ajaxStart($.blockUI).ajaxStop($.unblockUI);
// $(document).ajaxStop($.unblockUI); 
// $.blockUI({ message: '<img src="http://www.accufinance.com/images/busy.gif"/>' });

// globel confi
	$(".error_send_to_email").hide();

// filter btn
	$('#crms_filter_submit_btn').click(function(){
		filter_against = $('#crms_filter_against').val();
		filter_query = $('#crms_filter_query').val();

		$.ajax({
			type: "GEt",
			url: "/crms-filter",
			data:{ filter_against: filter_against, filter_query: filter_query, page: 1},
			dataType: "script",
			success:function(data){         
				alertify.success('Filteration completed.');                 
			},
			error: function() {
				alertify.error('Somethind went wrong. Please try again.');    
			}
		});
	});

// filter reset btn
	$("#crms_filter_reset_btn").click(function(){
		$('#crms_filter_query').val('');
		alertify.success('Reset field completed.');    
	});

// search on enter
$('#crms_filter_query').bind('keypress', function(e) {
	if(e.keyCode==13){
		$('#crms_filter_submit_btn').trigger('click');
		return false;
	}
});

// mark as action
$('.mark-as-dropdown').click(function(e){
	e.preventDefault();
	chkArray = [];
	mark_as = $(this).text();
	filter_against = $('#crms_filter_against').val();
	filter_query = $('#crms_filter_query').val();

	if ($('.mark-as-value').text() == $(this).text()){
		alertify.error("Already selected.");
	}
	else{
		$('.mark-as-value').html(mark_as);			
	}

	$("#crms_container input:checked").each(function() {
		chkArray.push($(this).val());
	});

	if (chkArray.length != 0){
		alertify.confirm("Are you sure to update selected record's status to ' "+mark_as+ "'?", function(event){
			if (event){
				$.ajax({
					type: "POST",
					url: "/crms-mark-as",
					data:{ crms_ids: chkArray, mark_as: mark_as, filter_against: filter_against, filter_query: filter_query},
					dataType: "script",
					success:function(data){
							$('.mark-as-value').text("Mark As");                
		        },
		        error: function() {
		        	alertify.error('Something went wrong. Please try again..');    
		        }
		      });
			}
			else{
				$('.mark-as-value').html(mark_as);
			}
		});
	}
	else{
		$('.mark-as-value').text("Mark As");
		alertify.error("Please select atleast one of the checkbox");
	}

});

// export csv
$('.export_csv').on('click', function(e){
	chkArray = [];
	$("#crms_container input:checked").each(function() {
		chkArray.push($(this).val());
	});
	if (chkArray.length != 0){ 
		return true;
	}
	else{
		alertify.error("Please select atleast one of the checkbox");
		return false;
	}
});

// delete-selected 
// NOTE: need work with pagination needed
$('.delete-selected').on('click', function(e){
	e.preventDefault();
	chkArray = [];
	filter_against = $('#crms_filter_against').val();
	filter_query = $('#crms_filter_query').val();

	$("#crms_container input:checked").each(function() {
		chkArray.push($(this).val());
	});

	if (chkArray.length != 0){
		alertify.confirm("Are you sure to delete selected records ?", function(event){
			if (event){
				$.ajax({
					type: "DELETE",
					url: "/delete-selected",
					data:{ crms_ids: chkArray, filter_against: filter_against, filter_query: filter_query},
					dataType: "script",
					success:function(data){
						
					},
					error: function() {
						alertify.error('Something went wrong. Please try again.');    
					}
				});
			}
		});
	}
	else{
		alertify.error("Please select atleast one of the checkbox");
	}

});

// send-to
$('.send-to').click(function(){
	$('#send_to_email').val('');
	$(".error_send_to_email").hide("slow");
});

// send email button /csv-as-email
$('#crms_send_email_btn').on("click", function(e){
	e.preventDefault();
	email_regex=/^[0-9a-zA-Z_.]+@[a-zA-Z]+?\.[a-zA-Z]{2,3}$/;
	email = $('#send_to_email').val();
	chkArray = [];
	$("#crms_container input:checked").each(function() {
		chkArray.push($(this).val());
	});

	if (email.match(email_regex)){
		$(".error_send_to_email").hide("slow");
		$('#send-to').modal('toggle');
		$.ajax({
			type: "POST",
			url: "/csv-as-email",
			data:{ crms_ids: chkArray, email: email},
			dataType: "json",
			success:function(data){
				alertify.success('Mail has been sent.');
			},
			error: function() {
				alertify.error('Something went wrong. Please try again..');
			}
		});
	}
	else{
		$(".error_send_to_email").show("slow");
	}
});

// crms-status0
$('.crms-status-otn').click(function(e){
	e.preventDefault();
	crm_id = $(this).parent().parent().parent().parent().parent().find('#crms_ids_').val();
	status=$(this).text();
	current_obj = this
	

	$.ajax({
			type: "POST",
			url: "/status-update",
			data:{ id: crm_id, status: status },
			dataType: "json",
			success:function(data){
				$(current_obj).parent().parent().parent().find('.crms-status').html(status);
				alertify.success('Status updated Successfully.');
			},
			error: function() {
				alertify.error('Something went wrong. Please try again..');
			}
		});
});

$('.assigned_to').change(function(){
		var email_regex=/^[0-9a-zA-Z_.]+@[a-zA-Z]+?\.[a-zA-Z]{2,3}$/;
		email = $(this).val();
		if (!email_regex.test(email)){
			alertify.error('Please enter a valid email address')
		}
		else {
		crm_id  = $(this).parent().parent().find('#crms_ids_').val();
		$.ajax({
					type: "post",
					url: "/assigned_to",
					data:{ crm_id: crm_id,  email: email},
					dataType: "json",
					success:function(data){
						alertify.error('Successfully assigned..');
					},
					error: function() {
						alertify.error('Something went wrong. Please try again..');    
					}
				});
		}

	});


// ready block ends
});
