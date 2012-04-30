class AddEnabledToBuilds < ActiveRecord::Migration
  def change
    add_column :builds, :enabled, :boolean, :null => false, :default => false
  end
end
