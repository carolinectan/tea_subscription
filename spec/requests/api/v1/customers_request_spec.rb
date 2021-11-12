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

  describe 'get a customer' do
    describe 'happy path' do
      it 'sends a specific customer' do
        Subscription.destroy_all
        Customer.destroy_all
        Tea.destroy_all

        customer1 = create(:customer, first_name: 'Lily',
                                      last_name: 'Potter',
                                      email: 'magic22@gmail.com',
                                      address: '300 Arapahoe Ave, Boulder, CO 80302')
        create_list(:customer, 2)

        headers = { CONTENT_TYPE: 'application/json', Accept: 'application/json' }
        get "/api/v1/customers/#{customer1.id}", headers: headers

        expect(response).to be_successful

        json = JSON.parse(response.body, symbolize_names: true)

        expect(json[:data].length).to eq(3)

        expect(json[:data][:id]).to be_a String
        expect(json[:data][:id]).to eq(customer1.id.to_s)

        expect(json[:data][:type]).to be_a String
        expect(json[:data][:type]).to eq('customer')

        expect(json[:data][:attributes]).to be_a Hash
        expect(json[:data][:attributes].length).to eq(4)

        expect(json[:data][:attributes][:first_name]).to be_a String
        expect(json[:data][:attributes][:first_name]).to eq('Lily')
        expect(json[:data][:attributes][:last_name]).to be_a String
        expect(json[:data][:attributes][:last_name]).to eq('Potter')
        expect(json[:data][:attributes][:email]).to be_a String
        expect(json[:data][:attributes][:email]).to eq('magic22@gmail.com')
        expect(json[:data][:attributes][:address]).to be_a String
        expect(json[:data][:attributes][:address]).to eq('300 Arapahoe Ave, Boulder, CO 80302')
      end
    end

    describe 'sad path' do
      it 'throw an error if customer is not found' do
        Subscription.destroy_all
        Customer.destroy_all
        Tea.destroy_all

        headers = { CONTENT_TYPE: 'application/json', Accept: 'application/json' }
        get '/api/v1/customers/7777', headers: headers

        expect(response).to_not be_successful
        expect(response.status).to eq(400)

        json = JSON.parse(response.body, symbolize_names: true)

        expect(json.length).to eq(2)

        expect(json[:message]).to be_a String
        expect(json[:message]).to eq('Your request could not be completed.')
        expect(json[:errors]).to be_an Array
        expect(json[:errors].first).to eq('Invalid credentials.')
      end
    end
  end
end
