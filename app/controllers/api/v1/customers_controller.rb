class Api::V1::CustomersController < ApplicationController
  def index
    customers = Customer.all

    render json: CustomerSerializer.new(customers), status: :ok
  end
  # def show
  #
  # end
  # def new
  #
  # end
  # def create
  #
  # end
  # def edit
  #
  # end
  # def update
  #
  # end
  # def destroy
  #
  # end
  # private
  # def _params
  #   params.permit(:)
  # end
end
