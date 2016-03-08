class AddQuoteToAssignment < ActiveRecord::Migration
  def change
    add_column :assignments, :quote, :string
  end
end
