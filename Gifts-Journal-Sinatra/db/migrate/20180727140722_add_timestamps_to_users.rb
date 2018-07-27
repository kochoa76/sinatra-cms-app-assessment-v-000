class AddTimestampsToUsers < ActiveRecord::Migration
  def change_table
      add_timestamps(:users)
  end
end
