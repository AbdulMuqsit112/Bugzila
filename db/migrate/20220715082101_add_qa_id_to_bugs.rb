class AddQaIdToBugs < ActiveRecord::Migration[5.2]
  def change
    add_reference :bugs, :qa, index: true, foreign_key: true
  end
end
