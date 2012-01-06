# Get ready to kick ass.
require 'sinatra'
require 'sass'
require 'compass'
require 'rdiscount'

configure do
  Compass.add_project_configuration(File.join(Sinatra::Application.root, 'config', 'compass.config'))
end

configure :production do
  # require 'newrelic_rpm'
end

get '/' do
  erb :index
end

get '/stylesheets/:name.css' do
  content_type 'text/css', :charset => 'utf-8'
  scss(:"stylesheets/#{params[:name]}", Compass.sass_engine_options )
end

get '/:category' do
  content_type 'text/html', :charset => 'utf-8'
  markdown ("articles/"+params[:category]).to_sym, :layout => :secondary, :layout_engine => :erb
end

get '/:category/:name' do
  content_type 'text/html', :charset => 'utf-8'
  markdown ("articles/"+params[:category]+"/"+params[:name]).to_sym, :layout => :tertiary, :layout_engine => :erb,
    :locals => { :category => params[:category], :name => params[:name] }
end