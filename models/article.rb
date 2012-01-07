class Article
  attr_reader :body, :metadata
  
  def self.parse(file)
    # d = File.join(Dir.pwd, "views/#{file}.md")
    contents = File.open(file).read
  # rescue Errno::ENOENT
    # raise Sinatra::NotFound
  # else
    first_paragraph, remaining = contents.split(/\r?\n\r?\n/, 2)
    # metadata = CaseInsensitiveHash.new
    metadata = Hash.new
    if metadata?(first_paragraph)
      first_paragraph.split("\n").each do |line|
        key, value = line.split(/\s*:\s*/, 2)
        metadata[key.downcase.to_sym] = value.chomp
      end
    end
    markup = metadata?(first_paragraph) ? remaining : contents
    # return {:metadata => metadata, :markup => markup}
    self.new(markup, metadata)
  end
  
  def self.find(catetory, name)
    parse( get_path_for(category, name) )
  end
  
  def self.find_all(category)
    articles = []
  
    Dir[get_path_for(category)].each do |f|
      # /Users/seangaffney/Sites/Sinatra/lifeingreenville.com/views/articles/life/example.md
      # file = f.split('views/').last.split('.md').first
      # article = parse_file(file)
      article = Article.parse(f)
      articles << article
    end
    
    articles
  end
  
  def initialize(body, metadata = {})
    @body = body
    @metadata = metadata
  end
  
  def [](meta)
    @metadata.fetch(meta)
  end
  
  def title
    @title ||= @metadata[:title] || 'Untitled'
  end
  
  def title?
    @metadata[:title].present?
  end
  
  def description
    @description ||= @metadata[:description]
  end
  
  def description?
    @metadata[:description].present?
  end
  
  protected
    
    def self.metadata?(text)
      text.split("\n").first =~ /^[\w ]+:/
    end
    
    def self.get_path_for(category, name = nil)
      if name
        File.join(Dir.pwd, "views/articles/#{category}/#{name}.md")
      else
        File.join(Dir.pwd, "views/articles/#{category}/**")
      end
    end
    
    
end
