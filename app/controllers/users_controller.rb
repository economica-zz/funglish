class UsersController < ApplicationController
  before_filter :login_required, :only => ["edit"]

  def show
    facebook_id = params[:id]

    if facebook_id.blank?
      redirect_to :root
      return
    end

    @user = User.where(facebook_id: facebook_id, deleted: false).first

    if @user.blank?
      redirect_to :root
      return
    end

    @is_show_login_user = @login_user.present? && @login_user.id == @user.id

    @active_tab = "info"
  end

  def new
    code = params[:code]

    if code.blank?
      redirect_to :root
      return
    end

    client = AuthController.get_facebook_oauth_client(root_url)
    client.authorize(:code => code)

    if client.me.blank? || client.me.info.blank?
      redirect_to :root
      return
    end

    facebook_id = client.me.info["id"]

    if facebook_id.blank?
      redirect_to :root
      return
    end

    if User.where(facebook_id: facebook_id, deleted: false).count > 0
      update_facebook_link(facebook_id, client)
      session[:facebook_id] = facebook_id
      redirect_to :root
      return
    else
      gender = client.me.info["gender"]
      facebook_link = client.me.info["link"]

      @user = User.new
      @user.facebook_id = facebook_id

      if gender.present?
        if "male" == gender
          @user.sex_id = Sex::MALE
        elsif "female" == gender
          @user.sex_id = Sex::FEMALE
        end
      end

      if facebook_link.present?
        @user.facebook_link = facebook_link
      end

      @user.nationality_country_id = Country::JAPAN
      @user.location_country_id = Country::JAPAN
      @user.time_zone_id = TimeZone::JAPAN

      get_terms_privacy
    end
  end

  def create
    make_user_instance true

    if User.where(facebook_id: @user.facebook_id, deleted: false).count > 0
      redirect_to :root
      return
    end

    if @user.save
      session[:facebook_id] = @user.facebook_id
      redirect_to :root
    else
      render "users/new"
    end
  end

  def edit
    facebook_id = params[:id]
    @user = User.where(facebook_id: facebook_id, deleted: false).first
  end

  def update
    make_user_instance false

    if @user.save
      redirect_to "/users/" + @user.facebook_id
    else
      render "users/edit"
    end
  end

  private
  def update_facebook_link(facebook_id, client)
    latest_facebook_link = client.me.info["link"]
    current_facebook_link = User.where(facebook_id: facebook_id, deleted: false).first.facebook_link

    if latest_facebook_link.present? && latest_facebook_link != current_facebook_link
      User.update_all(["facebook_link = ?, updated_at = ?", latest_facebook_link, Time.current.in_time_zone("UTC")], ["facebook_id = ? AND deleted = 'f'", facebook_id])
    end
  end

  def get_terms_privacy
    @terms_of_service = TermsOfService.where(deleted: false).first
    @privacy_policy = PrivacyPolicy.where(deleted: false).first

    @user.terms_of_service_id = @terms_of_service.id
    @user.privacy_policy_id = @privacy_policy.id
  end

  def make_user_instance(is_create)
    p = params[:user]

    if is_create
      @user = User.new
      @user.facebook_id = p[:facebook_id]
      @user.facebook_link = p[:facebook_link]
      @user.terms_of_service_id = p[:terms_of_service_id]
      @user.privacy_policy_id = p[:privacy_policy_id]
      @user.terms_of_service_and_privacy_policy = p[:terms_of_service_and_privacy_policy]
    else
      @user = User.where(facebook_id: p[:facebook_id], deleted: false).first
    end

    @user.last_name = p[:last_name]
    @user.first_name = p[:first_name]
    @user.last_name_kana = p[:last_name_kana]
    @user.first_name_kana = p[:first_name_kana]
    @user.sex_id = p[:sex_id]
    @user.birthday = p["birthday(1i)"] + "-" + p["birthday(2i)"] + "-" + p["birthday(3i)"]
    @user.nationality_country_id = p[:nationality_country_id]
    @user.occupation_id = p[:occupation_id]
    @user.location_country_id = p[:location_country_id]
    @user.location_prefecture_id = p[:location_prefecture_id]
    @user.location_city = p[:location_city]
    @user.time_zone_id = p[:time_zone_id]
    @user.email_address = p[:email_address]
    @user.telephone_number = p[:telephone_number]
    @user.skype_name = p[:skype_name]
    @user.google_account = p[:google_account]
    @user.self_introduction = p[:self_introduction]
    @user.birthday_1i = p["birthday(1i)"]
    @user.birthday_2i = p["birthday(2i)"]
    @user.birthday_3i = p["birthday(3i)"]

    if !is_create && @user.email_address != User.where(facebook_id: p[:facebook_id], deleted: false).first.email_address
      @user.is_email_address_confirmed = false
      @user.email_address_confirmation_code = nil
    end
  end
end
