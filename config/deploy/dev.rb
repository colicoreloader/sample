server "192.168.169.130", :app, :web, :db, :primary => true
set :deploy_to, "/var/www/sample"
set :branch, 'dev'