require 'fileutils'

dirname = ARGV[0]
ruby_version = ARGV[1] || RUBY_VERSION
config_file = 'new-project-creator.projects'

module TextFileUtils

  def self.overwrite(filename, text)
    File.open(filename, 'w') { |f| f.write(text) }
    puts "A new file #{filename} was created"
  rescue
    puts "Something goes wrong, file #{filename} was not created."
  end

  def self.append(filename, text)
    File.open(filename, 'a') { |f| f.write(text) }
    puts "The file #{filename} was updated."
  rescue
    puts "Something goes wrong, file #{filename} was not updated."
  end

end

directories = Dir.entries('.').select { |entry| File.directory? entry }

begin
  projects = IO.readlines(config_file).collect { |line| line.chomp.split('@') }
rescue Errno::ENOENT
  TextFileUtils.overwrite(config_file, '')
  projects = []
end

projects_to_delete = projects.select { |entry| !directories.include?(entry[1]) }

projects_to_delete.each do |version, gemset|
  system("rvm #{version} do rvm --force gemset delete #{gemset}")
end

projects -= projects_to_delete

config_text = ''
projects.each do |version, gemset|
  config_text << (version + '@' + gemset + "\n")
end
TextFileUtils.overwrite config_file, "#{config_text}"

begin
  FileUtils.mkdir dirname, verbose: true
rescue Errno::EEXIST
  puts "Failed to create the directory (the directory with that name already exists). The script will be terminated"
  exit
rescue TypeError
  puts "No project name was given. Nothing to do. The script will be terminated."
  exit
end

FileUtils.cd("./#{dirname}", verbose: true) do
  TextFileUtils.overwrite ".ruby-version", "ruby-#{ruby_version}\n"
  TextFileUtils.overwrite ".ruby-gemset", "#{dirname}\n"
  TextFileUtils.overwrite "Gemfile", "source 'https://rubygems.org'\n\nruby \"#{ruby_version}\"\n"
end

TextFileUtils.append config_file, "#{ruby_version}@#{dirname}\n"
