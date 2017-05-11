require 'spec_helper'

RSpec.describe Rubyrecipes do
  it 'has a version number' do
    expect(Rubyrecipes::VERSION).not_to be nil
  end

  it 'does something useful' do
    expect(true).to eq(true)
  end

  describe Rubyrecipes::Ingredient, type: :model do
    it { should have_many(:recipes).through(:ilists)}
  end

  describe Rubyrecipes::Recipe, type: :model do
    it { should have_many(:ingredients).through(:ilists)}
  end
end
