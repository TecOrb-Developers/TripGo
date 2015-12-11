ActiveAdmin.register_page "Send mail" do
  menu :priority => 4
 
  config.clear_action_items!   # this will prevent the 'new button' showing up
 
        content do
         render :partial => 'form'
        end

end