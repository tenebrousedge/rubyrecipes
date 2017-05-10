require 'sinatra'
require 'sinatra/activerecord'
require 'rake'
require 'sinatra/activerecord/rake'
require 'pry-byebug'
if development?
  require 'sinatra/reloader'
  also_reload('**/*.rb')
end

# Rack app for this project
class RubyrecipesApp < Sinatra::Application
  get('/') do
    erb(:index)
  end

  run! if app_file == $PROGRAM_NAME
end
