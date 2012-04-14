class CreateBuilds < ActiveRecord::Migration
  def self.up
    create_table :builds do |t|
      t.string :name
      t.integer :branch_id
    end
  end

  def self.down
  end
end
