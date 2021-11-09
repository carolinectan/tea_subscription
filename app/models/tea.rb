class Tea < ApplicationRecord
  has_many :subscriptions
  has_many :customers, through: :subscriptions

  validates :title, presence: true
  validates :description, presence: true
  validates :temperature, presence: true, numericality: true
  validates :brew_time, presence: true, numericality: true
end
