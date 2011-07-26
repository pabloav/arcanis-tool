set :application, "arcanis-tool"
set :repository,  "git://github.com/pabloav/arcanis-tool.git"

set :scm, :git
# Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`

role :web, "franklin.vanitude.com"                          # Your HTTP server, Apache/etc
role :app, "franklin.vanitude.com"                          # This may be the same as your `Web` server
role :db,  "franklin.vanitude.com", :primary => true # This is where Rails migrations will run

set :deploy_to, "/var/sites/arcanis-tool.vanitude.com/"
set :rails_env, "production" 

# If you are using Passenger mod_rails uncomment this:
# if you're still using the script/reapear helper you will need
# these http://github.com/rails/irs_process_scripts

namespace :deploy do
#   task :start do ; end
#   task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end
  
  task :debianize, :roles => :app do
    run "cd #{latest_release}; /usr/local/bin/rails-app-debianize"
  end
  
  task :start do 
    run "cd #{current_path}; /usr/local/bin/rails-app-debianize"
  end
  
  after "deploy:update_code", "deploy:debianize"
  after "deploy:update_code", "deploy:migrate"
  
end