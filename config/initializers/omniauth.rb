OmniAuth.config.logger = Rails.logger

#OmniAuth.config.full_host = "http://localhost:3000"

#Rails.application.config.middleware.use OmniAuth::Builder do
  # If you don't need a refresh token -- if you're only using Google for account
  # creation/auth and don't need google services -- set the access_type to 'online'.
  # Also, set the approval prompt to an empty string, since otherwise it will be set
  # to 'force', which makes users manually approve to the Oauth every time they 
  # log in.
  # See http://googleappsdeveloper.blogspot.com/2011/10/upcoming-changes-to-oauth-20-endpoint.html
#  provider :google_oauth2, '939318209513.apps.googleusercontent.com', 'GRZJM66tGXRIAKJq87ZdHIP9', {access_type: "offline", approval_prompt: ""}#, :provider_ignores_state => true
#end

#ENV['GOOGLE_KEY'], ENV['GOOGLE_SECRET']

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :developer #unless Rails.env.production?
  provider :google_oauth2, '494262113350-uvshdl4n59fj9df70jc569dnntnu8m6g.apps.googleusercontent.com', 'dAqQHBOSqTa3v_zRjE-ucOVC', {    
    :scope => 'email,profile'
  } 
end