module Api
  class EdgesController < ApplicationController
    def index
      render json: Edge.all, root: false
    end
  end
end