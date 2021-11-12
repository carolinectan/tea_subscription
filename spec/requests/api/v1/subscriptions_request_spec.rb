# frozen_string_literal: true

require 'rails_helper'

describe 'customer subscriptions api' do
  describe "a customer's subscriptions" do
    describe 'happy path' do
      it "sends a list of a customer's subscriptions" do
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
        expect(response.status).to eq(200)

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
    end

    describe 'sad path' do
      it 'throws an error if customer is not found' do
        Subscription.destroy_all
        Customer.destroy_all
        Tea.destroy_all

        customer1 = create(:customer, first_name: 'Helen',
                                      last_name: 'Georgia',
                                      email: 'mountainpeach@gmail.com',
                                      address: '877 Edelweiss Strasse, Helen, GA 30545')
        create_list(:customer, 2)
        create(:subscription, status: 'active', customer: customer1)
        create(:subscription, status: 'cancelled', customer: customer1)

        headers = { CONTENT_TYPE: 'application/json', Accept: 'application/json' }
        get '/api/v1/customers/99999/subscriptions', headers: headers

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

  describe 'create a subscription' do
    describe 'happy path' do
      it 'creates an active subscription for a customer' do
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
        # a subscription's default status is "active"
        request_body = {
          customer_id: customer1.id,
          tea_id: tea1.id,
          title: 'Sleepy Time',
          price: '6.99',
          frequency: 'monthly'
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

    describe 'sad path' do
      it 'throws an error if all required attributes are not in request' do
        Subscription.destroy_all
        Customer.destroy_all
        Tea.destroy_all

        customer1 = create(:customer, first_name: 'Lily',
                                      last_name: 'James',
                                      email: 'skiguy89@gmail.com',
                                      address: '654 Potter Road, Aspen, CO 81611')
        create_list(:customer, 2)
        tea1 = create(:tea)

        headers = { CONTENT_TYPE: 'application/json', Accept: 'application/json' }

        request_body = {
          customer_id: customer1.id,
          tea_id: tea1.id,
          title: 'Sleepy Time'
          # this examples does not include required attributes for customer_id, price, and frequency
        }
        post "/api/v1/customers/#{customer1.id}/subscriptions", headers: headers, params: request_body.to_json

        expect(response).to_not be_successful
        expect(response.status).to eq(400)

        json = JSON.parse(response.body, symbolize_names: true)

        expect(json.length).to eq(2)

        expect(json[:message]).to be_a String
        expect(json[:message]).to eq('Your request could not be completed.')
        expect(json[:errors]).to be_an Array
        expect(json[:errors].first).to eq('All attributes are required.')
      end

      it 'throws an error if customer does not exist' do
        Subscription.destroy_all
        Customer.destroy_all
        Tea.destroy_all

        tea1 = create(:tea)

        headers = { CONTENT_TYPE: 'application/json', Accept: 'application/json' }

        request_body = {
          customer_id: 88_888,
          tea_id: tea1.id,
          title: 'Sleepy Time'
          # this examples does not include required attributes for price and frequency
        }
        post "/api/v1/customers/#{request_body[:customer_id]}/subscriptions", headers: headers, params: request_body.to_json

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

  describe 'update a subscription' do
    describe 'happy path' do
      it "updates a customer's subscription's status to cancelled" do
        Subscription.destroy_all
        Customer.destroy_all
        Tea.destroy_all

        # Step 1: create a customer's subscription
        customer1 = create(:customer, first_name: 'Jack',
                                      last_name: 'John',
                                      email: 'jackjohn@gmail.com',
                                      address: '1212 30th St, Boulder, CO 80302')
        create_list(:customer, 2)
        tea1 = create(:tea)

        headers = { CONTENT_TYPE: 'application/json', Accept: 'application/json' }
        # a subscription's default status is "active"
        request_body = {
          customer_id: customer1.id,
          tea_id: tea1.id,
          title: 'Sleepy Time',
          price: '6.99',
          frequency: 'monthly'
        }
        post "/api/v1/customers/#{customer1.id}/subscriptions", headers: headers, params: request_body.to_json

        # Step 2: update a customer's subscription status to 'cancelled'
        headers = { CONTENT_TYPE: 'application/json', Accept: 'application/json' }
        request_body = {
          customer_id: customer1.id,
          tea_id: tea1.id,
          status: 'cancelled'
        }
        patch "/api/v1/customers/#{customer1.id}/subscriptions/#{Subscription.last.id}", headers: headers, params: request_body.to_json

        expect(response).to be_successful
        expect(response.status).to eq(200)

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
        expect(json[:data][:attributes][:status]).to eq('cancelled') # status updated to cancelled :)
        expect(json[:data][:attributes][:frequency]).to be_a String
        expect(json[:data][:attributes][:frequency]).to eq('monthly')
        expect(json[:data][:attributes][:created_at]).to be_a String
        expect(json[:data][:attributes][:updated_at]).to be_a String
      end
    end

    describe 'sad path' do
      it 'throws an error if the subscription does not exist' do
        Subscription.destroy_all
        Customer.destroy_all
        Tea.destroy_all

        # Step 1: create a customer's subscription
        customer1 = create(:customer, first_name: 'Jack',
                                      last_name: 'John',
                                      email: 'jackjohn@gmail.com',
                                      address: '1212 30th St, Boulder, CO 80302')
        create_list(:customer, 2)
        tea1 = create(:tea)

        headers = { CONTENT_TYPE: 'application/json', Accept: 'application/json' }
        request_body = {
          customer_id: customer1.id,
          tea_id: tea1.id,
          status: 'cancelled'
        }
        patch "/api/v1/customers/#{customer1.id}/subscriptions/999999", headers: headers, params: request_body.to_json

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
