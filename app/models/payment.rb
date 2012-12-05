class Payment < ActiveRecord::Base
  attr_accessible :user_id, :lesson_id, :payment_method_id, :amount, :pay_timestamp, :expiration_timestamp, :deleted
end
