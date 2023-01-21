class RenameColumnInBug < ActiveRecord::Migration[5.2]
  def change
    rename_column :bugs, :status, :bug_status
  end
end
