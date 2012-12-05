class View < ActiveRecord::Base
  attr_accessible :user_id, :lesson_id, :auth_status_id, :deleted
end
