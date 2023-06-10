gem 'rspec'
require 'practice_test'
describe "#deep_dup" do
  subject(:robot_parts) do [
      ["nuts", "bolts", "washers"],
      ["capacitors", "resistors", "inductors"]
    ]
  end
  let(:copy) { deep_dup(robot_parts) }

  it "makes a copy of the original array" do
    expect(copy).to eq(robot_parts)
    expect(copy).not_to be(robot_parts)
  end

  it "deeply copies arrays" do
    expect(copy[0]).to eq(robot_parts[0])
    expect(copy[0]).not_to be(robot_parts[0])

    copy[1] << "LEDs"
    expect(robot_parts[1]).to eq(["capacitors", "resistors", "inductors"])
  end
end

describe '#fibs_sum' do
  it 'returns the sum of the first fibonacci number' do
    expect(fibs_sum(1)).to eq(1)
  end

  it 'returns the sum of the first 2 fibonacci numbers' do
    expect(fibs_sum(2)).to eq(2)
  end

  it 'returns the sum of the first 6 fibonacci numbers' do
    expect(fibs_sum(6)).to eq(20)
  end

  it "calls itself recursively" do 
    expect(self).to receive(:fibs_sum).at_least(:twice).and_call_original
    fibs_sum(6)
  end
end

describe "Array#two_sum" do
  it "returns positions of pairs of numbers that add to zero" do
    expect([5, 1, -7, -5].two_sum).to eq([[0, 3]])
  end

  it "finds multiple pairs" do
    expect([5, -1, -5, 1].two_sum).to eq([[0, 2], [1, 3]])
  end

  it "finds pairs with same element" do
    expect([5, -5, -5].two_sum).to eq([[0, 1], [0, 2]])
  end

  it "returns [] when no pair is found" do
    expect([5, 5, 3, 1].two_sum).to eq([])
  end

  it "won't find spurious zero pairs" do
    expect([0, 1, 2, 3].two_sum).to eq([])
  end

  it "will find real zero pairs" do
    expect([0, 1, 2, 0].two_sum).to eq([[0, 3]])
  end
end

describe "#anagrams" do
  before(:each) do
    expect_any_instance_of(Array).not_to receive(:sort)
    expect_any_instance_of(Array).not_to receive(:sort!)
    expect_any_instance_of(Array).not_to receive(:sort_by)
    expect_any_instance_of(Array).not_to receive(:sort_by!)
  end

  it "returns true if words are anagrams" do
    expect(anagrams('abc', 'cba')).to be true
  end

  it "returns false if words are not anagrams" do
    expect(anagrams('abc', 'aba')).to be false 
  end
  
  it "does not count words with same letters but varying lengths as anagrams" do
    expect(anagrams('abc', 'cbaa')).to be false
  end

  it "can handle large words with letters extremely scrambled" do
    expect(anagrams('aiuwehfxzxcvmneowieurahsde', 'nsewceaerihfawzueouxdihmxv')).to be true
    expect(anagrams('aiuwehfxzxcvmneowieurahsde', 'nsewceaerihfawzueouxdihmxw')).to be false
  end
end

describe "Array#my_each" do
  let(:arr) { [1,2,3] }
  let(:res) { Array.new }

  before(:each) do
    expect(arr).not_to receive(:each)
    expect(arr).not_to receive(:map)
    expect(arr).not_to receive(:dup)
    expect(arr).not_to receive(:slice)
    expect_any_instance_of(Array).not_to receive(:each_with_index)
    expect_any_instance_of(Array).not_to receive(:map!)
  end

  it "works for blocks" do
    arr.my_each { |el| res << 2 * el }
    expect(res).to eq([2,4,6])
  end

  it "does not modify original array" do 
    arr.my_each { |el| res << 2 * el }
    expect(arr).to eq([1,2,3])
  end

  it "should return the original array" do 
    return_val = arr.my_each { |el| el } 
    expect(return_val).to eq(arr)
  end

  it "should be chainable" do 
    arr.my_each do |el| 
      res << 2 * el
    end.my_each do |el|
      res << 3 * el 
    end

    expect(res).to eq([2,4,6,3,6,9])
  end
end

describe 'Array#my_all' do
  let(:arr) { [1,2,3] }
  
  before(:each) do
    expect(arr).not_to receive(:all?)
    expect(arr).not_to receive(:dup)
  end

  it "returns true if all elements match the block" do
    expect(arr.my_all? { |num| num > 0 }).to eq(true)
  end

  it "returns false if not all elements match the block" do
    expect(arr.my_all? { |num| num > 1 }).to eq(false)
  end
end

describe "Array#merge_sort" do
  let(:array) { [1, 2, 3, 4, 5].shuffle }

  it "works with an empty array" do
    expect([].merge_sort).to eq([])
  end

  it "works with an array of one item" do
    expect([1].merge_sort).to eq([1])
  end

  before(:each) do
    expect_any_instance_of(Array).not_to receive(:sort)
    expect_any_instance_of(Array).not_to receive(:sort!)
    expect_any_instance_of(Array).not_to receive(:sort_by!)
  end

  it "sorts numbers" do
    expect(array.merge_sort).to eq([1,2,3,4,5])
  end

  it "will use block if given" do
    reversed = array.merge_sort do |num1, num2|
      # reverse order
      num2 <=> num1
    end
    expect(reversed).to eq([5, 4, 3, 2, 1])
  end

  it "does not modify original" do
    duped_array = array.dup
    duped_array.merge_sort
    expect(duped_array).to eq(array)
  end

  it "calls the merge helper method" do
    expect(Array).to receive(:merge).at_least(:once).and_call_original
    array.merge_sort
  end
end

