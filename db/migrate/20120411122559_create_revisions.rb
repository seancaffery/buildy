class CreateRevisions < ActiveRecord::Migration
  def self.up
    create_table :revisions do |t|
      t.string :revision_id
      t.integer :branch_id
      t.datetime :created_at
    end
  end

  def self.down
  end
end
