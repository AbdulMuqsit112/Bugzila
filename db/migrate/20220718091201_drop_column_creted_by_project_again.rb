class DropColumnCretedByProjectAgain < ActiveRecord::Migration[5.2]
  def change
    remove_column :projects, :created_by
  end
end
