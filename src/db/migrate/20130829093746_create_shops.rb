class CreateShops < ActiveRecord::Migration
  def change
    create_table :shops do |t|
      t.string  :country,   :null => false
      t.string  :province,  :null => false
      t.string  :city,       :null => false
      t.string  :area,       :null => false
      t.string  :address,    :null => false
      t.datetime :deleted_at
      t.timestamps
    end
  end
end
