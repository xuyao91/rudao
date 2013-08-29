class CreateCourses < ActiveRecord::Migration
  def change
    create_table :courses do |t|
      t.integer  :brand_id,     :null => false
      t.integer  :pattern_id,   :null => false
      t.string   :title,         :null => false
      t.text     :content,       :null => false
      t.datetime :deleted_at
      t.timestamps
    end
  end
end
