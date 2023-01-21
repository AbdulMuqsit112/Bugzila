class AddAdminIsToProjects < ActiveRecord::Migration[5.2]
  def change
    # add_reference :projects, :admin_id, index: true, foreign_key: true
  end
end
