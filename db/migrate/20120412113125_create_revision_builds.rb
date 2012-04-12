class CreateRevisionBuilds < ActiveRecord::Migration
  def self.up
    create_table :revision_builds do |t|
      t.integer :revision_id
      t.integer :build_id
    end
  end

  def self.down
  end
end
