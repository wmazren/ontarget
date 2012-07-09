class CreateGoals < ActiveRecord::Migration
  def change
    create_table :goals do |t|
      t.string :title
      t.text :description
      t.date :start_date
      t.date :due_date
      t.string :state
      t.integer :user_id
      t.integer :review_id

      t.timestamps
    end
    
    add_index :goals, :user_id
    add_index :goals, :review_id
  end
end
