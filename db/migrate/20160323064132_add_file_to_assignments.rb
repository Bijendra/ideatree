class AddFileToAssignments < ActiveRecord::Migration
  def self.up
    change_table :assignments do |t|
        t.column :filename, :string
        t.column :content_type, :string
        t.column :data, :binary
    end
  end

  def self.down
    remove_attachment :assignments, :file
  end
end
