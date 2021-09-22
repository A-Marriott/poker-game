class ValuationController < ApplicationController
  def input
  end

  def answer
    @cards = params["response"]
    @cards = @cards.strip.upcase
    if validate_input(@cards)
      @response = 'all good'
    else
      @response = 'fail'
    end
  end

  private

  def validate_input(cards)
    cards_array = cards.split(' ')
    return false unless correct_number_of_cards?(cards_array)

    true
  end

  def correct_number_of_cards?(cards_array)
    cards_array.length == 5
  end
end
