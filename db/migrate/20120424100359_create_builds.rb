class CreateBuilds < ActiveRecord::Migration
  def change
    create_table :builds do |t|
      t.string :name
      t.integer :branch_id

      t.timestamps
    end
  end
end
