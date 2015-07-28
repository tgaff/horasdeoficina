module ProjectRenamer

  def list_of_files
  [
    'config/application.rb',
    'app/views/layouts/application.html.erb',
    'config/initializers/session_store.rb'
  ]
  end

  def expanded_file_name(fname)
    File.expand_path(fname, project_root_directory)
  end

  def substitute(input, find, replace)
    input.gsub(find, replace)
  end

  def replace_file(source_path, dest_path)
    FileUtils.mv(source_path, dest_path, force: true)
  end

  def project_root_directory(root=nil)
    root || File.expand_path('..',__FILE__) # Dir.pwd ?
  end

  #borrowed from ActiveSupport
  def underscore(str)
    str.gsub(/::/, '/').
    gsub(/([A-Z]+)([A-Z][a-z])/,'\1_\2').
    gsub(/([a-z\d])([A-Z])/,'\1_\2').
    tr("-", "_").
    downcase
  end

  def original_name
    'UsualSuspects'
  end

  def find_and_replace_in_file(fname, find, replace)
    temp_file = Tempfile.new('usual_suspects')
    File.open(fname, 'r').each do |line|
      temp_file.puts substitute(line, find, replace)
    end
    temp_file.close # require to ensure file is written
    replace_file(temp_file.path, fname)
  ensure
    temp_file.unlink if temp_file
  end


  def rename_application(new_name)
    list_of_files.each do |fname|
      f = expanded_file_name(fname)
      find_and_replace_in_file(f, original_name, new_name)
      find_and_replace_in_file(f, underscore(original_name), underscore(new_name))
    end
  end
end
