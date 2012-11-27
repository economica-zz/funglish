class Lesson < ActiveRecord::Base
  attr_accessible :name, :description, :youtube_src, :cloudinary_public_id, :deleted
end
