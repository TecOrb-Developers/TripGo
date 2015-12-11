Rails.application.config.middleware.use OmniAuth::Builder do
  
  provider :facebook, '1584030675170280', '5b7420b2915d1469f850904f888b49ef',:scope => "offline_access,manage_pages, publish_stream, publish_actions,email,user_birthday"
 
  provider :google_oauth2, '495594630650-043mmuugfm0vm2501f7gebgebu0tnlf7.apps.googleusercontent.com', '056rdeHH1_bY2kUfoCFg0Qrw',:scope => "email, profile"
  
end