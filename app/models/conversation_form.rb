class ConversationForm < ActiveRecord::Base
  FACE_TO_FACE = 1

  attr_accessible :name, :deleted
end
