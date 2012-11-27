class ApplicationController < ActionController::Base
  http_basic_authenticate_with :name => "aaa", :password => "000" if ENV["IS_HTTP_BASIC_AUTH_NEED"] == "true"

  protect_from_forgery

  before_filter :authorize

  class Forbidden < StandardError; end

  private
  def authorize
    facebook_id = session[:facebook_id]

    if facebook_id.present?
      @login_user = User.where(facebook_id: facebook_id, deleted: false).first
      session.delete(:facebook_id) if @login_user.blank?
    end
  end

  def login_required
    redirect_to :root if @login_user.blank?
  end
end
