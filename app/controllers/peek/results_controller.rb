module Peek
  class ResultsController < ApplicationController
    before_action :restrict_non_access

    def show
      respond_to do |format|
        format.json do
          if request.xhr?
            render json: Peek.adapter.get(params[:request_id])
          else
            render nothing: true, status: :not_found
          end
        end
      end
    end

    private

    def restrict_non_access
      unless peek_enabled?
        raise ActionController::RoutingError.new('Not Found')
      end
    end
  end
end
