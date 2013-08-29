class CreateUserShops < ActiveRecord::Migration
  def change
    create_table :user_shops do |t|
      t.integer  :user_id, :null => false
      t.integer  :shop_id, :null => false
      t.datetime :deleted_at
      t.timestamps
    end
  end
end
