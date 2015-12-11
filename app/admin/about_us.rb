ActiveAdmin.register_page "About Us" do

  menu parent: "Page Contents"
       content do
         render :partial => 'about'
        end
end