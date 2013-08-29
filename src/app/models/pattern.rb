class Pattern < ActiveRecord::Base
  # attr_accessible :title, :body
  acts_as_paranoid
  has_many :products, :conditions => ["products.deleted_at is null"]
  belongs_to :brand, :conditions => ["brands.deleted_at is null"]
end
