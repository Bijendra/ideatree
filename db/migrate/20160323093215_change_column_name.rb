class ChangeColumnName < ActiveRecord::Migration
  def change
  	change_table :assignments do |t|
      t.rename :filename, :document_file_name
      t.rename :content_type, :document_content_type
    end
  end
end
