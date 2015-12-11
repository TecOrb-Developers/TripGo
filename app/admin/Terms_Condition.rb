ActiveAdmin.register_page "Terms & Conditions" do

  menu parent: "Page Contents"
  content do
   form :action => terms_conditions_path do |f|
      f.input :page , :input_html => { :value => 4 },:collection => { "Display" => "id" }
    # f.input :code, :input_html => { :value => 4 }, as: :hidden
      f.input :title => :title,:collection => { "Display" => "id" }
      f.input :content => :content ,:collection => { "Display" => "id" }
      f.button
  end

  end

end