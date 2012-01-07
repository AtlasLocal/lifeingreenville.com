# Get ready to kick ass.
require 'sinatra'
require 'sass'
require 'compass'
require 'rdiscount'
require "sinatra/reloader" if development?

configure do
  Compass.add_project_configuration(File.join(Sinatra::Application.root, 'config', 'compass.config'))
end

configure :production do
  # require 'newrelic_rpm'
end

before do
  set :ignore_header, false
end

get '/' do
  set :ignore_header, true
  erb :index
end

get '/stylesheets/:name.css' do
  content_type 'text/css', :charset => 'utf-8'
  scss(:"stylesheets/#{params[:name]}", Compass.sass_engine_options )
end

get '/:category' do
  content_type 'text/html', :charset => 'utf-8'
  # markdown '', :layout => :secondary, :layout_engine => :erb
  articles = get_articles(params[:category])
  markdown '',
    :layout => :secondary, :layout_engine => :erb,
    :locals => { :category => params[:category], :name => params[:name], :articles => articles }
end

get '/:category/:name' do
  content_type 'text/html', :charset => 'utf-8'
  article = parse_file("articles/"+params[:category]+"/"+params[:name])
  markdown article[:markup],
    :layout => :tertiary, :layout_engine => :erb,
    :locals => { :category => params[:category], :name => params[:name] }.merge( article[:metadata] )
end

helpers do
  
  # class Article
  #   attr_accessor :metadata, :markup
  # end
  
  def parse_file(file)
    d = File.join(Dir.pwd, "views/#{file}.md")
    contents = File.open(d).read
  # rescue Errno::ENOENT
    # raise Sinatra::NotFound
  else
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
    return {:metadata => metadata, :markup => markup}
  end
  
  def get_articles(cat)
    articles = []
  
    Dir[File.join(Dir.pwd, "views/articles/#{cat}/**")].each do |f|
      # /Users/seangaffney/Sites/Sinatra/lifeingreenville.com/views/articles/life/example.md
      file = f.split('views/').last.split('.md').first
      article = parse_file(file)
      articles << article
    end
    
    articles
  end
  
  private
  
    def metadata?(text)
      text.split("\n").first =~ /^[\w ]+:/
    end
  
end


