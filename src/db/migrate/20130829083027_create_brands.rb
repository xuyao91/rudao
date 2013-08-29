class CreateBrands < ActiveRecord::Migration
  def change
    create_table :brands do |t|
      t.string   :name, :null => false
      t.datetime :deleted_at
      t.timestamps
    end
  end
end
