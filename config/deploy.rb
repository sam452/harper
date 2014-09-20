require 'rvm/capistrano'
require 'bundler/capistrano'

#RVM and bundler settings
set :bundle_cmd, "~/.rvm/gems/ruby-2.1.0"
set :bundle_dir, "~/.rvm/gems/ruby-2.1.0"
set :rvm_ruby_string, :local
set :rack_env, :production


set :user, 'root'
set :domain, 'www.harpersolar.biz'
set :applicationdir, "/var/www/harper/"
set :scm, 'git'

set :application, "harper"
set :repository,  "git@github.com:sam452/harper.git"
set :branch, 'master'
set :git_shallow_clone, 1
set :scm_verbose, true
set :deploy_via, :remote_cache

# set :scm, :git # You can set :scm explicitly or Capistrano will make an intelligent guess based on known version control directory names
# Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`

role :web, domain                          # Your HTTP server, Apache/etc
role :app, domain                          # This may be the same as your `Web` server
role :db,  domain, :primary => true # This is where Rails migrations will run
#role :db,  "your slave db-server here"
# set :deploy_to, applicationdir
# set :deploy_via, :export

ssh_options[:forward_agent] = true
ssh_options[:keys] = [File.join(ENV["HOME"], ".ssh", "id_rsa")]
ssh_options[:paranoid] = false
default_run_options[:pty] = true



namespace :deploy do
	desc "Not starting as we're running passenger"
	task :start do
  end

  desc "Not stopping as we're running passenger"
  task :stop do
  end

  desc "Restart the app"
  task :restart, roles: :app, except: { :no_release => true } do
  	run "touch #{File.join(current_path, 'tmp', 'restart.txt')}"
  end

  task :cold do
  	deploy.update
  	deploy.start
  end

end

after "deploy:cold" do
	admin.nginx_restart
end
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