
class File
  EXTENSIONS = YAML.load_file(File.dirname(__FILE__) + '/mime_types.yml').symbolize_keys
  
  def self.mime_type?(file)
    if file.class == File
      EXTENSIONS[File.extname(file.path).gsub('.','').to_sym]
    elsif file.class == String
      mime = File.extensions[(file[file.rindex('.')+1, file.size]).to_sym]
      if mime
        return mime
      else 
        'unknown/unknown' 
      end
    else
      'unknown/unknown'
    end
  end
  
  def self.extensions
    EXTENSIONS
  end
  
end