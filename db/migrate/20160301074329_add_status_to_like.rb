class AddStatusToLike < ActiveRecord::Migration
  def change
    add_column :likes, :status, :Boolean
  end
end
