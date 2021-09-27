class ValuationController < ApplicationController
  @@valid_faces = ['A', '2', '3', '4', '5', '6', '7', '8', '9', '10', 'J', 'Q', 'K']
  @@valid_suits = ['H', 'D', 'C', 'S']
  @@face_to_value_conversion = {
    '2' => 2,
    '3' => 3,
    '4' => 4,
    '5' => 5,
    '6' => 6,
    '7' => 7,
    '8' => 8,
    '9' => 9,
    '10' => 10,
    'J' => 11,
    'Q' => 12,
    'K' => 13,
    'A' => 14
  }

  def input; end

  def answer
    cards = params['q'].strip.upcase
    @cards_array = cards.split(' ').map do |card|
      case card.length
      when 2
        { face: card[0], suit: card[1] }
        # handles the edge case where 10 is input as face, meaning we can't use the first index only
        # incorrect values are filtered out later in the cards_valid? function
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
    return false if cards_array.any? { |card| card == 'input invalid' }
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
      return false unless @@valid_faces.include?(card[:face])
      return false unless @@valid_suits.include?(card[:suit])

      true
    end
  end

  def no_duplicates?(cards_array)
    cards_array.length == cards_array.uniq.length
  end

  def rank_hand(cards_array)
    # Many functions only need the sorted face value of the card - we extract this to its own, simpler array
    sorted_face_value_only_cards_array = cards_array.map { |card| @@face_to_value_conversion[card[:face]] }.sort
    # The order of these is important - we check from most valued to least valued hands, stopping if we get a match
    return 'Straight Flush' if straight_flush?(cards_array, sorted_face_value_only_cards_array)
    return 'Four of a Kind' if four_of_a_kind?(sorted_face_value_only_cards_array)
    return 'Full House' if full_house?(sorted_face_value_only_cards_array)
    return 'Straight' if straight_without_flush?(cards_array, sorted_face_value_only_cards_array)
    return 'Flush' if flush_without_straight?(cards_array, sorted_face_value_only_cards_array)
    return 'Three of a Kind' if three_of_a_kind?(sorted_face_value_only_cards_array)
    return 'Two pair' if two_pair?(sorted_face_value_only_cards_array)
    return 'One pair' if one_pair?(sorted_face_value_only_cards_array)

    'High card'
  end

  def straight_flush?(cards_array, sorted_face_value_only_cards_array)
    straight?(sorted_face_value_only_cards_array) && flush?(cards_array)
  end

  def four_of_a_kind?(sorted_face_value_only_cards_array)
    longest_number_chain(sorted_face_value_only_cards_array) == 4
  end

  def full_house?(sorted_face_value_only_cards_array)
    longest_number_chain(sorted_face_value_only_cards_array) == 3 && sorted_face_value_only_cards_array.uniq.length == 2
  end

  # The or statement handles the edge case of ace being low
  def straight?(sorted_face_value_only_cards_array)
    sorted_face_value_only_cards_array.each_cons(2).all? { |first_card, second_card| second_card == first_card + 1 } || sorted_face_value_only_cards_array == [1, 2, 3, 4, 5]
  end

  def flush?(cards_array)
    cards_array.all? { |card| card[:suit] == cards_array[0][:suit] }
  end

  # We need to know whether a flush is excluded, otherwise testing just for a straight could mean either a straight flush or a straight
  def straight_without_flush?(cards_array, sorted_face_value_only_cards_array)
    straight?(sorted_face_value_only_cards_array) && !flush?(cards_array)
  end

  def flush_without_straight?(cards_array, sorted_face_value_only_cards_array)
    flush?(cards_array) && !straight?(sorted_face_value_only_cards_array)
  end

  def three_of_a_kind?(sorted_face_value_only_cards_array)
    longest_number_chain(sorted_face_value_only_cards_array) == 3 && sorted_face_value_only_cards_array.uniq.length == 3
  end

  def two_pair?(sorted_face_value_only_cards_array)
    longest_number_chain(sorted_face_value_only_cards_array) == 2 && sorted_face_value_only_cards_array.uniq.length == 3
  end

  def one_pair?(sorted_face_value_only_cards_array)
    longest_number_chain(sorted_face_value_only_cards_array) == 2 && sorted_face_value_only_cards_array.uniq.length == 4
  end

  def longest_number_chain(array)
    prev_number = array[0]
    longest_chain = 0
    current_chain = 0
    array.each do |val|
      if prev_number == val
        current_chain += 1
        longest_chain = current_chain if current_chain > longest_chain
      else
        current_chain = 1
      end
      prev_number = val
    end
    longest_chain
  end
end
