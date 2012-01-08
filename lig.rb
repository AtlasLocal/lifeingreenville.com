# Get ready to kick ass.
require 'sinatra'
require 'sass'
require 'compass'
require 'rdiscount'
require "sinatra/reloader" if development?

require './models/article'
require './models/category'

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

get '/visit' do
  content_type 'text/html', :charset => 'utf-8'
  params[:category] = 'visit'
  set :ignore_header, true
  erb :visit, :layout => false
end

get '/:category' do
  content_type 'text/html', :charset => 'utf-8'
  articles = Article.find_all(params[:category])
  category = Category.find(params[:category])
  if articles.any?
    markdown '',
      :layout => :secondary, :layout_engine => :erb,
      :locals => { :category => category, :articles => articles, :data => category.metadata }
  else
    raise Sinatra::NotFound
  end
end

get '/:category/:name' do
  content_type 'text/html', :charset => 'utf-8'
  article = Article.find(params[:category], params[:name])
  category = Category.find(params[:category])
  if article
    markdown article.body,
      :layout => :tertiary, :layout_engine => :erb,
      :locals => { :category => category, :article => article, :data => article.metadata }
  else
    raise Sinatra::NotFound
  end
end

not_found do
  '404 Error, oops!'
end

error do
  '500 Error, ugh'
end

helpers do
  
  def render_aside
  	if File.exist?("views/articles/#{params[:category]}/#{params[:name]}.md")
      html = '<aside class="row span4">'
	    if params[:name]
	      html << '<div class="sidenav">'
	      html << '<h3>See Also</h3>'
	      # need a loop here. still learning so not sure how to do it.
	      html << "<a href='/#{params[:category]}'>#{params[:category]}</a>"
	      html << "</div>"
	    end
	    if File.exist?("views/asides/#{params[:category]}/#{params[:name]}.md")
	      html << markdown("asides/#{params[:category]}/#{params[:name]}".to_sym)
	    end
      html << '</aside>'
    end
  end
  
  def render_breadcrumb
    html = '<a href="/">Home</a>'
    if params[:name]
      html << " / <a href='/#{params[:category]}'>#{params[:category].capitalize}</a>"
      html << " / <span class='active'>#{params[:name].capitalize}</span>"
    elsif params[:category]
      html << " / <span class='active'>#{params[:category].capitalize}</span>"
    end
  end
  
end
