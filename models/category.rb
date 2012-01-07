class Category
  
  # :description, :subtitle, :banner_image
  
  def self.parse(file)
    contents = File.open(file).read
    
    metadata = Hash.new
    if contents
      contents.split("\n").each do |line|
        key, value = line.split(/\s*:\s*/, 2)
        metadata[key.downcase.to_sym] = value.chomp
      end
    end
    name = file.split('articles/').last
    
    self.new(name, metadata)
  rescue Errno::ENOENT
    return nil
  end
  
  def self.find(name)
    parse( get_path_for(name) )
  end
  
  def intitialize(name, metadata)
    @name = name
    @metadata = metadata
  end
  
  def [](meta)
    @metadata.fetch(meta)
  end
  
  protected
    
    def self.get_path_for(category)
      if File.exists?( File.join(Dir.pwd, "views/articles/#{name}/.metadata.yml") )
        File.join(Dir.pwd, "views/articles/#{category}/.metadata.yml")
      end
    end
  
end