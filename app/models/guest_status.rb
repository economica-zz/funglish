class GuestStatus < ActiveRecord::Base
  APPLYING = 1
  APPROVED = 2
  DECLINED = 3

  attr_accessible :name, :deleted
end
