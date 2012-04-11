class CreateBuildResults < ActiveRecord::Migration
  def self.up
    create_table :build_results do |t|
      t.integer :build_id
      t.integer :revision_id
      t.string :result
    end
  end

  def self.down
  end
end
