class AuthController < ApplicationController
  def login_signup
    client = AuthController.get_facebook_oauth_client(root_url)
    redirect_to client.authorize_url
  end

  class << self
    def get_facebook_oauth_client(root_url)
      FacebookOAuth::Client.new(
        :application_id => ENV["FB_APP_ID"],
        :application_secret => ENV["FB_APP_SECRET"],
        :callback => root_url + "users/new"
      )
    end
  end
end
