require 'rails_helper'

RSpec.describe Tea, type: :model do
  describe 'relationships' do
    it { should have_many(:subscriptions) }
    it { should have_many(:customers).through(:subscriptions) }
  end

  describe 'validations' do
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:description) }
    it { should validate_presence_of(:temperature) }
    it { should validate_numericality_of(:temperature) }
    it { should validate_presence_of(:brew_time) }
    it { should validate_numericality_of(:brew_time) }
  end

  # before :each do
  #
  # end
  #
  # describe 'class methods' do
  #   describe '.' do
  #   end
  # end
  #
  # describe 'instance methods' do
  #   describe '#' do
  #   end
  # end

  describe 'factory bot creation' do
    before(:all) do
      @tea = create(:tea)
    end

    it 'is valid with attributes' do
      expect(@tea).to be_valid

      expect(@tea.title).to be_a String
      expect(@tea.description).to be_a String
      expect(@tea.temperature).to be_a Numeric
      expect(@tea.brew_time).to be_a Numeric
    end
  end
end
