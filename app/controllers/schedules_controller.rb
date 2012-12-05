require "status_codes"

class SchedulesController < ApplicationController
  def create
    if @login_user.blank?
      redirect_to :root
      return
    end

    p = params[:schedule]

    @schedule = Schedule.new(p)
    @schedule.user_id = @login_user.id
    @schedule.start_year = p["start_timestamp(1i)"].to_i
    @schedule.start_month = p["start_timestamp(2i)"].to_i
    @schedule.start_day = p["start_timestamp(3i)"].to_i
    @schedule.start_timestamp = TimeZone.convert_time_zone(@schedule.start_timestamp, @login_user, true)
    @schedule.end_timestamp = @schedule.start_timestamp + @schedule.time.minutes

    if @schedule.save
      flash[:success] = I18n.t("register_schedule_complete")
      redirect_to :root
    else
      if @schedule.start_timestamp.present?
        @schedule.start_timestamp = TimeZone.convert_time_zone(@schedule.start_timestamp, @login_user, false)
      end
      render "/top/register"
    end
  end

  def create_from_lesson
    if @login_user.blank?
      render :text => "", :status => StatusCodes::BAD_REQUEST
      return
    end

    p = params[:schedule]

    @schedule = Schedule.new(p)
    @schedule.user_id = @login_user.id
    @schedule.start_year = p["start_timestamp(1i)"].to_i
    @schedule.start_month = p["start_timestamp(2i)"].to_i
    @schedule.start_day = p["start_timestamp(3i)"].to_i
    @schedule.start_timestamp = TimeZone.convert_time_zone(@schedule.start_timestamp, @login_user, true)
    @schedule.end_timestamp = @schedule.start_timestamp + @schedule.time.minutes

    if @schedule.save
      @schedule = LessonsController.get_initial_schedule(@schedule.lesson_id, @login_user)
      @schedules = LessonsController.get_schedules(@schedule.lesson_id, params[:page])
      @lesson = Lesson.where(id: @schedule.lesson_id, deleted: false).first
      render :partial => "/lessons/practice_english_conversation"
    else
      if @schedule.start_timestamp.present?
        @schedule.start_timestamp = TimeZone.convert_time_zone(@schedule.start_timestamp, @login_user, false)
      end
      render :partial => "/schedules/register_schedule", :locals => {is_top: false}, :status => StatusCodes::INVALID_PARAMETERS
    end
  end

  def show
    id = params[:id]

    if id.blank?
      redirect_to :root
      return false
    end

    @schedule = Schedule.where(id: id, deleted: false).first

    if @schedule.blank?
      redirect_to :root
      return false
    end

    @schedule_comment = ScheduleComment.new
    @schedule_comment.schedule_id = id

    @schedule_comments = ScheduleCommentsController.get_schedule_comments(id, nil)
  end

  def delete_schedule
    id = params[:id]

    if id.blank?
      render :text => "", :status => StatusCodes::BAD_REQUEST
      return
    end

    @schedule = Schedule.where(id: id, deleted: false).first

    if @schedule.blank?
      render :text => "", :status => StatusCodes::BAD_REQUEST
      return
    end

    @schedule.deleted = true
    @schedule.start_year = @schedule.start_timestamp.year.to_i
    @schedule.start_month = @schedule.start_timestamp.month.to_i
    @schedule.start_day = @schedule.start_timestamp.day.to_i

    if @schedule.save
      @schedule = LessonsController.get_initial_schedule(@schedule.lesson_id, @login_user)
      @schedules = LessonsController.get_schedules(@schedule.lesson_id, params[:page])
      @lesson = Lesson.where(id: @schedule.lesson_id, deleted: false).first
      render :partial => "/lessons/practice_english_conversation"
    else
      render :text => "", :status => StatusCodes::BAD_REQUEST
      return
    end

  end

  def delete_schedule_top
    id = params[:id]

    if id.blank?
      render :text => "", :status => StatusCodes::BAD_REQUEST
      return
    end

    @schedule = Schedule.where(id: id, deleted: false).first

    if @schedule.blank?
      render :text => "", :status => StatusCodes::BAD_REQUEST
      return
    end

    @schedule.deleted = true
    @schedule.start_year = @schedule.start_timestamp.year.to_i
    @schedule.start_month = @schedule.start_timestamp.month.to_i
    @schedule.start_day = @schedule.start_timestamp.day.to_i

    if @schedule.save
      @schedules = TopController.get_schedules(@login_user, nil)
      render :partial => "/top/schedules"
    else
      render :text => "", :status => StatusCodes::BAD_REQUEST
      return
    end
  end

  def delete_schedule_top_history
    id = params[:id]

    if id.blank?
      render :text => "", :status => StatusCodes::BAD_REQUEST
      return
    end

    @schedule = Schedule.where(id: id, deleted: false).first

    if @schedule.blank?
      render :text => "", :status => StatusCodes::BAD_REQUEST
      return
    end

    @schedule.deleted = true
    @schedule.start_year = @schedule.start_timestamp.year.to_i
    @schedule.start_month = @schedule.start_timestamp.month.to_i
    @schedule.start_day = @schedule.start_timestamp.day.to_i

    if @schedule.save
      @schedules = TopController.get_schedules_history(@login_user, nil)
      render :partial => "/top/schedules_history"
    else
      render :text => "", :status => StatusCodes::BAD_REQUEST
      return
    end
  end

  def delete_schedule_detail
    id = params[:id]

    if id.blank?
      redirect_to :root
      return
    end

    @schedule = Schedule.where(id: id, deleted: false).first

    if @schedule.blank?
      redirect_to :root
      return
    end

    @schedule.deleted = true
    @schedule.start_year = @schedule.start_timestamp.year.to_i
    @schedule.start_month = @schedule.start_timestamp.month.to_i
    @schedule.start_day = @schedule.start_timestamp.day.to_i

    if @schedule.save
      redirect_to :root
    else
      redirect_to :root
    end
  end
end
