class Api::V1::CustomerSubscriptionsController < ApplicationController
  def index
    customer_subscriptions = Customer.find(params[:customer]).subscriptions

    render json: CustomerSubscriptionsSerializer.new(customer_subscriptions), status: :ok
  end
end
