require 'spec_helper'
require 'rake'
require 'byebug'
require 'tempfile'
require 'pry'

RSpec.describe 'UsualSuspects' do

  before(:each) do
    @rake = Rake::Application.new
    Rake.application = @rake

    # Rake's rake_require tries to be too clever and won't reload from the file for successive RSpec runs
    Rake.load_rakefile 'lib/tasks/usual_suspects.rake'
    #Rake::Task.define_task(:environment)
    #Rake.application.rake_require 'tasks/usual_suspects'
    #Rake.application.rake_require '../lib/tasks/usual_suspects'
  end

  after(:each) do
    Rake.application = nil
  end

  describe 'tasks' do
    describe 'rename_application' do
      subject(:task) { @rake["usual_suspects:rename_application"] }
      context 'with no specified name' do
        it 'raises an error' do
          task.reenable
          expect{task.invoke}.to raise_error ArgumentError
        end
      end
      it 'calls ProjectRenamer.rename_application' do
        expect_any_instance_of(ProjectRenamer).to receive(:rename_application).and_return(true)
        task.invoke('BobsBurgers')
      end
    end
  end
end


