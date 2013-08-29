class CreatePointLogs < ActiveRecord::Migration
  def change
    create_table :point_logs do |t|
      t.integer :user_id,    :null => false
      t.integer :product_id, :null => false
      t.integer :point,       :null => false
      t.decimal :price,       :null => false
      t.integer :kind,        :null => false
      t.datetime :deleted_at
      t.timestamps
    end
  end
end
