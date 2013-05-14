set :stages, ["dev","staging", "production"]
set :default_stage, "dev"


#Required settings
#Set application to the url of the project
set :application, "sample"
#Set repository is the path to the Git repository to deploy from. Capistrano will ssh into the server,
#so the user specified below must be able to ssh into the server
set :repository,  "https://github.com/colicoreloader/sample.git"
#
#Roles
#Roles are named sets of servers that you can target Capistrano tasks to execute against.
role :web, "root@192.168.169.130" 
role :app, "root@192.168.169.130"
#
#Optional Settings
#This allows Capistrano to prompt for passwords
default_run_options[:pty] = true
#The following lines tell Capistrano where to deploy the project
set :deploy_to, "/var/www/sample" # defaults to "/u/apps/#{application}"
set :current_path, "#{deploy_to}/current"
set :releases_path, "#{deploy_to}/releases/"
set :shared_path, "#{deploy_to}/shared/"
#This tells Capistrano that I'm using Git for versioning.
set :scm, :git
#This tells Capistrano that sudo access is not needed to deploy the project.
set :use_sudo, false

unless exists? :branch
set :branch do
branch = `git symbolic-ref -q HEAD`.sub(%r{^refs/heads/}, '').chomp
#raise CommandError.new("feature_demo cap stage only works if you have a checked out feature branch!") if branch == "master"
#branch
end
end
 
 
unless exists? :feature
set(:feature) { fetch :branch }
end

#
#And here are the tasks required to deploy a simple project
namespace:deploy do
    task:start do
    end
    task:stop do
    end
    task:finalize_update do
        run "chmod -R g+w #{release_path}"
    end
    task:restart do
    end
   after "deploy:restart" do
         #add any tasks in here that you want to run after the project is deployed
         run "rm -rf #{release_path}.git"
   end
end
