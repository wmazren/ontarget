class CreateProgresses < ActiveRecord::Migration
  def change
    create_table :progresses do |t|
      t.text :progress_update
      t.integer :percent_complete
      t.string :state
      t.integer :user_id
      t.integer :goal_id

      t.timestamps
    end
    
    add_index :progresses, :goal_id
    add_index :progresses, :user_id
  end
end
