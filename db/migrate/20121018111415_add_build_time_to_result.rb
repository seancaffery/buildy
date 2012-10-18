class AddBuildTimeToResult < ActiveRecord::Migration
  def change
    add_column :build_results, :build_time, :decimal
  end
end
