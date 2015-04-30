require 'active_record'
require 'yaml'

task :default => :migrate

desc "Migrate the database through scripts in db/migrate. Target specific version with VERSION=x"
task :migrate => :environment do
    ActiveRecord::Migrator.migrate('db/migrate', ENV["VERSION"] ? ENV["VERSION"].to_i : nil )
end

task :environment do
	env = ENV["BLOG_ENV"] ? ENV["BLOG_ENV"] : 'default'
    ActiveRecord::Base.establish_connection(YAML::load(File.open('config/database.yml'))[env])
    ActiveRecord::Base.logger = Logger.new(File.open('log/database.log', 'a'))
end