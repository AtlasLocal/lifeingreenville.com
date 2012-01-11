class Article
  attr_reader :body, :metadata
  
  def self.parse(file)
    contents = File.open(file, "r:UTF-8").read
    
    first_paragraph, remaining = contents.split(/\r?\n\r?\n/, 2)
    metadata = Hash.new
    if metadata?(first_paragraph)
      first_paragraph.split("\n").each do |line|
        key, value = line.split(/\s*:\s*/, 2)
        metadata[key.downcase.to_sym] = value.chomp
      end
    end
    markup = metadata?(first_paragraph) ? remaining : contents
    metadata[:path] = file
    metadata[:category] = file.split('articles/').last.split('/').first || file.split('articles/').last
    metadata[:slug] = file.split(metadata[:category]+'/').last.split('.md').first
    
    self.new(markup, metadata)
  rescue Errno::ENOENT
    return nil
  end
  
  def self.find(category, name)
    parse( get_path_for(category, name) )
  end
  
  def self.find_all(category)
    articles = []
  
    Dir[get_path_for(category)].each do |f|
      article = Article.parse(f)
      articles << article
    end
    
    articles.sort_by! { |a| a.title }
  end
  
  def initialize(body, metadata = {})
    @body = body
    @metadata = metadata
  end
  
  def [](meta)
    @metadata.fetch(meta)
  end
  
  def permalink
    '/' + @metadata[:category] + '/' + @metadata[:slug]
  end
  
  def title
    @title ||= @metadata[:title] || 'Untitled'
  end
  
  def title?
    @metadata[:title].present?
  end
  
  def description
    @description ||= @metadata[:category_tagline]
  end
  
  def description?
    @metadata[:category_tagline].present?
  end
  
  def category
    @category ||= Category.find(@metadata[:category])
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
