class AddTimestampsToGifts < ActiveRecord::Migration
  def change_table
      add_timestamps(:gifts)
  end
end
