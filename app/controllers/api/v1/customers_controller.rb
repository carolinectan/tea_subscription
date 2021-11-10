# frozen_string_literal: true

class Api::V1::CustomersController < ApplicationController
  def index
    customers = Customer.all

    render json: CustomerSerializer.new(customers), status: :ok
  end
end
