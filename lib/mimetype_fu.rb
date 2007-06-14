class File

  def self.mime_type?(file)
    if file.class == File
      mime = ::EXTENSIONS[File.extname(file.path).gsub('.','').to_sym]
    elsif file.class == String
      mime = EXTENSIONS[(file[file.rindex('.')+1, file.size]).to_sym]
    end

    if mime
      return mime
    else 
      'unknown/unknown' 
    end
  end
  
  def self.extensions
    EXTENSIONS
  end
  
end