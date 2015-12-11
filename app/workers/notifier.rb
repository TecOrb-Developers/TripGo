
class Notifier
include Sidekiq::Worker
  
  def perform(reciever_emails,offer)
    UserMailer.send_offer_to_users(reciever_emails,offer).deliver
  end
end

