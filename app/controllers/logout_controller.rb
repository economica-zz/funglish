class LogoutController < ApplicationController
  def index
    session.delete(:facebook_id)
    flash[:email_address_confirmation] = nil
    redirect_to :root
  end
end
