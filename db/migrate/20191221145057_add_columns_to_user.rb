class AddColumnsToUser < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :available_start_time, :datetime
    add_column :users, :available_end_time, :datetime
    add_column :users, :specialist, :string
  end
end
