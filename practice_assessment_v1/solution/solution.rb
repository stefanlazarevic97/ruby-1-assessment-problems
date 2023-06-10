# Using recursion and the `is_a?` method, write an `Array#deep_dup` method that 
# will perform a "deep" duplication of the interior arrays.

  def deep_dup(arr)
    arr.map{ |el| el.is_a?(Array) ? deep_dup(el) : el }
  end

# Write a recursive method that returns the first "num" factorial numbers in
# ascending order. Note that the 1st factorial number is 0!, which equals 1.  
# The 2nd factorial is 1!, the 3rd factorial is 2!, etc.

def factorials_rec(num)
    return [1] if num == 1
    facs = factorials_rec(num - 1)
    facs << facs.last * (num - 1)
    facs
end

class Array
  # Write an `Array#median` method that returns the median element in an array.
  # If the length is even, return the average of the middle two elements.

  def median
    return nil if empty?
    sorted = self.sort
    if length.odd?
      sorted[length / 2]
    else
      (sorted[length / 2] + sorted[length / 2 - 1]).fdiv(2)
    end
  end  
end

# Define a method `titleize(title)` that capitalizes each word in a string like 
# a book title.  First word in a title should always be capitalized.  Do not 
# capitalize words like 'a', 'and', 'of', 'over' or 'the'.

LITTLE_WORDS = [
  "a",
  "and",
  "of",
  "over",
  "the"
].freeze

def titleize(title)
  words = title.split(" ")
  result_words = []
  idx = 0
  words.each do |word|
    if idx > 0 && LITTLE_WORDS.include?(word)
      result_words << word.downcase
    else
      result_words << word.capitalize
    end
    idx += 1
  end

  result_words.join(" ")
end

class Array
  # Write an `Array#my_each(&prc)` method that calls a proc on each element.
  # **Do NOT use the built-in `Array#each`, `Array#each_with_index`, or 
  # `Array#map` methods in your implementation.**
  
  def my_each(&prc)
    i = 0
    while i < self.length
      prc.call(self[i])
      i += 1
    end
    self
  end
end

class Hash
  # Write a `Hash#my_each(&prc)` that calls a proc on each key, value pair.
  # **Do NOT use the built-in `Hash#each`, `Hash#map`, `Hash#each_with_index` 
  # methods in your implementation.**
  
  def my_each(&prc)
    i = 0
    while i < keys.length
      prc.call(keys[i], self[keys[i]])
      i += 1
    end
    self
  end
end

class Array
  # Define a method `Array#quick_sort` that implements the quick sort method. 
  # The method should be able to accept a block. Do NOT use the built-in
  # `Array#sort` or `Array#sort_by` methods in your implementation.

  def my_quick_sort(&prc)
    prc ||= proc {|a, b| a<=>b}
    return self if size < 2

    pivot = first
    left = self[1..-1].select{|el| prc.call(el, pivot) == -1}
    right = self[1..-1].select{|el| prc.call(el, pivot) != -1}
    left.my_quick_sort(&prc) + [pivot] + right.my_quick_sort(&prc)
  end  
end

