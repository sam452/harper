require 'rvm/capistrano'
require 'bundler/capistrano'

#RVM and bundler settings
set :bundle_cmd, "~/.rvm/gems/ruby-2.1.0"
set :bundle_dir, "~/.rvm/gems/ruby-2.1.0"
set :rvm_ruby_string, :local
set :rack_env, :production


set :user, 'root'
set :domain, 'www.harpersolar.biz'
set :applicationdir, "/var/www/harper/public/"
set :scm, 'git'

set :application, "harper"
set :repository,  "set your repository location here"

# set :scm, :git # You can set :scm explicitly or Capistrano will make an intelligent guess based on known version control directory names
# Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`

role :web, "your web-server here"                          # Your HTTP server, Apache/etc
role :app, "your app-server here"                          # This may be the same as your `Web` server
role :db,  "your primary db-server here", :primary => true # This is where Rails migrations will run
role :db,  "your slave db-server here"

# if you want to clean up old releases on each deploy uncomment this:
# after "deploy:restart", "deploy:cleanup"

# if you're still using the script/reaper helper you will need
# these http://github.com/rails/irs_process_scripts

# If you are using Passenger mod_rails uncomment this:
# namespace :deploy do
#   task :start do ; end
#   task :stop do ; end
#   task :restart, :roles => :app, :except => { :no_release => true } do
#     run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
#   end
# end