class CreateFollows < ActiveRecord::Migration
  def change
    create_table :follows do |t|
      t.string :obj_type
      t.string :obj_id
      t.string :user_id

      t.timestamps null: false
    end
  end
end
