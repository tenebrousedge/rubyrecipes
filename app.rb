require 'sinatra'
require 'sinatra/activerecord'
require 'rake'
require 'sinatra/activerecord/rake'
require 'pry-byebug'
require 'rubyrecipes'

if development?
  require 'sinatra/reloader'
  also_reload('**/*.rb')
end

# Rack app for this project
class RubyrecipesApp < Sinatra::Application
  def params
    super.symbolize
  end

  before do
    @imodel = Rubyrecipes::Ingredient
    @tmodel = Rubyrecipes::Tag
    @rmodel = Rubyrecipes::Recipe
    @listmodel = Rubyrecipes::Ilist
  end
  get('/') do
    erb(:index)
  end

  get '/ingredients' do
    @ingredients = @imodel.all
    erb :ingredients
  end

  post '/ingredients' do
    data = params.fetch(:ingredient)
    @imodel.create(data)
    redirect '/ingredients'
  end

  get '/ingredients/new' do
    erb :new_ingredient
  end

  get '/ingredients/:id' do
    @ingredient = @imodel.find(params.fetch(:id))
    erb :ingredient
  end

  patch '/ingredients/:id' do
    new_data = params.fetch(:ingredient)
    id = params.fetch(:id)
    @imodel.update(id, new_data)
    redirect '/ingredients/' + id
  end

  delete '/ingredients/:id' do
    @imodel.destroy(params.fetch(:id))
    redirect '/ingredients'
  end

  get '/:ingredient/recipes' do
    @recipes = @imodel.find_by(name: params.fetch(:ingredient)).recipes
    erb :recipes
  end

  get '/tags' do
    @tags = @tmodel.all
    erb :tags
  end

  post '/tags' do
    data = params.fetch :tag
    @tmodel.create(data)
    redirect '/tags'
  end

  get '/tags/new' do
    erb :new_tag
  end

  get '/tags/:id' do
    @tag = @tmodel.find(params.fetch(:id))
    erb :tag
  end

  patch '/tags/:id' do
    new_data = params.fetch(:tag)
    id = params.fetch(:id)
    @tmodel.update(id, new_data)
    redirect '/tags/' + id
  end

  delete '/tags/:id' do
    @tmodel.destroy(params.fetch(:id))
    redirect 'tags'
  end

  get '/recipes' do
    @recipes = @rmodel.all
    erb :recipes
  end

  get '/recipes/new' do
    @tags = @tmodel.all
    @ingredients = @imodel.all
    erb :new_recipe
  end

  post '/recipes' do
    data = params.fetch :recipe
    tags = params[:tag]
    ings = params.fetch :ingredient
    recipe = @rmodel.create(data)
    recipe.tags << @tmodel.find(tags.map { |e| e[:id] }) unless tags.nil?
    recipe.ilists << @listmodel.create(ings)
    redirect '/recipes'
  end

  get '/recipes/:id' do
    @recipe = @rmodel.find(params.fetch(:id))
    @tags = @tmodel.all
    @ingredients = @imodel.all
    erb :recipe
  end

  patch '/recipes/:id' do
    new_data = params.fetch(:recipe)
    id = params.fetch :id
    @rmodel.update id, new_data
    redirect '/recipes/' + id
  end

  delete '/recipes/:id' do
    @rmodel.destroy(params.fetch(:id))
    redirect '/recipes'
  end

  get '/recipes/by/rating' do
    @recipes = @rmodel.best
    erb :recipes
  end

  get '/recipes/by/ingredient' do
    @ingredients = @imodel.all
    erb :recipes_by_ingredient
  end

  get '/tagged' do
    @tags = @tmodel.all
    erb :recipes_by_tag
  end

  get('/search') do
    @recipes = @rmodel.where('name ILIKE ?', "%#{params.fetch(:q)}%")
    erb :recipes
  end

  run! if app_file == $PROGRAM_NAME
end
require_relative 'helpers/rating'
