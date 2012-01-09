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
  # user placeholder until launch, use home route to test home page
  erb :placeholder, :layout => false
  # erb :index
end

get '/home' do
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

get '/credits' do
  content_type 'text/html', :charset => 'utf-8'
  params[:category] = 'credits'
  set :ignore_header, true
  erb :credits, :layout => false
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
  set :ignore_header, true
  params[:category] = 'not-found'
  erb :'404'
end

error do
  '500 Error, ugh'
end

helpers do
  
  def render_aside
  	if File.exist?("views/articles/#{params[:category]}/#{params[:name]}.md")
      html = '<aside class="row span4">'
      
      # put together the sub nav for other articles in this category
	    if params[:name]
	      html << '<div class="sidenav">'
	      html << '<h3>See Also</h3>'
        articles = Article.find_all(params[:category])
        html << '<ul>'
        articles.each do |a|
          title = a[:title].gsub('<br>', '')
          unless a[:slug] == params[:name]
            html << "<li><a href='/#{params[:category]}/#{a[:slug]}'>#{title}</a></li>"
          else
            html << "<li><span>#{title}</span></li>"
          end
        end
        html << '</ul>'
        html << '</div>'
	    end
      
      # get the Aside content
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
