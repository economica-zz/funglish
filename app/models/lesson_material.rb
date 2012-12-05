class LessonMaterial < ActiveRecord::Base
  belongs_to :material, :conditions => {:deleted => false}

  attr_accessible :lesson_id, :material_id, :file_name, :deleted
end
