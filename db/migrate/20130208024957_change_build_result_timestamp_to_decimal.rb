class ChangeBuildResultTimestampToDecimal < ActiveRecord::Migration
  def up
    change_column :build_results, :timestamp, :decimal
  end

  def down
  end
end
