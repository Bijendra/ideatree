class AddPublishedAtToAssignments < ActiveRecord::Migration
  def change
    add_column :assignments, :published_at, :DateTime
  end
end
