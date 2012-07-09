class CreateAccounts < ActiveRecord::Migration
  def change
    create_table :accounts do |t|
      t.string :name,      :null => false, :default => ""
      t.string :phone
      t.string :fax
      t.string :address1
      t.string :address2
      t.string :city
      t.string :postcode
      t.string :state
      t.string :country
      t.integer :user_limit

      t.timestamps
    end
    
    add_index :accounts, :name,      :unique => true
  end
end
