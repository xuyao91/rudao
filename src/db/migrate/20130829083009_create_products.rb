class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.integer :brand_id,    :null => false
      t.integer :pattern_id,  :null => false
      t.string  :code,         :null => false
      t.datetime :deleted_at
      t.timestamps
    end
  end
end
