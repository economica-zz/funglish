class PrivacyPolicy < ActiveRecord::Base
  attr_accessible :content, :deleted
end
