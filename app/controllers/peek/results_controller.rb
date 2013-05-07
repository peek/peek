module Peek
  class ResultsController < ApplicationController
    respond_to :json

    def show
      render :json => Peek.adapter.get(params[:request_id])
    end
  end
end
