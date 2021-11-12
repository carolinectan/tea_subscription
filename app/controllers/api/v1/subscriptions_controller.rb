# frozen_string_literal: true

class Api::V1::SubscriptionsController < ApplicationController
  def index
    customer_subscriptions = Customer.find(params[:customer_id]).subscriptions

    render json: SubscriptionSerializer.new(customer_subscriptions), status: :ok
  end

  def create
    subscription = Subscription.new(subscription_params)

    if subscription.save
      render json: SubscriptionSerializer.new(subscription), status: :created
    else
      render json: {}, status: :bad_request
    end
  end

  def update
    subscription = Subscription.find_by(subscription_params)
    subscription.update!(status: params[:status])

    render json: SubscriptionSerializer.new(subscription), status: :ok
  end

  private

  def subscription_params
    params.require(:subscription).permit(:customer_id, :tea_id, :title, :price, :frequency)
  end
end
