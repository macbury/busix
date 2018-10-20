module Api
  class LocalesController < ApplicationController
    def show
      render json: I18n::JS.export
    end
  end
end