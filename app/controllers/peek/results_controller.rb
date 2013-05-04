module Peek
  class ResultsController < ApplicationController
    respond_to :json

    def show
      render :json => Peek::Request.get(params[:request_id])
    end
  end
end
