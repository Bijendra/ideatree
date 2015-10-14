class CreateAssignments < ActiveRecord::Migration
  def change
    create_table :assignments do |t|
      t.string :description
      t.integer :user_id
      t.string :category_id
      t.boolean :status, default: false

      t.timestamps null: false
    end
  end
end
