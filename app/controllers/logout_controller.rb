class LogoutController < ApplicationController
  def index
    session.delete(:facebook_id)
    redirect_to :root
  end
end
