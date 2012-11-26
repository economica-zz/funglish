class Sex < ActiveRecord::Base
  attr_accessible :name, :deleted

  MALE = 1
  FEMALE = 2
end
