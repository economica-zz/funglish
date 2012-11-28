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
  end
end
