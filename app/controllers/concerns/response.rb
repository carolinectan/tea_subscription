# frozen_string_literal: true

module Response
  def invalid_credentials
    render json: {
      message: 'Your request could not be completed.',
      errors: ['Invalid credentials.']
    }, status: :bad_request
  end

  def missing_attributes
    render json: {
      message: 'Your request could not be completed.',
      errors: ['All attributes are required.']
    }, status: :bad_request
  end
end
