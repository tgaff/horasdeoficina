require 'rspec/core/rake_task'
require 'tempfile'
require 'fileutils'
namespace :testing do

  desc 'rename the application from UsualSupects to a specified camel-cased new name'
  task :test, :new_name, :directory do |t, args|
    new_name = args[:new_name]
    puts 'done'
end
end

