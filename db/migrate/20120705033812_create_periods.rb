class CreatePeriods < ActiveRecord::Migration
  def change
    create_table :periods do |t|
      t.string :name
      t.date :start_date
      t.date :end_date
      t.string :state
      t.integer :account_id

      t.timestamps
    end
    
    add_index :periods, :account_id
  end
end
