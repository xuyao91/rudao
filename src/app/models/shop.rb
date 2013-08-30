class Shop < ActiveRecord::Base
  # attr_accessible :title, :body
  acts_as_paranoid
  has_many :user_shops, :conditions => ["user_shops.deleted_at is null"]
end
