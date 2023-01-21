class RemoveExtraColumnsFromProjects < ActiveRecord::Migration[5.2]
  def change
    remove_column :projects, :admin_id
  end
end
