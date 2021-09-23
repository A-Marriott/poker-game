require 'rails_helper'

describe ValuationController do
  # it 'sends params in a method call' do
  #   get 'answer', params: { q: 'hello' }
  #   assert_equal 'Invalid hand', assigns(:response)
  # end

  # it 'tests a private method' do
  #   expect(subject.send(:correct_number_of_cards?, [0, 0, 0, 0, 1])).to be true
  # end

  context 'validation methods' do
    describe '#correct_number_of_cards?' do
      it 'should return true when passed 5 array elements' do
        expect(subject.send(:correct_number_of_cards?, [0, 0, 0, 0, 1])).to be true
      end

      it 'should return false when passed an array without 5 elements' do
        expect(subject.send(:correct_number_of_cards?, [0, 0])).to be false
      end
    end

    describe '#cards_valid?' do
      it 'should return true when passed an array of strings containing valid card-face combinations' do
        ary = []
        ['A', '2', '3', '4', '5', '6', '7', '8', '9', '10', 'J', 'Q', 'K'].each do |face|
          ['H', 'D', 'C', 'S'].each do |suit|
            ary << { face: face, suit: suit }
          end
        end
        expect(subject.send(:cards_valid?, ary)).to be true
      end

      it 'should return false when passed an array of random objects' do
        expect(subject.send(:cards_valid?, [{ face: 'hello', suit: 'word' }, { face: 'goodbye', suit: 'another word' }])).to be false
      end
    end

    describe '#no_duplicates?' do
      it 'should return true when passed an array without duplicates' do
        expect(subject.send(:no_duplicates?, [1, 2, 3])).to be true
      end

      it 'should return false when passed an array with duplicates' do
        expect(subject.send(:no_duplicates?, [1, 2, 2])).to be false
      end
    end
  end
end


#   def no_duplicates?(cards_array)
#     cards_array.length == cards_array.uniq.length
#   end

# an array with differing elements to return true
# an array with at least one duplicate element to return false

# valid_input?(cards_array)

# should return true when passed an array of 5 unique elements, each being a string referring to face and card (make it random)

# should return false when passed a random array




#   def longest_number_chain(array)

# Should return an integer containing the longest number of consecutive numbers in the array

#   def four_of_a_kind?(sorted_face_value_only_cards_array)

# Should return true when 4 of the five elements of a number array match
# Should return false when less than 4 elements match

#   def full_house?(sorted_face_value_only_cards_array)

# Should return true when three elements of an array match, and the other two elements match

# Should return false when three elements of an arrya match and the other two elements do not match

#   def straight?(sorted_face_value_only_cards_array)

# Should return true when consecutive array of numbers is passed
# false if non consecutive

#   def flush?(cards_array)

# Should return true when all values of an array of objects with key suit match
# false if not match

#   def straight_without_flush?(cards_array, sorted_face_value_only_cards_array)

# Should return true if all elements of a numbers array are consectuive but the suits do not match

# Should return false if numbers are consecutive and suits match

#   def straight_flush?(cards_array, sorted_face_value_only_cards_array)

# Should return true if all elements of a numbers array are consectuive and the suits  match

#   def flush_without_straight?(cards_array, sorted_face_value_only_cards_array)
#     flush?(cards_array) && !straight?(sorted_face_value_only_cards_array)
#   end

#   def three_of_a_kind?(sorted_face_value_only_cards_array)

# return true if one matche of three elements and other two elements are unique
# return false if not three matches
# return false if three matches and other two elements are the same

#   def two_pair?(sorted_face_value_only_cards_array)

# true if two matches of two elements each and final element is unique
# false if one match of two elements

#   def one_pair?(sorted_face_value_only_cards_array)

# true if one match of two elements and other three elements are unique

#   def rank_hand(cards_array)
#     sorted_face_value_only_cards_array = cards_array.map { |card| @@face_to_value_conversion[card[:face]] }.sort
#     return 'Straight Flush' if straight_flush?(cards_array, sorted_face_value_only_cards_array)
#     return 'Four of a Kind' if four_of_a_kind?(sorted_face_value_only_cards_array)
#     return 'Full House' if full_house?(sorted_face_value_only_cards_array)
#     return 'Straight' if straight_without_flush?(cards_array, sorted_face_value_only_cards_array)
#     return 'Flush' if flush_without_straight?(cards_array, sorted_face_value_only_cards_array)
#     return 'Three of a Kind' if three_of_a_kind?(sorted_face_value_only_cards_array)
#     return 'Two pair' if two_pair?(sorted_face_value_only_cards_array)
#     return 'One pair' if one_pair?(sorted_face_value_only_cards_array)

#     'High card'
#   end

# should return a string
# Should return
