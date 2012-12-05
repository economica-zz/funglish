class GuestsController < ApplicationController
  def create
    if @login_user.blank?
      render :text => "", :status => StatusCodes::BAD_REQUEST
      return
    end

    id = params[:id]

    if id.blank?
      render :text => "", :status => StatusCodes::BAD_REQUEST
      return
    end

    if Guest.where(schedule_id: id, user_id: @login_user.id, deleted: false).count > 0
      schedule = Schedule.where(id: id, deleted: false).first
      render :partial => "/schedules/schedule", :locals => {schedule: schedule, is_top: params[:is_top] == "true", is_top_history: params[:is_top_history] == "true", is_detail: params[:is_detail] == "true"}
      return
    end

    @guest = Guest.new
    @guest.schedule_id = id
    @guest.user_id = @login_user.id
    @guest.guest_status_id = GuestStatus::APPLYING

    if @guest.save
      schedule = Schedule.where(id: id, deleted: false).first
      if schedule.user.is_email_address_confirmed
        Mailer.schedule_applied(schedule.user.email_address, schedule.schedule_time(schedule.user), root_url, schedule.id).deliver
      end
      render :partial => "/schedules/schedule", :locals => {schedule: schedule, is_top: params[:is_top] == "true", is_top_history: params[:is_top_history] == "true", is_detail: params[:is_detail] == "true"}
    else
      render :text => "", :status => StatusCodes::BAD_REQUEST
    end
  end

  def approve_request
    id = params[:id]

    if id.blank?
      render :text => "", :status => StatusCodes::BAD_REQUEST
      return
    end

    @guest = Guest.where(id: id, deleted: false).first

    if @guest.blank?
      render :text => "", :status => StatusCodes::BAD_REQUEST
      return
    end

    @guest.guest_status_id = GuestStatus::APPROVED

    if @guest.save
      if Guest.where(schedule_id: @guest.schedule_id, guest_status_id: GuestStatus::APPROVED, deleted: false).count == @guest.schedule.maximum_number_of_guests
        Guest.update_all(["guest_status_id = ?, deleted = ?, updated_at = ?", GuestStatus::DECLINED, "t", Time.current.in_time_zone("UTC")], ["schedule_id = ? AND guest_status_id = ? AND deleted = ?", @guest.schedule_id, GuestStatus::APPLYING, "f"])
      end
      if @guest.user.is_email_address_confirmed
        Mailer.schedule_approved(@guest.user.email_address, @guest.schedule.schedule_time(@guest.user), root_url, @guest.schedule_id).deliver
      end
      schedule = Schedule.where(id: @guest.schedule_id, deleted: false).first
      render :partial => "/schedules/schedule", :locals => {schedule: schedule, is_top: params[:is_top] == "true", is_top_history: params[:is_top_history] == "true", is_detail: params[:is_detail] == "true"}
    else
      render :text => "", :status => StatusCodes::BAD_REQUEST
    end
  end

  def decline_request
    id = params[:id]

    if id.blank?
      render :text => "", :status => StatusCodes::BAD_REQUEST
      return
    end

    @guest = Guest.where(id: id, deleted: false).first

    if @guest.blank?
      render :text => "", :status => StatusCodes::BAD_REQUEST
      return
    end

    @guest.guest_status_id = GuestStatus::DECLINED
    @guest.deleted = true

    if @guest.save
      schedule = Schedule.where(id: @guest.schedule_id, deleted: false).first
      render :partial => "/schedules/schedule", :locals => {schedule: schedule, is_top: params[:is_top] == "true", is_top_history: params[:is_top_history] == "true", is_detail: params[:is_detail] == "true"}
    else
      render :text => "", :status => StatusCodes::BAD_REQUEST
    end
  end

  def cancel_request
    if @login_user.blank?
      render :text => "", :status => StatusCodes::BAD_REQUEST
      return
    end

    id = params[:id]

    if id.blank?
      render :text => "", :status => StatusCodes::BAD_REQUEST
      return
    end

    @guest = Guest.where(schedule_id: id, user_id: @login_user.id, deleted: false).first

    if @guest.blank?
      render :text => "", :status => StatusCodes::BAD_REQUEST
      return
    end

    @guest.deleted = true

    if @guest.save
      schedule = Schedule.where(id: id, deleted: false).first
      render :partial => "/schedules/schedule", :locals => {schedule: schedule, is_top: params[:is_top] == "true", is_top_history: params[:is_top_history] == "true", is_detail: params[:is_detail] == "true"}
    else
      render :text => "", :status => StatusCodes::BAD_REQUEST
    end
  end

  def cancel_request_detail
    if @login_user.blank?
      redirect_to :root
      return
    end

    id = params[:id]

    if id.blank?
      redirect_to :root
      return
    end

    @guest = Guest.where(schedule_id: id, user_id: @login_user.id, deleted: false).first

    if @guest.blank?
      redirect_to :root
      return
    end

    @guest.deleted = true

    if @guest.save
      redirect_to "/schedules/" + id.to_s
    else
      redirect_to :root
    end
  end
end
