module Response
  def invalid_credentials
    render json: {
      message: 'Your request could not be completed.',
      errors: ['Invalid credentials.']
    }, status: :bad_request
  end
end
