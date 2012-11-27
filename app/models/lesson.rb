class Lesson < ActiveRecord::Base
  attr_accessible :name, :description, :image_file_name, :deleted
end
