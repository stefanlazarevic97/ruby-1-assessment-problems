# Using recursion and the `is_a?` method, write an `Array#deep_dup` method that 
# will perform a "deep" duplication of the interior arrays.

def deep_dup(arr)
    arr.map { |ele| ele.is_a?(Array) ? deep_dup(ele) : ele.dup }
end

# Write a recursive method that returns the first "num" factorial numbers in
# ascending order. Note that the 1st factorial number is 0!, which equals 1.  
# The 2nd factorial is 1!, the 3rd factorial is 2!, etc.

def factorials_rec(num)
    return [1] if num == 1
    factorials = factorials_rec(num - 1)
    factorials << factorials[-1] * (num - 1)
    factorials
end

# Write an `Array#median` method that returns the median element in an array.
# If the length is even, return the average of the middle two elements.

class Array
    def median
        return nil if self.empty?
        sorted = self.sort
        sorted.length.even? ? (sorted[sorted.length / 2] + sorted[(sorted.length / 2) - 1]) / 2.0 : sorted[sorted.length / 2]
    end
end

# Define a method `titleize(title)` that capitalizes each word in a string like 
# a book title.  First word in a title should always be capitalized.  Do not 
# capitalize words like 'a', 'and', 'of', 'over' or 'the'.

def titleize(title)
    lowercase = ["a", "and", "of", "over", "the"]
    new_title = []
    
    title.split.each_with_index do |word, i|
        if i == 0
            new_title << word.capitalize
        elsif i != 0 && lowercase.include?(word) 
            new_title << word
        else 
            new_title << word.capitalize
        end
    end
    
    new_title.join(" ")
end

# Write an `Array#my_each(&prc)` method that calls a proc on each element.
# **Do NOT use the built-in `Array#each`, `Array#each_with_index`, or 
# `Array#map` methods in your implementation.**

class Array
    def my_each(&prc)
        i = 0

        while i < self.length
            prc.call(self[i])
            i += 1
        end

        self
    end
end

# Write a `Hash#my_each(&prc)` that calls a proc on each key, value pair.
# **Do NOT use the built-in `Hash#each`, `Hash#map`, `Hash#each_with_index` 
# methods in your implementation.**

class Hash
    def my_each(&prc)
        i = 0

        while i < keys.length
            prc.call(keys[i], self[keys[i]])
            i += 1
        end

        self
    end
end

# Define a method `Array#quick_sort` that implements the quick sort method. 
# The method should be able to accept a block. **Do NOT use the built-in
# `Array#sort` or `Array#sort_by` methods in your implementation.**

class Array
    def my_quick_sort(&prc)
        prc ||= Proc.new { |a, b| a <=> b }
        return self if self.length < 2
        
        pivot = self[0]
        left = self[1..-1].select { |ele| prc.call(ele, pivot) == -1 }
        right = self[1..-1].select { |ele| prc.call(ele, pivot) != -1 }
        left.my_quick_sort(&prc) + [pivot] + right.my_quick_sort(&prc)
    end  
end

