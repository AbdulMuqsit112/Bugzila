class AddDeveloperIdToBug < ActiveRecord::Migration[5.2]
  def change
    add_reference :bugs, :developer, index: true, foreign_key: true
  end
end
