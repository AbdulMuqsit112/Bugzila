class RemoveExtraColumnsAdminIdFromProjects < ActiveRecord::Migration[5.2]
  def change
    remove_column :projects, :admin_id_id
  end
end
