require 'open-uri'
class SocialAuthenticationsController < ApplicationController 
  
 def social_login
  omni = request.env["omniauth.auth"]
  authentication = User.find_by_provider_and_provider_id(omni.provider,omni.uid)
  if authentication
    authentication.update_attributes(:token => omni['credentials']['token'],:token_expire_at => Time.at(omni['credentials']['expires_at']))
    sign_in authentication
    sign_in_and_redirect authentication,:notice =>"successfully logged in!!"
  elsif user = User.find_by(email: omni['info'].email)
    user.update_attributes(provider: omni.provider, 
      provider_id: omni.uid,:token => omni['credentials']['token'],:token_expire_at => Time.at(omni['credentials']['expires_at']))
    sign_in_and_redirect user,:notice =>"successfully logged in!!"
  else
    user = User.new
    user.password = Devise.friendly_token[0,11]
    user.email = omni['info'].email
    user.name = omni['info'].name
    user.role = 'consumer'
    user.provider = omni.provider
    user.provider_id = omni.uid
    user.token = omni['credentials']['token']
    user.token_expire_at = Time.at(omni['credentials']['expires_at']) 
    if user.save
      sign_in_and_redirect user,:notice => " Thank you for signing up, You are successfully Logged in!!"
    else
      session[:omniauth] = omni.except('extra')
      redirect_to :back
    end
  end
end


def failure
 raise OmniAuth::Strategies::Facebook::NoAuthorizationCodeError 
end 
end
