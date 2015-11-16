class AddCommentableIdToComments < ActiveRecord::Migration
  def change
    add_column :comments, :commentable_id, :string
    add_column :comments, :commentable_type, :string
  end
end
