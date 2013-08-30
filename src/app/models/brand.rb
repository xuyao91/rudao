class Brand < ActiveRecord::Base
  # attr_accessible :title, :body
  acts_as_paranoid
  has_many :products, :conditions => ["products.deleted_at is null"]
  has_many :patterns, :conditions => ["patterns.deleted_at is null"]

  validates :name, :presence => true #name必须存在


  # 品牌查询条件
  #【引数】
  #【返値】conn
  #【注意】
  #【著作】 by lh 2013-8-30
  def self.get_conditions  params
    conn = [[]]
  end
end
