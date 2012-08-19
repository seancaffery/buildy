require "bundler/capistrano"

set :application, "builds"
set :repository,  "git@github.com:seancaffery/buildy.git"

set :scm, :git

role :web, "lineonpoint.com"                          # Your HTTP server, Apache/etc
role :app, "lineonpoint.com"                          # This may be the same as your `Web` server
role :db,  "lineonpoint.com", :primary => true # This is where Rails migrations will run

# if you want to clean up old releases on each deploy uncomment this:
# after "deploy:restart", "deploy:cleanup"

set :deploy_to, "/var/apps/#{application}"
set :user, 'builds'
set :use_sudo, false

# If you are using Passenger mod_rails uncomment this:
namespace :deploy do
 task :start do ; end
 task :stop do ; end
 task :restart, :roles => :app, :except => { :no_release => true } do
   run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
 end
end
