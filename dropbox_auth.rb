# Install this the SDK with "gem install dropbox-sdk"
require 'dropbox_sdk'

# Get your app key and secret from the Dropbox developer website
APP_KEY = '0g1aq69565x7w7n'
APP_SECRET = 'pxan3j3w501673k'

flow = DropboxOAuth2FlowNoRedirect.new(APP_KEY, APP_SECRET)
session = DropboxSession.new(APP_KEY, APP_SECRET)

authorize_url = flow.start()

# Have the user sign in and authorize this app
puts '1. Go to: ' + authorize_url
puts '2. Click "Allow" (you might have to log in first)'
puts '3. Copy the authorization code'
print 'Enter the authorization code here: '
code = gets.strip

# This will fail if the user gave us an invalid authorization code
access_token, user_id = flow.finish(code)

client = DropboxClient.new(access_token)
#puts "linked account:", client.account_info.inspect
puts "app key:", APP_KEY
puts "app secret", APP_SECRET
puts "request token key:", session.get_request_token.key
puts "request token secret:", session.get_request_token.secret
puts "access token key:", code
puts "access token secret:", access_token

ENV["DROPBOX_APP_KEY"] = APP_KEY
ENV["DROPBOX_APP_SECRET"] = APP_SECRET
ENV["DROPBOX_REQUEST_TOKEN_KEY"] = session.get_request_token.key
ENV["DROPBOX_REQUEST_TOKEN_SECRET"] = session.get_request_token.secret
ENV["DROPBOX_AUTH_TOKEN_KEY"] = code
ENV["DROPBOX_AUTH_TOKEN_SECRET"] = access_token