require File.join(File.dirname(__FILE__), 'build_status')
require 'sinatra/activerecord/rake'

namespace :db do
  desc "migrate your database"
  task :migrate_down do
    ActiveRecord::Migrator.down(
      'db/migrate',
      ENV["VERSION"] ? ENV["VERSION"].to_i : nil
    )
  end
end
