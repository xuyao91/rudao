class Pattern < ActiveRecord::Base
  # attr_accessible :title, :body
  acts_as_paranoid
  has_many :products, :conditions => ["products.deleted_at is null"]
  belongs_to :brand, :conditions => ["brands.deleted_at is null"]

  def self.get_conditions params

    conn = [[]]
    include = [:brand]

    if params[:name].present?
       conn[0] << "patterns.name like ? "
       conn << "%#{params[:name].strip}%"
    end

    if params[:brand_id].present?
        conn[0] << "patterns.brand_id = ? "
        conn << params[:brand_id]
    end

    conn.flatten!
    return conn, include
  end
end
