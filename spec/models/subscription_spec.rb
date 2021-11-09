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
end
