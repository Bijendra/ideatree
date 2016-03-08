class AddDatatypeToAssignment < ActiveRecord::Migration
  def up
    change_column :assignments, :description, :text
  end
end
