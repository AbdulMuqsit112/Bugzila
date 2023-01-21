class CreatePinterfaces < ActiveRecord::Migration[5.2]
  def change
    create_table :pinterfaces do |t|
      t.integer :user_id
      t.integer :project_id
    end
  end
end
