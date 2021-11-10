require 'rails_helper'

RSpec.describe Subscription, type: :model do
  describe 'relationships' do
    it { should belong_to(:customer) }
    it { should belong_to(:tea) }
  end

  describe 'validations' do
    it { should validate_presence_of(:title) }

    it { should validate_presence_of(:price) }
    it { should validate_numericality_of(:price) }

    it { should define_enum_for(:status).with_values(['active', 'cancelled']) }

    it { should define_enum_for(:frequency).with_values(['monthly', 'quarterly']) }
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
      @subscription = create(:subscription)
    end

    it 'is valid with attributes' do
      expect(@subscription).to be_valid

      expect(@subscription.title).to be_a String
      expect(@subscription.price).to be_a Numeric
      expect(@subscription.status).to be_a String
      expect(@subscription.frequency).to be_a String

      expect(@subscription.customer).to be_a Customer
      expect(@subscription.tea).to be_a Tea
    end
  end
end
