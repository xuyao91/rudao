class UserShop < ActiveRecord::Base
  # attr_accessible :title, :body
  acts_as_paranoid
end
