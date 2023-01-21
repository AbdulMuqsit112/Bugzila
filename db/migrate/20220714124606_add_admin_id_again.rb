class AddAdminIdAgain < ActiveRecord::Migration[5.2]
  def change
    add_reference :projects, :admin, index: true, foreign_key: true
  end
end
