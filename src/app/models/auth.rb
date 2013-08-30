class Auth < ActiveRecord::Base
  # attr_accessible :title, :body
  acts_as_paranoid
  belongs_to :user, :conditions => ["users.deleted_at is null"]
  USABLE = [["可用", 0], ["不可用", 1]]
end
