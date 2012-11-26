class AddTimestampToBuildResult < ActiveRecord::Migration
  def change
    add_column :build_results, :timestamp, :integer, :default => 0
  end
end
