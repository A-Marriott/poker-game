class ValuationController < ApplicationController
  def input
  end

  def answer
    @response = params["response"]
  end
end
