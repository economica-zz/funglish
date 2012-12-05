class Teacher < ActiveRecord::Base
  attr_accessible :course_id, :name, :cloudinary_public_id, :description, :deleted
end
