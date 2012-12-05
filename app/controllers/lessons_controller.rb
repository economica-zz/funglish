class LessonsController < ApplicationController
  def show
    id = params[:id]

    if id.blank?
      redirect_to :root
      return
    end

    @lesson = Lesson.where(id: id, deleted: false).first

    if @lesson.blank?
      redirect_to :root
      return
    end

    @auth_status_id = get_auth_status_id(@lesson, @login_user)

    if @auth_status_id == AuthStatus::OK
      @panda_video = Panda::Video.find(@lesson.panda_video_id)

      @panda_video_webm = @panda_video.encodings[VideoProps::VIDEO_ENCODING_WEBM]
      @panda_video_ogg = @panda_video.encodings[VideoProps::VIDEO_ENCODING_OGG]
      @panda_video_h264 = @panda_video.encodings[VideoProps::VIDEO_ENCODING_H264]

      bucket = AWS::S3.new.buckets[VideoProps::S3_BUCKET_NAME]

      @panda_video_webm_url = bucket.objects[@panda_video_webm.files.first].url_for(:read, :expires => VideoProps::S3_EXPIRES)
      @panda_video_ogg_url = bucket.objects[@panda_video_ogg.files.first].url_for(:read, :expires => VideoProps::S3_EXPIRES)
      @panda_video_h264_url = bucket.objects[@panda_video_h264.files.first].url_for(:read, :expires => VideoProps::S3_EXPIRES)
    end

    @payment = nil

    if @login_user.present?
      @payment = Payment.where(user_id: @login_user.id, lesson_id: id, deleted: false).order("expiration_timestamp DESC").first

      @view = View.new
      @view.user_id = @login_user.id
      @view.lesson_id = id
      @view.auth_status_id = @auth_status_id
      @view.save
    end

    @lesson_materials = LessonMaterial.where(lesson_id: id, deleted: false).order("id")

    @lessons = Lesson.where(main_lesson_id: id, is_main_lesson: false, deleted: false).order("id")

    @schedule = LessonsController.get_initial_schedule(id, @login_user)

    @schedules = LessonsController.get_schedules(id, params[:page])

    @comment = Comment.new
    @comment.lesson_id = id

    @comments = Comment.where(lesson_id: id, is_parent: true, deleted: false).order("id DESC")
                  .paginate(page: params[:comment_page], per_page: Paginate::PER_PAGE_COMMENTS)

    @comment_child = Comment.new
    @comment_child.lesson_id = id
  end

  def get_schedule_list
    id = params[:id]

    if id.blank?
      render :text => "", :status => StatusCodes::BAD_REQUEST
      return
    end

    @schedules = LessonsController.get_schedules(id, params[:page])
    @lesson = Lesson.where(id: id, deleted: false).first

    render :partial => "/schedules/apply_schedule"
  end

  private
  def get_auth_status_id(lesson, login_user)
    if lesson.price == 0
      return AuthStatus::OK
    end

    if login_user.blank?
      return AuthStatus::NOT_LOGIN
    end

    if Payment.where(user_id: login_user.id, lesson_id: lesson.id, deleted: false).where("expiration_timestamp >= ?", Time.current.in_time_zone("UTC")).count == 0
      return AuthStatus::NOT_PAID
    end

    return AuthStatus::OK
  end

  class << self
    def get_initial_schedule(lesson_id, login_user)
      schedule = Schedule.new
      schedule.lesson_id = lesson_id
      schedule.conversation_form_id = ConversationForm::FACE_TO_FACE
      if login_user.present?
        schedule.location_prefecture_id = login_user.location_prefecture_id
      end
      schedule
    end

    def get_schedules(lesson_id, page)
      Schedule
        .where(lesson_id: lesson_id)
        .where("start_timestamp >= ?", Time.current.in_time_zone("UTC"))
        .where(deleted: false)
        .order("start_timestamp, id")
        .paginate(page: page, per_page: Paginate::PER_PAGE_SCHEDULES)
    end
  end
end
