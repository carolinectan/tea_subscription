# frozen_string_literal: true

require 'rails_helper'

describe 'customer subscriptions api' do
  it 'sends a list of customers' do
    Subscription.destroy_all
    Customer.destroy_all
    Tea.destroy_all

    customer1 = create(:customer, first_name: 'Jacob',
                                  last_name: 'McGuire',
                                  email: 'brewer512@gmail.com',
                                  address: '33 Lilah Ln, Denver, CO 80111')
    create_list(:customer, 2)
    create_list(:subscription, 2, status: 'active', customer: customer1)
    create_list(:subscription, 2, status: 'cancelled', customer: customer1)

    headers = { CONTENT_TYPE: 'application/json', Accept: 'application/json' }
    get "/api/v1/customers/#{customer1.id}/subscriptions", headers: headers

    expect(response).to be_successful

    json = JSON.parse(response.body, symbolize_names: true)

    expect(json[:data].length).to eq(4)

    expect(json[:data].first[:id].to_i).to be_an Integer
    expect(json[:data].first[:type]).to be_a String
    expect(json[:data].first[:type]).to eq('customer_subscriptions')
    expect(json[:data].first[:attributes][:customer_id]).to be_an Integer
    expect(json[:data].first[:attributes][:tea_id]).to be_an Integer
    expect(json[:data].first[:attributes][:title]).to be_a String
    expect(json[:data].first[:attributes][:price].to_i).to be_a Numeric
    expect(json[:data].first[:attributes][:status]).to be_a String
    expect(json[:data].first[:attributes][:frequency]).to be_a String
    expect(json[:data].first[:attributes][:created_at]).to be_a String
    expect(json[:data].first[:attributes][:updated_at]).to be_a String
  end
end
