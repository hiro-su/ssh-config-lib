path = "ssh/config"
Dir.glob(File.join(File.dirname(__FILE__), "config/*")) do |file| 
  if File::ftype(file) == "directory"
    basename = File.basename file
    require File.join(path, basename, "#{basename}.rb")
  end
end                           
require File.join(path, "version")
