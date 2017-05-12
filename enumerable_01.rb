# Enumerable Module

# the Enumerable mixin provides collection classes with traversal, searching and sort methods
# the class must provide a method each, which yields successive members of the collection
# if Enumerable#max, #min, or #sort is used, the objects in the collection must also
# implement a meaningful <=> operator, as these methods rely on an ordering between members of collection
=begin


#  all?
#  passes each element of the collection to given block
#  returns true if block never returns false or nil
p %w[ant bear cat].all? { |word| word.length >= 3 }  # returns true
p %w[ant bear cat].all? { |word| word.length >= 4 }  # returns false
#  if no block given adds implicit block of {|obj| obj} which will cause all?
#  to return true when none of the collection members are false or nil
p [nil, true, 99].all?     # returns false
p [].all?                  # returns true
p [true, "abc", 99].all?   # returns true



#  any?
#  returns true if block ever returns a value other than false or nil
p %w[ant bear cat].any? { |word| word.length >= 4 }   # returns true
p %w[ant bear cat].any? { |word| word.length >= 5 }   # returns false, no words longer than 5, so all false
#  if no block given, adds implicit block {|obj| obj} that will cause any?
#  to return true if at least one of collection is not false or nil
p [nil, false, 99].any?    # returns true
p [nil, false, ].any?      # returns false
p [].any?                  # returns false



#  chunk
#  enumerates over items chunking them together based on the return value of block
#  consecutive elements which return the same block value are chunked together
#  for ex: consecutive even nums and odd nums can be chunked as follows
[3,1,4,1,5,9,2,6,5,3,5].chunk { |n|
  n.even?
  }.each { |even, ary|
    p [even, ary]
  }
#  returns:
#  [false, [3, 1]]
#  [true, [4]]
#  [false, [1, 5, 9]]
#  [true, [2, 6]]
#  [false, [5, 3, 5]]

[1,4,7,10,2,6,15].chunk { |n|
  n > 5
  }.each { |val| p val }
#  returns:
#  [false, [1, 4]]
#  [true, [7, 10]]
#  [false, [2]]
#  [true, [6, 15]]

(1..44).chunk { |n| n % 11 == 0 }.each { |results, elements|
  puts "#{results}: #{elements * " - "}"   # the ( * " - " ) section after elements is optional, for formatting only
  }
#  returns:
#  false: 1 - 2 - 3 - 4 - 5 - 6 - 7 - 8 - 9 - 10
#  true: 11
#  false: 12 - 13 - 14 - 15 - 16 - 17 - 18 - 19 - 20 - 21
#  true: 22
#  false: 23 - 24 - 25 - 26 - 27 - 28 - 29 - 30 - 31 - 32
#  true: 33
#  false: 34 - 35 - 36 - 37 - 38 - 39 - 40 - 41 - 42 - 43
#  true: 44
=end
#  the following key values have special meaning:
#  nil and :_separator specifies that the elements should be dropped, can be used to ignore some elements
#  :_alone specifies that the element should be chunked by itself, can be used to force items into thier own chunks
#  any other symbols that begin with underscore will raise an error




