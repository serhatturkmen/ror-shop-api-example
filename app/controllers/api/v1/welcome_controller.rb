class Api::V1::WelcomeController < ApplicationController
  def index
    render json: {
      result: 'Preparing document'
    }
  end
end