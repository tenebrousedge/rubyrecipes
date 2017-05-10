require 'rubyrecipes/version'

# Namespace module for Rubyrecipes
module Rubyrecipes
  class Recipe < ActiveRecord::Base
    has_many :ingredients, through: :ingredients_list
    has_many :ingredients_lists
    has_and_belongs_to_many :tags
    scope :best, -> { order(rating: :desc) }

    validates :name, :instructions, presence: true
    before_create :default_rating

    def default_rating
      rating = rating.to_f
      rating = 2.5 if rating.nil? || rating == 0
    end
  end

  class Ingredient < ActiveRecord::Base
    has_many :recipes, through: :ingredients_list
    validates :name, presence: true
  end

  class IngredientsList < ActiveRecord::Base
    self.table_name = 'ingredients_recipes'
    belongs_to :ingredient
    belongs_to :recipe
  end

  class Tag < ActiveRecord::Base
    has_and_belongs_to_many :recipes
    validates :name, presence: true
  end
end

# Adds a method to the Hash class.
#
# @note We're extending the global object because, hey, if Rails can do it...
class Hash
  # Recursively turns string hash keys to symbols.
  #
  # The key must respond to to_sym. So basically just strings.
  # @return A new hash with symbols instead of string keys.
  def symbolize
    # changing this to use responds_to? because it's more Ruby-ish
    # in Smalltalk-influenced OO languages method calls simply send a message
    # to the object the method is being called on
    # the idea of 'duck typing' is that we don't care if it *is* a duck
    # we just care if it quacks like one
    Hash[map { |k, v| [k.to_sym, v.respond_to?(:symbolize) ? v.symbolize : v] }]
  end
end
