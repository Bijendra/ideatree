class AddAttachmentAvatarToAssignments < ActiveRecord::Migration
  def self.up
    change_table :assignments do |t|
      t.attachment :avatar
    end
  end

  def self.down
    remove_attachment :assignments, :avatar
  end
end
