ActiveAdmin.register_page "Partner List" do
  menu :priority => 2
    
   
content do
		partners = User.where("role = ?","supplier")
   	table do
	   	tr do
	   		th { 'Name' }
	   	    th { 'Email' }
	   	    th { 'Phone No.' }
	   	    th { 'Website' }
	   	    th { 'IATA Ref.' }
	   	    th { 'Status' }
	   	    th { 'Action' }
		end	
    partners.each do |user| 
	    tr do
	      td { user.name }
	      td { user.email }
	      td { user.contact_no }
	      td { user.profile.website_name }
	      td { "IATA" }
	      td {  user.approved? ? status_tag( "Approved", :ok ) : status_tag( "Disapproved" ) }      
 	  	  td :class=>"" do 
             a  link_to 'View /', admin_user_path(user) 
             l = user.approved? ? 'Disapprove' : 'Approve'
           	 a  link_to l, approve_partner_path(user),:data => { :confirm => "Are you sure, you want to #{l} this user?" }
          end
	    end
	end
  end 
end
end
