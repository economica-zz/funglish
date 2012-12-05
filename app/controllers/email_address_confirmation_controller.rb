class EmailAddressConfirmationController < ApplicationController
  def index
    if @login_user.blank? || @login_user.is_email_address_confirmed || @login_user.email_address.blank?
      redirect_to :root
      return
    end

    if @login_user.email_address_confirmation_code.blank?
      number_array = ('0'..'9').to_a
      User.update_all(["email_address_confirmation_code = ?, updated_at = ?", (Array.new(10) do number_array[rand(number_array.size)] end).join, Time.current.in_time_zone("UTC")], ["id = ?", @login_user.id])
      @login_user = User.where(id: @login_user.id, deleted: false).first
    end

    Mailer.email_address_confirmation(@login_user.email_address, root_url, @login_user.facebook_id, @login_user.email_address_confirmation_code).deliver

    flash[:email_address_confirmation] = nil
  end

  def complete
    facebook_id = params[:facebook_id]

    if facebook_id.blank?
      redirect_to :root
      return
    end

    email_address_confirmation_code = params[:email_address_confirmation_code]

    if email_address_confirmation_code.blank?
      redirect_to :root
      return
    end

    if User.where(facebook_id: facebook_id, email_address_confirmation_code: email_address_confirmation_code, is_email_address_confirmed: false, deleted: false).count == 0
      redirect_to :root
      return 
    end

    User.update_all(["is_email_address_confirmed = ?, updated_at = ?", "t", Time.current.in_time_zone("UTC")], ["facebook_id = ? AND deleted = ?", facebook_id, "f"])

    flash[:email_address_confirmation] = nil
  end
end
