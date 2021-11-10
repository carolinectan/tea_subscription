# frozen_string_literal: true
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).

include FactoryBot::Syntax::Methods

Subscription.destroy_all
Customer.destroy_all
Tea.destroy_all

# Customers
customer1 = create(:customer, first_name: 'Amanda')
customer2 = create(:customer, first_name: 'Jacob')
customer3 = create(:customer, first_name: 'Carina')
customer4 = create(:customer, first_name: 'Caroline')
customer5 = create(:customer, first_name: 'Brian') # no subscription

# Teas
tea1 = create(:tea, title: 'Sleepy time')
tea2 = create(:tea, title: 'Positive energy')
tea3 = create(:tea, title: 'Balance')
tea4 = create(:tea, title: 'Calming energy')
tea5 = create(:tea, title: 'Energizing')

# Subscriptions
subscription1 = create(:subscription, tea: tea1, customer: customer1)
subscription2 = create(:subscription, tea: tea2, customer: customer2)
subscription3 = create(:subscription, tea: tea3, customer: customer2)
subscription4 = create(:subscription, tea: tea4, customer: customer3)
subscription5 = create(:subscription, tea: tea5, customer: customer3)
subscription6 = create(:subscription, tea: tea4, customer: customer3)
subscription7 = create(:subscription, tea: tea5, customer: customer4)
