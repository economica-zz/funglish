class CoursesController < ApplicationController
  def show
    id = params[:id]

    if id.blank?
      redirect_to :root
      return
    end

    @course = Course.where(id: id, deleted: false).first

    if @course.blank?
      redirect_to :root
      return
    end

    @lessons = Lesson.where(course_id: id, is_main_lesson: true, deleted: false).order("number, id")

    if @lessons.blank?
      redirect_to :root
      return
    end

    @teachers = Teacher.where(course_id: id, deleted: false).order("id")

    if @teachers.blank?
      redirect_to :root
      return
    end
  end
end
