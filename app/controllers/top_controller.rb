class TopController < ApplicationController
  def index
    @courses = Course.where(deleted: false).order("id")
  end
end
