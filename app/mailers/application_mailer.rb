class ApplicationMailer < ActionMailer::Base
  default from: "no-reply@tripshelf.com"
  layout 'mailer'
end
