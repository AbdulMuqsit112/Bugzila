class ChangeBugStatusTypeTo < ActiveRecord::Migration[5.2]
  def change
    change_column(:bugs, :bug_status, :integer)
  end
end
