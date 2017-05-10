require 'rubyrecipes/version'

# Namespace module for Rubyrecipes
module Rubyrecipes
  class Recipe < ActiveRecord::Base
    has_and_belongs_to_many :ingredients
    has_and_belongs_to_many :tags
  end

  class Ingredient < ActiveRecord::Base
    has_and_belongs_to_many :recipes
  end

  class Tag < ActiveRecord::Base
    has_and_belongs_to_many :recipes
  end
end
