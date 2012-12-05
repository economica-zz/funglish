class AuthStatus < ActiveRecord::Base
  OK = 1
  NOT_LOGIN = 2
  NOT_PAID = 3

  attr_accessible :name, :deleted
end
