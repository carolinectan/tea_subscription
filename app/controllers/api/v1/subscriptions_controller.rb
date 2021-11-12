# frozen_string_literal: true

class Api::V1::SubscriptionsController < ApplicationController
  def index
    customer_subscriptions = Customer.find(params[:customer_id]).subscriptions

    render json: SubscriptionSerializer.new(customer_subscriptions), status: :ok
  rescue ActiveRecord::RecordNotFound
    invalid_credentials
  end

  def create
    customer = Customer.find(params[:customer_id])
    tea = Tea.find(params[:tea_id])

    if !params[:title] || !params[:price] || !params[:frequency]
      render json: {
        message: 'Your request could not be completed.',
        errors: ['All attributes are required.']
      }, status: :bad_request
    elsif subscription = Subscription.new(subscription_params)

      if subscription.save
        render json: SubscriptionSerializer.new(subscription), status: :created
      else
        render json: {}, status: :bad_request
      end
    end
  rescue ActiveRecord::RecordNotFound
    invalid_credentials
  end

  def update
    subscription = Subscription.find(params[:id])
    subscription.update!(status: params[:status])

    render json: SubscriptionSerializer.new(subscription), status: :ok
  rescue ActiveRecord::RecordNotFound
    invalid_credentials
  end

  private

  def subscription_params
    params.require(:subscription).permit(:customer_id, :tea_id, :title, :price, :frequency)
  end
end
