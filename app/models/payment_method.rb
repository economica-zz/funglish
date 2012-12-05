class PaymentMethod < ActiveRecord::Base
  PAYPAL = 1

  attr_accessible :name, :deleted
end
