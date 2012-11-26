class SetTimestampToZero < ActiveRecord::Migration
  def up
    BuildResult.all.each do |res|
      res.timestamp = 0
      res.save
    end
  end

  def down
  end
end
