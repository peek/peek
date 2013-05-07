module Peek
  class ResultsController < ApplicationController
    before_filter :restrict_non_access
    respond_to :json

    def show
      if request.xhr?
        render :json => Peek.adapter.get(params[:request_id])
      else
        render :nothing => true, :status => :not_found
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
