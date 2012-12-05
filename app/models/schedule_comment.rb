class ScheduleComment < ActiveRecord::Base
  belongs_to :user, :conditions => {:deleted => false}

  attr_accessible :schedule_id, :user_id, :content, :deleted

  validates :content, :presence => true
  validates :content, :length => { :maximum => 1200 }
end
