ActiveAdmin.register User do
  menu :priority => 2
    config.filters = false    #disable filters
    actions :all , :except => [:new,:edit]  #hide link to "delete" and "add new"
   # permit_params :name,:email,:contact_no,:role,:approved
   index do
    selectable_column
    id_column
    column " User Name " do |resource|
      resource.name 
    end
    column " Email " do |resource|
      resource.email
    end
    column " Mobile " do |resource|
      resource.contact_no
    end
    column " Logged in through " do |resource|

    end
    column " No. of enqueries " do |resource|

    end
    column "Actions" do |resource|
      links = ''.html_safe
      links += link_to 'View / ', admin_user_path(resource)

      a do
        if resource.approved == false
          links += link_to 'Approve / ', approve_user_path(resource),:data => { :confirm => 'Are you sure, you want to approve this user?' }
        else
          links += link_to 'Disapprove / ', approve_user_path(resource),:data => { :confirm => 'Are you sure, you want to disapprove this user?' }
        end
        links += link_to 'Delete', admin_user_path(resource), method: :delete,:data => { :confirm => 'Are you sure, you want to delete this user?' }
      end
      links
    end
    column " Status " do |resource|
     resource.approved? ? status_tag( "Approved", :ok ) : status_tag( "Disapproved" )
   end
 end

 show do
  table do
    tr do
      th { 'user id' }
      td { user.id }
    end
    tr do
      th { 'Name' }
      td { user.name }
    end  
    tr do
      th { 'Email' }
      td { user.email }
    end
    tr do
      th { 'Role' }
      td { user.role }
    end              
    tr do
      th { 'contact_no' }
      td { user.contact_no }
    end
    tr do
      th { 'Approved?' }
      td {  user.approved? ? status_tag( "Approved", :ok ) : status_tag( "Disapproved" ) }
    end
  end 
end


end
