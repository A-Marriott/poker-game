require 'rails_helper'

describe ValuationController do
  it 'sends params in a method call' do
    get 'answer', params: { q: 'hello' }
    assert_equal 'Invalid hand', assigns(:response)
  end

  it 'tests a private method' do
    expect(subject.send(:correct_number_of_cards?, [0, 0, 0, 0, 1])).to be true
  end
end
