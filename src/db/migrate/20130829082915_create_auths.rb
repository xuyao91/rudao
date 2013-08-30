class CreateAuths < ActiveRecord::Migration
  def change
    create_table :auths do |t|
      t.string   :code,    :null => false
      t.boolean  :usable, :null => false, :default => true
      t.datetime :deleted_at
      t.timestamps
    end
  end
end
