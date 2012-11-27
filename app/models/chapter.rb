class Chapter < ActiveRecord::Base
  attr_accessible :lesson_id, :number, :name, :price, :cloudinary_public_id, :description, :is_released, :scheduled_release_date, :panda_video_id, :deleted
end
