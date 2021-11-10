# frozen_string_literal: true

require 'rails_helper'

describe 'customers api' do
  it 'sends a list of customers' do
    Subscription.destroy_all
    Customer.destroy_all
    Tea.destroy_all

    customer1 = create(:customer, first_name: 'Jacob',
                                  last_name: 'McGuire',
                                  email: 'brewer512@gmail.com',
                                  address: '33 Lilah Ln, Denver, CO 80111')
    create_list(:customer, 2)

    headers = { CONTENT_TYPE: 'application/json', Accept: 'application/json' }
    get '/api/v1/customers', headers: headers

    expect(response).to be_successful

    json = JSON.parse(response.body, symbolize_names: true)

    expect(json[:data].length).to eq(3)

    expect(json[:data].first[:id]).to be_a String
    expect(json[:data].first[:id]).to eq(customer1.id.to_s)

    expect(json[:data].first[:type]).to be_a String
    expect(json[:data].first[:type]).to eq('customer')

    expect(json[:data].first[:attributes]).to be_a Hash
    expect(json[:data].first[:attributes].length).to eq(4)

    expect(json[:data].first[:attributes][:first_name]).to be_a String
    expect(json[:data].first[:attributes][:first_name]).to eq('Jacob')
    expect(json[:data].first[:attributes][:last_name]).to be_a String
    expect(json[:data].first[:attributes][:last_name]).to eq('McGuire')
    expect(json[:data].first[:attributes][:email]).to be_a String
    expect(json[:data].first[:attributes][:email]).to eq('brewer512@gmail.com')
    expect(json[:data].first[:attributes][:address]).to be_a String
    expect(json[:data].first[:attributes][:address]).to eq('33 Lilah Ln, Denver, CO 80111')
  end
end
