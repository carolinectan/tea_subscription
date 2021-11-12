# frozen_string_literal: true

class Api::V1::CustomersController < ApplicationController
  def index
    customers = Customer.all

    render json: CustomerSerializer.new(customers), status: :ok
  end

  def show
    customer = Customer.find(params[:id])

    render json: CustomerSerializer.new(customer), status: :ok
  rescue ActiveRecord::RecordNotFound
    invalid_credentials
  end
end
