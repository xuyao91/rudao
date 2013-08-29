class Bank < ActiveRecord::Base
  # attr_accessible :title, :body
  acts_as_paranoid
  belongs_to :user, :conditions => ["users.deleted_at is null"]
end
