class Brand < ActiveRecord::Base
  # attr_accessible :title, :body
  acts_as_paranoid
  has_many :products, :conditions => ["products.deleted_at is null"]
  has_many :patterns, :conditions => ["patterns.deleted_at is null"]
end
