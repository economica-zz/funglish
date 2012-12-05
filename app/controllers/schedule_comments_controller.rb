class ScheduleCommentsController < ApplicationController
  def create
    if @login_user.blank?
      render :text => "", :status => StatusCodes::BAD_REQUEST
      return
    end

    @schedule_comment = ScheduleComment.new
    @schedule_comment.schedule_id = params[:schedule_comment][:schedule_id]
    @schedule_comment.user_id = @login_user.id
    @schedule_comment.content = params[:schedule_comment][:content]

    if @schedule_comment.save
      @schedule = Schedule.where(id: params[:schedule_comment][:schedule_id], deleted: false).first
      @schedule_comment = ScheduleComment.new
      @schedule_comment.schedule_id = params[:schedule_comment][:schedule_id]
      @schedule_comments = ScheduleCommentsController.get_schedule_comments(params[:schedule_comment][:schedule_id], nil)

      if @schedule.user_id != @login_user.id && @schedule.user.is_email_address_confirmed
        Mailer.schedule_comment_posted(@schedule.user.email_address, @schedule.schedule_time(@schedule.user), root_url, @schedule.id).deliver
      end

      guests = @schedule.guests.where("user_id != ?", @login_user.id).where(guest_status_id: GuestStatus::APPROVED, deleted: false)

      guests.each do |guest|
        if guest.user.is_email_address_confirmed
          Mailer.schedule_comment_posted(guest.user.email_address, @schedule.schedule_time(guest.user), root_url, @schedule.id).deliver
        end
      end

      render :partial => "schedule_comments/top"
    else
      render :partial => "schedule_comments/register", :status => StatusCodes::INVALID_PARAMETERS
    end
  end

  def delete_schedule_comment
    id = params[:id]

    if id.blank?
      render :text => "", :status => StatusCodes::BAD_REQUEST
      return
    end

    @schedule_comment = ScheduleComment.where(id: id, deleted: false).first

    if @schedule_comment.blank?
      render :text => "", :status => StatusCodes::BAD_REQUEST
      return
    end

    @schedule_comment.deleted = true

    if @schedule_comment.save
      @schedule_comments = ScheduleCommentsController.get_schedule_comments(@schedule_comment.schedule_id, nil)
      render :partial => "schedule_comments/schedule_comments", :locals => {schedule_id: @schedule_comment.schedule_id}
    else
      render :text => "", :status => StatusCodes::BAD_REQUEST
      return
    end
  end

  def get_schedule_comment_list
    id = params[:id]

    if id.blank?
      render :text => "", :status => StatusCodes::BAD_REQUEST
      return
    end

    @schedule_comments = ScheduleCommentsController.get_schedule_comments(id, params[:schedule_comment_page])
    render :partial => "schedule_comments/schedule_comments", :locals => {schedule_id: id}
  end

  class << self
    def get_schedule_comments(schedule_id, page)
      ScheduleComment.where(schedule_id: schedule_id, deleted: false).order("id DESC")
        .paginate(page: page, per_page: Paginate::PER_PAGE_COMMENTS)
    end
  end
end
