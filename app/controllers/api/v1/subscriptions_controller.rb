# frozen_string_literal: true

class Api::V1::SubscriptionsController < ApplicationController
  def index
    customer_subscriptions = Customer.find(params[:customer_id]).subscriptions

    render json: SubscriptionSerializer.new(customer_subscriptions), status: :ok
  end

  def create
    Customer.find(params[:customer_id])
    Tea.find(params[:tea_id])
    subscription = Subscription.create!(subscription_params)

    render json: SubscriptionSerializer.new(subscription), status: :created
  end

  def update
    subscription = Subscription.find(params[:id])
    subscription.update!(status: params[:status])

    render json: SubscriptionSerializer.new(subscription), status: :ok
  end

  private

  def subscription_params
    params.require(:subscription).permit(:customer_id, :tea_id, :title, :price, :frequency)
  end
end
