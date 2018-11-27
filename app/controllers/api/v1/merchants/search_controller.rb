module Api
  module V1
    module Merchants
      class SearchController < ApplicationController
        def show
            render json: Merchant.params[:id]
        end
      end
    end
  end
end
