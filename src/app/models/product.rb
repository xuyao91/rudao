class Product < ActiveRecord::Base
  # attr_accessible :title, :body
  acts_as_paranoid
  belongs_to :brand, :conditions => ["brands.deleted_at is null"]
  belongs_to :pattern, :conditions => ["patterns.deleted_at is null"]
  has_many :point_logs, :conditions => ["point_logs.deleted_at is null"]
end
