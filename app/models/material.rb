class Material < ActiveRecord::Base
  attr_accessible :name, :icon_file_name, :description, :deleted
end
