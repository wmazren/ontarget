class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      t.text    :subordinate_comments
      t.text    :supervisor_comments
      t.string  :rating
      t.text    :final_comments
      t.string  :state
      t.integer :user_id
      t.integer :period_id
      t.integer :account_id

      t.timestamps
    end
    
    add_index :reviews, :user_id
    add_index :reviews, :period_id
    add_index :reviews, :account_id
  end
end
