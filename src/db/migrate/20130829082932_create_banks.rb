class CreateBanks < ActiveRecord::Migration
  def change
    create_table :banks do |t|
      t.integer  :user_id,        :null => false
      t.string   :name,            :null => false
      t.boolean  :sex,             :null => false
      t.string   :identity_card, :null => false
      t.string   :bank_card,      :null => false
      t.integer  :bank_kind,      :null => false
      t.string   :bank_address,   :null => false
      t.datetime :deleted_at
      t.timestamps
    end
  end
end
