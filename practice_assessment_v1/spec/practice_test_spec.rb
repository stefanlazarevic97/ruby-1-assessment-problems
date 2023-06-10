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

describe "#factorials_rec" do
  it "returns first factorial number" do
    expect(factorials_rec(1)).to eq([1])
  end

  it "returns first two factorial numbers" do
    expect(factorials_rec(2)).to eq([1, 1])
  end

  it "returns many factorials numbers" do
    expect(factorials_rec(6)).to eq([1, 1, 2, 6, 24, 120])
  end

  it "calls itself recursively" do
    expect(self).to receive(:factorials_rec).at_least(:twice).and_call_original
    factorials_rec(6)
  end
end

describe "Array#median" do
  let(:even_array) { [3, 2, 6, 7] }
  let(:odd_array) { [3, 2, 6, 7, 1] }

  it "returns nil for the empty array" do
    expect([].median).to be_nil
  end

  it "returns the element for an array of length 1" do
    expect([1].median).to eq(1)
  end

  it "returns the median of an odd-length array" do
    expect(odd_array.median).to eq(3)
  end

  it "returns the median of an even-length array" do
    expect(even_array.median).to eq(4.5)
  end
end

describe "#titleize" do
  it "capitalizes a word" do
    expect(titleize("jaws")).to eq("Jaws")
  end

  it "capitalizes every word (aka title case)" do
    expect(titleize("david copperfield")).to eq("David Copperfield")
  end

  it "doesn't capitalize 'little words' in a title" do
    expect(titleize("war and peace")).to eq("War and Peace")
  end

  it "does capitalize 'little words' at the start of a title" do
    expect(titleize("the bridge over the river kwai")).to eq("The Bridge over the River Kwai")
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

describe "Hash#my_each" do
  let(:a) { {"a"=> 1, "b" => 2, "c" => 3} }
  let(:res) { Array.new }

  before(:each) do
    expect(a).not_to receive(:each)
    expect(a).not_to receive(:dup)
    expect(a).not_to receive(:slice)
    expect_any_instance_of(Hash).not_to receive(:each_with_index)
    expect_any_instance_of(Hash).not_to receive(:map)
    expect_any_instance_of(Hash).not_to receive(:map!)
  end

  it "should call the proc on each key value pair" do
    a.my_each{ |key, v| v.times{res << key} }
    expect(res.sort).to eq(["a","b","b","c","c","c"])
  end

  it "should not modify the hash" do 
    a.my_each { |key, v| v.times { res << key } }
    expect(a).to eq({ "a"=> 1, "b" => 2, "c" => 3 })
  end

  it "should return the original hash" do 
    expect(a.my_each{ |key, v| v.times { res << key } }).to eq(a)
  end

  it "should be chainable" do 
    a.my_each do |k,v|
      v.times { res << k }
    end.my_each do |k,v|
      v.times { res << k }
    end
    expect(res).to eq(["a","b","b","c","c","c","a","b","b","c","c","c"])
  end 
end

describe "Array#my_quick_sort" do
  let(:array) { [1, 2, 3, 4, 5, 6, 7].shuffle }
  let(:sorted) { [1, 2, 3, 4, 5, 6, 7] }

  before(:each) do
    expect_any_instance_of(Array).not_to receive(:sort)
    expect_any_instance_of(Array).not_to receive(:sort!)
    expect_any_instance_of(Array).not_to receive(:sort_by!)
  end

  it "works with an empty array" do 
    expect([].my_quick_sort).to eq([])
  end

  it "works with an array of one number" do 
    expect([5].my_quick_sort).to eq([5])
  end

  it "sorts numbers" do
    expect(array.my_quick_sort).to eq(sorted)
  end

  it "sorts arrays with duplicates" do
    expect([17,10,10,9,3,3,2].my_quick_sort).to eq([2,3,3,9,10,10,17])
  end

  it "will use block if given" do
    reversed = array.my_quick_sort do |num1, num2|
      num2 <=> num1
    end
    expect(reversed).to eq([7, 6, 5, 4, 3, 2, 1])
  end
end

