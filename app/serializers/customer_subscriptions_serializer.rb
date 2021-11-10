# frozen_string_literal: true
class CustomerSubscriptionsSerializer
  include JSONAPI::Serializer

  attributes :customer_id, :tea_id, :title, :price, :status, :frequency, :created_at, :updated_at
end
