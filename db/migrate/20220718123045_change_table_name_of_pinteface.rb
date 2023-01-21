class ChangeTableNameOfPinteface < ActiveRecord::Migration[5.2]
  def change
    rename_table :pinterfaces, :project_developers
  end
end
