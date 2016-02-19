class AddtoComments < ActiveRecord::Migration
  def change
  	add_column :comments, :assignment_id, :integer
  end
end
