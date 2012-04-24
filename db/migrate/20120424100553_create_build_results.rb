class CreateBuildResults < ActiveRecord::Migration
  def change
    create_table :build_results do |t|
      t.integer :build_id
      t.integer :revision_id
      t.string :result

      t.timestamps
    end
  end
end
