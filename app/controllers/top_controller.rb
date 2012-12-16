class TopController < ApplicationController
  def index
    if @login_user.blank?
      @courses = Course.where(deleted: false).order("id")
    else
      @schedules = TopController.get_schedules(@login_user, params[:schedule_top_page])
      @active_tab = "schedule"
      render "top/schedules"
    end
  end

  def apply
    @schedules = TopController.get_schedules_for_apply(@login_user, params[:schedule_top_apply_page])
    @active_tab = "apply"
  end

  def register
    @schedule = LessonsController.get_initial_schedule(nil, @login_user)
    @active_tab = "register"
  end

  def lesson
    @courses = Course.where(deleted: false).order("id")
    @active_tab = "lesson"
  end

  def history
    @schedules = TopController.get_schedules_history(@login_user, params[:schedule_top_history_page])
    @active_tab = "history"
  end

  def get_schedule_list
    @schedules = TopController.get_schedules(@login_user, params[:schedule_top_page])
    render :partial => "top/schedules"
  end

  def get_schedule_apply_list
    @schedules = TopController.get_schedules_for_apply(@login_user, params[:schedule_top_apply_page])
    render :partial => "top/schedules_apply"
  end

  def get_schedule_history_list
    @schedules = TopController.get_schedules_history(@login_user, params[:schedule_top_history_page])
    render :partial => "top/schedules_history"
  end

  class << self
    def get_schedules(login_user, page)
      Schedule
        .where("EXISTS (
                          SELECT
                              'x'
                          FROM
                              (
                                SELECT
                                    s.id
                                FROM
                                    schedules s
                                WHERE
                                    s.user_id = ?
                                AND s.end_timestamp >= ?
                                AND s.deleted = 'f'
                                UNION ALL
                                SELECT
                                    s.id
                                FROM
                                    schedules s
                                WHERE
                                    EXISTS (
                                              SELECT
                                                  'x'
                                              FROM
                                                  guests g
                                              WHERE
                                                  g.schedule_id = s.id
                                              AND g.user_id = ?
                                              AND g.guest_status_id IN (?, ?)
                                              AND g.deleted = 'f'
                                    )
                                AND s.user_id <> ?
                                AND s.end_timestamp >= ?
                                AND s.deleted = 'f'
                              ) v
                          WHERE
                            v.id = schedules.id
                )", login_user.id, Time.current.in_time_zone("UTC"), login_user.id, GuestStatus::APPLYING, GuestStatus::APPROVED, login_user.id, Time.current.in_time_zone("UTC"))
        .where(deleted: false)
        .order("start_timestamp, id")
        .paginate(page: page, per_page: Paginate::PER_PAGE_SCHEDULES)
    end

    def get_schedules_for_apply(login_user, page)
      Schedule
        .where("user_id <> ?", login_user.id)
        .where("start_timestamp >= ?", Time.current.in_time_zone("UTC"))
        .where(deleted: false)
        .order("start_timestamp, id")
        .paginate(page: page, per_page: Paginate::PER_PAGE_SCHEDULES)
    end

    def get_schedules_history(login_user, page)
      Schedule
        .where("EXISTS (
                          SELECT
                              'x'
                          FROM
                              (
                                SELECT
                                    s.id
                                FROM
                                    schedules s
                                WHERE
                                    s.user_id = ?
                                AND s.end_timestamp < ?
                                AND s.deleted = 'f'
                                UNION ALL
                                SELECT
                                    s.id
                                FROM
                                    schedules s
                                WHERE
                                    EXISTS (
                                              SELECT
                                                  'x'
                                              FROM
                                                  guests g
                                              WHERE
                                                  g.schedule_id = s.id
                                              AND g.user_id = ?
                                              AND g.guest_status_id = ?
                                              AND g.deleted = 'f'
                                    )
                                AND s.user_id <> ?
                                AND s.end_timestamp < ?
                                AND s.deleted = 'f'
                              ) v
                          WHERE
                            v.id = schedules.id
                )", login_user.id, Time.current.in_time_zone("UTC"), login_user.id, GuestStatus::APPROVED, login_user.id, Time.current.in_time_zone("UTC"))
        .where(deleted: false)
        .order("start_timestamp DESC, id DESC")
        .paginate(page: page, per_page: Paginate::PER_PAGE_SCHEDULES)
    end
  end
end
