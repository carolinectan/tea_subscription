# frozen_string_literal: true

class Api::V1::SubscriptionsController < ApplicationController
  def index
    customer_subscriptions = Customer.find(params[:customer_id]).subscriptions

    render json: CustomerSubscriptionsSerializer.new(customer_subscriptions), status: :ok
  end
end
