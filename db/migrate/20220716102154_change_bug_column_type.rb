class ChangeBugColumnType < ActiveRecord::Migration[5.2]
  def change
    change_column(:bugs, :bug_type, :integer)
  end
end
