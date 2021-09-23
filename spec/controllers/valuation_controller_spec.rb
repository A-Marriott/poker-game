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

    describe '#valid_input?' do
      it 'should return true when passed an array of objects containing 5 combinations of valid face-card combination' do
        ary = [{ face: 'A', suit: 'H' }, { face: 'J', suit: 'S' }, { face: '5', suit: 'D' }, { face: '10', suit: 'C' }, { face: 'J', suit: 'H' }]
        expect(subject.send(:valid_input?, ary)).to be true
      end
    end
  end

  context 'hand ranking methods' do
    describe '#longest_number_chain' do
      it 'should return an integer containing the longest number of consecutive numbers in a presorted array' do
        expect(subject.send(:longest_number_chain, [1, 1, 2, 2, 2, 3, 100])).to eq(3)
      end
    end

    describe '#four_of_a_kind?' do
      it 'should return true when 4 of the 5 elements in an presorted array match' do
        expect(subject.send(:four_of_a_kind?, [10, 10, 10, 10, 20])).to be true
      end

      it 'should return false when less there is no match of 4 elements in a presorted array' do
        expect(subject.send(:four_of_a_kind?, [1, 2, 2, 2, 5])).to be false
      end
    end

    describe '#full_house?' do
      it 'should return true when three elements of a presorted array match, and the other two elements match' do
        expect(subject.send(:full_house?, [2, 2, 2, 3, 3])).to be true
      end

      it 'should return false when three elements of a presorted array match, and the other two elements do not match' do
        expect(subject.send(:full_house?, [2, 2, 2, 3, 4])).to be false
      end
    end

    describe '#straight?' do
      it 'should return true when a consecutive presorted array of numbers is passed' do
        expect(subject.send(:straight?, [7, 8, 9, 10, 11])).to be true
      end

      it 'should return false when a non-consecutive presorted array of numbers is passed' do
        expect(subject.send(:straight?, [7, 8, 9, 10, 10])).to be false
      end
    end

    describe '#flush?' do
      it 'should return true when passed an array of objects with matching suit values' do
        ary = [{ face: 'A', suit: 'H' }, { face: 'J', suit: 'H' }, { face: '5', suit: 'H' }, { face: '10', suit: 'H' }, { face: '2', suit: 'H' }]
        expect(subject.send(:flush?, ary)).to be true
      end

      it 'should return false when passed an array of objects without matching suit values' do
        ary = [{ face: 'A', suit: 'H' }, { face: 'J', suit: 'H' }, { face: '5', suit: 'H' }, { face: '10', suit: 'C' }, { face: '2', suit: 'H' }]
        expect(subject.send(:flush?, ary)).to be false
      end
    end

    describe '#straight_flush?' do
      it 'should return true if all elements of a numbers array match, and when passed an array of objects with matching suit values' do
        cards_ary = [{ face: 'A', suit: 'H' }, { face: 'J', suit: 'H' }, { face: '5', suit: 'H' }, { face: '10', suit: 'H' }, { face: '2', suit: 'H' }]
        numbers_ary = [3, 4, 5, 6, 7]
        expect(subject.send(:straight_flush?, cards_ary, numbers_ary)).to be true
      end
    end

    describe '#three_of_a_kind?' do
      it 'should return true if a presorted array contains three matching elements and two unique other elements' do
        expect(subject.send(:three_of_a_kind?, [3, 3, 3, 4, 10])).to be true
      end

      it 'should return false if a presorted array contains three matching elements and two matching other elements' do
        expect(subject.send(:three_of_a_kind?, [3, 3, 3, 4, 4])).to be false
      end

      it 'should return false if a presorted array contains less than three matching elements' do
        expect(subject.send(:three_of_a_kind?, [2, 3, 3, 4, 4])).to be false
      end
    end

    describe '#two_pair?' do
      it 'should return true if a presorted array contains two matches of two elements, and the final element is unique' do
        expect(subject.send(:two_pair?, [2, 2, 3, 3, 5])).to be true
      end

      it 'should return false if a presorted array contains one matches of two elements, and the final three elements are unique' do
        expect(subject.send(:two_pair?, [2, 2, 3, 4, 5])).to be false
      end
    end

    describe '#one_pair?' do
      it 'should return true if a presorted array contains one match of two elements, and the other three elements are unique' do
        expect(subject.send(:one_pair?, [2, 2, 3, 4, 5])).to be true
      end
    end
  end

  context 'get answer' do
    it 'returns Invalid hand if a random string is passed' do
      get 'answer', params: { q: 'hello' }
      assert_equal 'Invalid hand', assigns(:response)
    end

    it 'returns Straight FLush if a string of 5 cards worth a straight flush is entered' do
      get 'answer', params: { q: '8C 9C 10C JC QC' }
      assert_equal 'Straight Flush', assigns(:response)
    end
  end
end
