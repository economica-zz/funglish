class Country < ActiveRecord::Base
  attr_accessible :name, :deleted

  JAPAN = 130
end
