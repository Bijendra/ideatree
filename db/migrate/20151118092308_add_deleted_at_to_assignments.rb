class AddDeletedAtToAssignments < ActiveRecord::Migration
  def change
    add_column :assignments, :deleted_at, :datetime
    add_index :assignments, :deleted_at
  end
end
