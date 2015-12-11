ActiveAdmin.register Package do

 permit_params :user_id,:itinerary_name,:holidays,:holiday_types,:price_per_person,:room_sharing,:extra_room,:extra_cost,:package_duration,:tag_as_weakend,:start_date,:end_date,:approved,:included,:recommended_side,:recommended_center
 config.filters = false    #disable filters
 actions :all , :except => [:new ,:edit]  #hide link to "delete" and "add new"

 index do
  selectable_column
  id_column
  column " ID " do |resource|
    resource.id   
  end
  column " Destination " do |resource|
    resource.cities.last.city_name
  end
  column " Posted By " do |resource|
    resource.user.name
  end
  column " Validity " do |resource|
    "#{resource.start_date} to #{resource.end_date}"
  end
  column " Inclusions " do |resource|
    resource.included
  end
  column "Inventory" do |resource|
    
  end
  column "Actions" do |resource|
    links = ''.html_safe
    links += link_to 'View / ', admin_package_path(resource)
    
    a do
      if resource.status?
        links += link_to 'Disapprove / ', approve_package_path(resource),:data => { :confirm => 'Are you sure, you want to disapprove this package?' }
      else
       links += link_to 'Approve / ', approve_package_path(resource),:data => { :confirm => 'Are you sure, you want to approve this package?' }

     end
     links += link_to 'Delete', admin_package_path(resource), method: :delete,:data => { :confirm => 'Are you sure, you want to delete this package?' }
   end
   links
 end
#  column :status do |package|
#   if package.status
#     status_tag('Active', :ok)
#   else
#     status_tag("Inactive", :blue)
#   end
# end

 
 column "Status" do |resource|
   if resource.status == "active"
    "Active"
  else
    "Inactive"
  end
end

column "Recommended side" do |resource|
  check_box_tag "recommended_side",resource.recommended_side, resource.recommended_side,:class =>"package-imagee", :data=>{:"package-id"=> resource.id, :"recommended-for" => "side"}
       #render :partial => "packages/recommended_side", :locals => {:package => resource.id }
     end

     column "Recommended center" do |resource|
       check_box_tag "recommended_side",resource.recommended_center, resource.recommended_center,:class =>"package-imagee", :data=>{:"package-id"=> resource.id, :"recommended-for" => "center"}
     end

   end

   show do
    table do
      tr do
        td { 'Package id' }
        td {  resource.id   }
      end
      tr do
        td { ' Destination' }
        td { resource.cities.last.city_name }
      end  
      tr do
        td { 'Posted By' }
        td {resource.user.name}
      end
      tr do
        td { ' Validity' }
        td {  "#{resource.start_date} to #{resource.end_date}" }
      end              
      tr do
        td { 'Inclusions' }
        td { }
      end
      tr do
        td { 'Inventory' }
        td { }
      end  
      
    end 
    
  end



end


