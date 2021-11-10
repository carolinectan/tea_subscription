# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

include FactoryBot::Syntax::Methods

Subscription.destroy_all
Customer.destroy_all
Tea.destroy_all

# Customers
customer1 = create(:customer, first_name: 'Amanda')
customer2 = create(:customer, first_name: 'Jacob')
customer3 = create(:customer, first_name: 'Carina')
customer4 = create(:customer, first_name: 'Caroline')
customer5 = create(:customer, first_name: 'Brian')
