ActiveAdmin.register_page "privacy & policy" do

  menu parent: "Page Contents"
  
  content do
         render :partial => 'policy'
  end
end