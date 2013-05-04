module Peek
  class ResultsController < ActionController::Base
    respond_to :json

    def show
      render :json => Peek.get(params[:request_id])
    end
  end
end
