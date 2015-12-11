ActiveAdmin.register PageContent do
  config.filters = false    #disable filters
  actions :all , :except => [:destroy,:new]  #hide link to "delete" and "add new"
 permit_params :page, :title, :content

  form do |f|
    f.inputs "Page Contant" do
      f.input :page, :input_html => { :disabled => true } 
      f.input :title
      f.input :content
    end
    f.actions
  end

end
