class Lesson < ActiveRecord::Base
  attr_accessible :course_id, :number, :name, :price, :cloudinary_public_id, :description, :is_released, :scheduled_release_date, :release_date, :panda_video_id, :is_main_lesson, :main_lesson_id, :deleted
end
