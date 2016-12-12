class CreateGoal < ActiveRecord::Migration
  def change
    create_table :goals do |t|
      t.integer :user_id, null: false
      t.string :title, null: false
      t.text :description, null: false
      t.boolean :is_private, null: false
      t.boolean :is_completed, null: false
    end

    add_index :goals, :user_id
  end
end
