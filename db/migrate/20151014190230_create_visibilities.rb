class CreateVisibilities < ActiveRecord::Migration
  def change
    create_table :visibilities do |t|
      t.string :assignment_id
      t.string :user_id

      t.timestamps null: false
    end
  end
end
