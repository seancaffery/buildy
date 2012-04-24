class CreateRevisions < ActiveRecord::Migration
  def change
    create_table :revisions do |t|
      t.string :sha
      t.integer :branch_id

      t.timestamps
    end
  end
end
