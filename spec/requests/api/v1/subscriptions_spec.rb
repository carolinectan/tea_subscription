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
    expect(json[:data].first[:type]).to eq('subscription')
    expect(json[:data].first[:attributes][:customer_id]).to be_an Integer
    expect(json[:data].first[:attributes][:tea_id]).to be_an Integer
    expect(json[:data].first[:attributes][:title]).to be_a String
    expect(json[:data].first[:attributes][:price].to_i).to be_a Numeric
    expect(json[:data].first[:attributes][:status]).to be_a String
    expect(json[:data].first[:attributes][:frequency]).to be_a String
    expect(json[:data].first[:attributes][:created_at]).to be_a String
    expect(json[:data].first[:attributes][:updated_at]).to be_a String
  end

  it 'creates a subscription for a customer' do
    Subscription.destroy_all
    Customer.destroy_all
    Tea.destroy_all

    customer1 = create(:customer, first_name: 'James',
                                  last_name: 'Potter',
                                  email: 'skiguy89@gmail.com',
                                  address: '4288 Lily Circle, Aspen, CO 81611')
    create_list(:customer, 2)
    tea1 = create(:tea)

    headers = { CONTENT_TYPE: 'application/json', Accept: 'application/json' }
    # a subscriotion's default status is "active"
    request_body = {  "customer_id": customer1.id,
                "tea_id": tea1.id,
                "title": "Sleepy Time",
                "price": "6.99",
                "frequency": "monthly",
 }
    post "/api/v1/customers/#{customer1.id}/subscriptions", headers: headers, params: request_body.to_json

    expect(response).to be_successful
    expect(response.status).to eq(201)

    json = JSON.parse(response.body, symbolize_names: true)

    expect(json[:data].length).to eq(3)

    expect(json[:data][:id]).to be_a String
    expect(json[:data][:id]).to eq(Subscription.last.id.to_s)

    expect(json[:data][:type]).to be_a String
    expect(json[:data][:type]).to eq('subscription')

    expect(json[:data][:attributes]).to be_a Hash
    expect(json[:data][:attributes].length).to eq(8)

    expect(json[:data][:attributes][:customer_id]).to be_an Integer
    expect(json[:data][:attributes][:customer_id]).to eq(customer1.id)
    expect(json[:data][:attributes][:tea_id]).to be_an Integer
    expect(json[:data][:attributes][:tea_id]).to eq(tea1.id)
    expect(json[:data][:attributes][:title]).to be_a String
    expect(json[:data][:attributes][:title]).to eq('Sleepy Time')
    expect(json[:data][:attributes][:price]).to be_a String
    expect(json[:data][:attributes][:price]).to eq('6.99')
    expect(json[:data][:attributes][:status]).to be_a String
    expect(json[:data][:attributes][:status]).to eq('active')
    expect(json[:data][:attributes][:frequency]).to be_a String
    expect(json[:data][:attributes][:frequency]).to eq('monthly')
    expect(json[:data][:attributes][:created_at]).to be_a String
    expect(json[:data][:attributes][:updated_at]).to be_a String
  end
end
