# frozen_string_literal: true
require 'rails_helper'

RSpec.describe Customer, type: :model do
  describe 'relationships' do
    it { should have_many(:subscriptions) }
    it { should have_many(:teas).through(:subscriptions) }
  end

  describe 'validations' do
    it { should validate_presence_of(:first_name) }

    it { should validate_presence_of(:last_name) }

    it { should validate_presence_of(:email) }
    it { should validate_uniqueness_of(:email) }

    it { should validate_presence_of(:address) }
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
    before(:each) do
      @customer = create(:customer)
    end

    it 'is valid with attributes' do
      expect(@customer).to be_valid

      expect(@customer.first_name).to be_a String
      expect(@customer.last_name).to be_a String
      expect(@customer.email).to be_a String
      expect(@customer.address).to be_a String
    end
  end
end
