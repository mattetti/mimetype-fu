# MimetypeFu
class MimeTypeFu
  
  def initialize(file)
    raise "couldn't load #{file}" unless File.exist?(file)
    @file = file
    @extensions = YAML.load_file(File.dirname(__FILE__) + '/mime_types.yml').symbolize_keys
  end
  
  def mime
    
    @extensions[File.extname(@file.path).gsub('.','').to_sym]
  end
  
end