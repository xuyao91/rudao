class CreatePatterns < ActiveRecord::Migration
  def change
    create_table :patterns do |t|
      t.integer  :brand_id, :null => false
      t.integer  :name,      :null => false
      t.datetime :deleted_at
      t.timestamps
    end
  end
end
