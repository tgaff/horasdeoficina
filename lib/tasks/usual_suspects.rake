require 'rspec/core/rake_task'
require 'tempfile'
require 'fileutils'
require 'modules/usual_suspects/project_renamer'

namespace :usual_suspects do
  desc 'rename the application from UsualSupects to a specified camel-cased new name'
  task :rename_application, :new_name do |t, args|
    include ProjectRenamer
    new_name = args[:new_name]
    raise ArgumentError, "Specify a new name for the application!" if (new_name.nil? or new_name.empty?)
    
    rename_application(new_name)
  end
end
