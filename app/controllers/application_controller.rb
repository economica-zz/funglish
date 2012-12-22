class ApplicationController < ActionController::Base
  http_basic_authenticate_with :name => ENV["HTTP_BASIC_AUTH_NAME"], :password => ENV["HTTP_BASIC_AUTH_PASSWORD"] if ENV["HTTP_BASIC_AUTH_NAME"].present?

  protect_from_forgery

  before_filter :check_url, :authorize

  class Forbidden < StandardError; end

  private
  def check_url
    if(root_url.present? && (root_url == "http://funglish.jp/" || root_url == "https://funglish.jp/" || root_url == "http://www.funglish.jp/"))
      redirect_to "https://www.funglish.jp" + request.path_info
    end
  end

  def authorize
    facebook_id = session[:facebook_id]

    if facebook_id.present?
      @login_user = User.where(facebook_id: facebook_id, deleted: false).first
      session.delete(:facebook_id) if @login_user.blank?
    end

    if @login_user.present? && !@login_user.is_email_address_confirmed
      flash[:email_address_confirmation] = I18n.t("message_email_address_confirmation")
    end
  end

  def login_required
    redirect_to :root if @login_user.blank?
  end
end
