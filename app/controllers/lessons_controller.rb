class LessonsController < ApplicationController
  def show
    @lesson = Lesson.where(id: params[:id], deleted: false).first

    if @lesson.blank?
      redirect_to :root
      return
    end
  end
end
