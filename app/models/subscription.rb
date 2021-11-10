# frozen_string_literal: true

class Subscription < ApplicationRecord
  belongs_to :customer
  belongs_to :tea

  validates :title, presence: true
  validates :price, presence: true, numericality: true
  enum status: { 'active' => 0, 'cancelled' => 1 }
  enum frequency: { 'monthly' => 0, 'quarterly' => 1 }
end
