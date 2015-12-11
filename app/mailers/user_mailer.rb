class UserMailer < ApplicationMailer
	def send_crms_with_attachment(email, file_path)
		@email = email
		attachments["crms.csv"] = File.read(file_path)
		mail(:to => email, :subject => "CRM Report ")
	end

	def complaint(params)
		@detail = params
		@email = 'utkarsh.dwivedi@mobiloitte.com'
		mail(:to => @email, :subject => params[:subject])

	def send_offer_to_users(emails,offer)
		@offer = offer
		mail(:to => emails, :subject => "Offer for you")
	end
end
