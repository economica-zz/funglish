class TopController < ApplicationController
  def index
    @lesson1 = Lesson.where(id: 1, deleted: false).first
  end
end
