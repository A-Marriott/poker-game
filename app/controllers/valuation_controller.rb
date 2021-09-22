class ValuationController < ApplicationController
  @@valid_faces = ['A', '2', '3', '4', '5', '6', '7', '8', '9', '10', 'J', 'Q', 'K']
  @@valid_suits = ['H', 'D', 'C', 'S']
  @@face_to_number_sequence = {
    'A': 1,
    '2': 2,
    '3': 3,
    '4': 4,
    '5': 5,
    '6': 6,
    '7': 7,
    '8': 8,
    '9': 9,
    '10': 10,
    'J': 11,
    'Q': 12,
    'K': 13
  }

  def input; end

  def answer
    @cards = params['response'].strip.upcase
    @cards_array = @cards.split(' ').map! do |card|
      case card.length
      when 2
        { face: card[0], suit: card[1] }
      when 3
        { face: card[0..1], suit: card[2] }
      else
        'input invalid'
      end
    end

    return @response = 'Invalid hand' unless valid_input?(@cards_array)

    @response = rank_hand(@cards_array)
  end

  private

  def valid_input?(cards_array)
    return false if cards_array[0] == 'input invalid'
    return false unless correct_number_of_cards?(cards_array)
    return false unless cards_valid?(cards_array)
    return false unless no_duplicates?(cards_array)

    true
  end

  def correct_number_of_cards?(cards_array)
    cards_array.length == 5
  end

  def cards_valid?(cards_array)
    cards_array.all? do |card|
      return false if @@valid_faces.exclude?(card[:face])
      return false if @@valid_suits.exclude?(card[:suit])

      true
    end
  end

  def no_duplicates?(cards_array)
    cards_array.length == cards_array.uniq.length
  end

  def rank_hand(cards_array)
    return 'Straight Flush' if straight_flush?(cards_array)

    'nice!'
  end

  def straight_flush?(cards_array)
    # all cards must be same suit
  end
end
