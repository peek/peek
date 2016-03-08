class HomeController < ApplicationController
  def enabled
    @peek_enabled = true
    render :show
  end

  def disabled
    @peek_enabled = false
    render :show
  end
end
