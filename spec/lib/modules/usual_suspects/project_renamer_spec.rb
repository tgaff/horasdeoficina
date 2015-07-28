require 'spec_helper'
require 'rake'
require 'byebug'
require 'tempfile'
require 'pry'
require 'modules/usual_suspects/project_renamer'

RSpec.describe ProjectRenamer do
  describe 'methods' do
    subject(:renamer) { Class.new { extend ProjectRenamer } }

    describe '.substitute' do
      let(:initial_text) { "this has an xx but should have a yy" }
      let(:expected_text) { "this has an yy but should have a yy" }

      it 'returns text replacing one string with another' do
        expect(renamer.substitute(initial_text, 'xx', 'yy')).to eq expected_text
      end
    end


    describe '.find_and_replace_in_file' do
      let(:temp_file) { Tempfile.new('asdf') }
      before do
        15.times { temp_file.puts '12341-234 o' }
        temp_file.close(unlink_now=false)
        @directory = ''
      end

      it 'replaces the text in a file' do
        file_path = temp_file.path
        renamer.find_and_replace_in_file(file_path, '1', 'o')
        File.open(file_path).each do |line|
          expect(line).to eq "o234o-234 o\n" # warning, this can pass if the file is empty
        end
      end

      it "doesn't add stray bytes" do # test to counter above warning
        expect{ renamer.find_and_replace_in_file(temp_file.path, '3', '4')}.to_not change {temp_file.size}
      end

      after do
        temp_file.unlink
      end
    end


    describe '.replace_file' do
      let(:original_file) { Tempfile.new('original') }
      let(:replacement_file) { Tempfile.new('replacement') }

      before do
        original_file.write 'all original'
        replacement_file.write 'replace with me'
        original_file.close false
        replacement_file.close false
      end

      it 'overwrites file x with file y' do
        renamer.replace_file(replacement_file.path, original_file.path)

        expect(File.read(original_file.path)).to eq 'replace with me'
      end
    end


    describe '.project_root_directory' do
      it 'returns a string that is parsable as a directory' do
        dir = renamer.project_root_directory
        expect(File.directory? dir).to eq true
      end
    end
    describe '.underscore' do
      it 'underscores a string' do
        expect(renamer.underscore('camelCaseString')).to eq 'camel_case_string'
        expect(renamer.underscore('under_score')).to eq 'under_score'
      end
    end



    describe '.rename_application' do
      let(:app_name) { 'AlphaBetaGamma' }
      let(:app_name_us) { 'alpha_beta_gamma' }
      let(:dummy_file) { '/tmp/dum' }
      let(:new_name) { 'NewName' }
      let(:new_name_us) { 'new_name' }

      context 'unit tests' do

        subject(:rename_application) { renamer.rename_application new_name }
        before do
          allow(renamer).to receive(:original_name).and_return(app_name)
          allow(renamer).to receive(:list_of_files).and_return([dummy_file])
          allow(renamer).to receive(:original_name).and_return(app_name)
        end

        it 'calls find_and_replace_in_file with the original application name' do
          expect(renamer).to receive(:find_and_replace_in_file).with(dummy_file, app_name, new_name)
          expect(renamer).to receive(:find_and_replace_in_file).with(any_args)

          rename_application
        end

        it 'calls find_and_replace_in_file with an underscored application name' do
          expect(renamer).to receive(:find_and_replace_in_file).with(any_args)
          expect(renamer).to receive(:find_and_replace_in_file).with dummy_file, app_name_us, new_name_us

          rename_application
        end
      end
      context 'integration' do
        around(:all) do |example|
          Dir.mktmpdir('usual_suspects_spec') do |tmp_dir|
            @tmp_dir = tmp_dir # we need this to mock out project_root_directory to our test dir

            files = [ 'app', 'config' ]
            FileUtils.cp_r files, tmp_dir
            example.run
          end
        end

        before do
          # setup mocks
          allow(renamer).to receive(:project_root_directory) { @tmp_dir }
          renamer.rename_application(new_name) # TODO: optimize to just run this once
        end
        let(:new_name) { 'TootinPutin' }

        it 'changes the title in application.html.erb' do
          fname = expand 'app/views/layouts/application.html.erb'
          expect(exists_in_file?(fname, 'UsualSuspects')).to be_falsey
          expect(exists_in_file?(fname, 'TootinPutin')).to be_truthy
        end

        it 'changes the key in the session store' do
          fname = expand 'config/initializers/session_store.rb'
          expect(exists_in_file?(fname, 'usual_suspects')).to be_falsey
          expect(exists_in_file?(fname, 'tootin_putin')).to be true
        end

        it 'changes the title in application.rb' do
          fname = expand 'config/application.rb'
          expect(exists_in_file?(fname, 'UsualSuspects')).to be_falsey
          expect(exists_in_file?(fname, new_name)).to be true
        end
        def expand(fname)
          File.expand_path(fname, @tmp_dir)
        end
        def exists_in_file?(fname, string)
          raise unless File.exists? fname
          File.open(fname).grep(/#{string}/).length > 0
        end
      end
    end
  end
end

