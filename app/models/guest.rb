class Guest < ActiveRecord::Base
  belongs_to :schedule, :conditions => {:deleted => false}
  belongs_to :user, :conditions => {:deleted => false}
  belongs_to :guest_status, :conditions => {:deleted => false}

  attr_accessible :schedule_id, :user_id, :guest_status_id, :deleted
end
