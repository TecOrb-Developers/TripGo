class PageContentsController < ApplicationController

	
	def terms_conditions
	   content = PageContent.find(4)
	   title = params[:terms][:title]
	   text = params[:terms][:content]
	   content.update_attributes(:title => title,:content => text)
	   redirect_to admin_page_contents_path			
	end

	def about_us
	   content = PageContent.find(1)
	   title = params[:aboutus][:title]
	   text = params[:aboutus][:content]
	   content.update_attributes(:title => title,:content => text)
	   redirect_to admin_page_contents_path	
	end

	def team
	   content = PageContent.find(5)
	   title = params[:team][:title]
	   text = params[:team][:content]
	   content.update_attributes(:title => title,:content => text)
	   redirect_to admin_page_contents_path		
	end

	def policy
	  content = PageContent.find(3)
	   title = params[:policy][:title]
	   text = params[:policy][:content]
	   content.update_attributes(:title => title,:content => text)
	   redirect_to admin_page_contents_path		
	end

	def contact
      content = PageContent.find(2)
	   title = params[:contact][:title]
	   text = params[:contact][:content]
	   content.update_attributes(:title => title,:content => text)
	   redirect_to admin_page_contents_path		
	end

end
