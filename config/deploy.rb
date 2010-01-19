set :application, "eJosh"
set :repository,  "svn://shailesh@server.joshsoftware.com/eJosh/trunk/src/eJosh"

set :scm, :subversion
set :scm_username,       "shailesh"
set :scm_password,       "shailesh"
# Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`

role :web, "intranet.joshsoftware.com" # Your HTTP server, Apache/etc
role :app, "intranet.joshsoftware.com", :mongrel => true, :sphinx => true, :memcached => true
#role :app, "192.168.1.100:10000"   # This may be the same as your `Web` server
role :db,  "intranet.joshsoftware.com", :primary => true # This is where Rails migrations will run
#role :db,  "your slave db-server here"

set :deploy_to, "/home/shailesh/eJosh"
set :use_sudo, false

set :rails_env, "production"

# If you are using Passenger mod_rails uncomment this:
# if you're still using the script/reapear helper you will need
# these http://github.com/rails/irs_process_scripts

 namespace :deploy do
   task :start do
     run "#{try_sudo} service nginx reload"
   end

   task :stop do
   end

   task :restart, :roles => :app, :except => { :no_release => true } do
     run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
   end
 end
