module Peek
  class ResultsController < ApplicationController
    respond_to :json

    def show
      if request.xhr?
        render :json => Peek.adapter.get(params[:request_id])
      else
        render :nothing => true, :status => :not_found
      end
    end
  end
end
