ActiveAdmin.register_page "Terms & Conditions" do

  menu parent: "Page Contents"
 
  content do
         render :partial => 'terms'
  end

end