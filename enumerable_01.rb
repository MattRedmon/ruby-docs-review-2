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

#  the following key values have special meaning:
#  nil and :_separator specifies that the elements should be dropped, can be used to ignore some elements
#  :_alone specifies that the element should be chunked by itself, can be used to force items into thier own chunks
#  any other symbols that begin with underscore will raise an error



#  chunk_while
#  creates an enumerator for each chunked element, beginnin chunks defined by blocks
#  this split method each chunk using adjacent elements, elt_before and elt_after in the reciever enum
#  the result enumerator yields the chunked elements as an array
#  format:   enum.chunk_while { |elt_before, elt_after| bool }.each { |ary| ..... }
a = [1,2,4,9,10,11,12,15,16,19,20,21]
b = a.chunk_while { |i, j| i + 1 == j }
p b.to_a   # returns [[1, 2], [4], [9, 10, 11, 12], [15, 16], [19, 20, 21]]
#  this method in Enumerable is not available in Ruby 2.2.4 which is what you are currently running



#  collect
#  returns a new array with the results of running block once for every element
#  if no block given, an enumerator is returned
p (1..5).collect { |i| i * i }  # returns [1, 4, 9, 16, 25]
p (1..4).collect { "cat" }      # returns ["cat", "cat", "cat", "cat"]
p (1..6).map { |i| i * i }      # returns [1, 4, 9, 16, 25, 36]
#  collect and map methods work the same way



#  collect_concat
#  returns a new array with the concatenated results of running block once for every element in enum
#  if no block given enumerator is returned
#  works much like map but it flattens any sub arrays before being returned
p [1,2,3,4].collect_concat { |e| [e, -e] }        # returns [1, -1, 2, -2, 3, -3, 4, -4]
p [[1,2],[3,4]].collect_concat { |e| e + [100] }  # returns [1, 2, 100, 3, 4, 100]
#  flat_map can be used in place of collect_collect
p [[1,2],[3,4]].flat_map { |e| e + [100] }        # returns [1, 2, 100, 3, 4, 100]



#  count
#  returns # of items in enum through enumeration
#  if arg given the # of items in enum that are equal to arg are given
#  if block is given counts # of elements yielding true value
ary = [1,2,4,2,5,2]
p ary.count                  # returns 6 -- total count in ary
p ary.count(2)               # returns 3 -- number of 2s in ary
p ary.count { |x| x%2 == 0 } # returns 4 -- number of even values


#  cycle
#  calls block for each element of enum repeatedly n times or forever if none or nil given
#  does nothing for non positive # or if collection is empty
#  returns nil if the loop has finished without getting interrupted
a = ['a','b','c']
# a.cycle { |x| puts x }     # prints a,b,c,a,b,c   forever
a.cycle(2) { |x| puts x }    # prints a,b,c,a,b,c   each on a new line



#  detect
#  passes each entry in enum to block
#  returns the first for which block is not false
#  if no object matches, calls ifnone and returns its result when it is specified
#  or returns nil otherwise
p (1..10).detect { |i| i % 5 == 0 and i % 7 == 0 }     # returns nil
p (1..10).find { |i| i % 5 == 0 and i % 7 == 0 }       # returns nil
p (1..100).detect { |i| i % 5 == 0 and i % 7 == 0 }    # returns 35
p (1..100).find { |i| i % 5 == 0 and i % 7 == 0 }      # returns 35



#  drop(n) --> array
#  drops first n element from enum and returns rest elements in an array
a = [1,2,3,4,5,0]
a.drop(3)      # returns [4,5,6]



#  drop_while { |obj| block } --> array
#  drops elements up to, but not including, the first element for which the block
#  returns nil or false and returns and array containing the remaining elements
a = [1,2,3,4,5,0]
p a.drop_while { |i| i < 3 }     # returns [3,4,5,0]
p a.drop_while { |i| i <= 3 }    # returns [4,5,0]



#  each_cons(3){ ..... }
#  iterate the given block for each array on consecutive <n> elements
(1..10).each_cons(3) { |a| p a }
#  returns:
#  [1, 2, 3]
#  [2, 3, 4]
#  [3, 4, 5]
#  [4, 5, 6]
#  [5, 6, 7]
#  [6, 7, 8]
#  [7, 8, 9]
#  [8, 9, 10]



#  each_slice(n) { ..... }
#  iterates the block for each slice of <n> elements
(1..10).each_slice(3) { |a| p a }
#  returns:
#  [1, 2, 3]
#  [4, 5, 6]
#  [7, 8, 9]
#  [10]



#  each_with_index
#  calls block with two args, the item and its index, for each item in enum
#  given args are passed through to each
hash = Hash.new
arr = ['cat', 'dog', 'wombat']
arr.each_with_index { |item, index|
  hash[item] = index
  }
p hash    # returns {"cat"=>0, "dog"=>1, "wombat"=>2}
=end


#  each_with_object
#  iterates the given block for each element with an arbitary ojbect given
#  and returns the initially given object
evens = (1..10).each_with_object([]) { |i, a| a << i * 2 }
p evens     # returns [2, 4, 6, 8, 10, 12, 14, 16, 18, 20]

letters = ['a','b','c','d','e'].each_with_object([]) { |i, a| a << i.upcase }
p letters   # returns ["A", "B", "C", "D", "E"]

#  the difference between below and above is that a string obj is passed as arg to each_with_object
#  on the one below while an array obj is passed to the one above
letters2 = ['a','b','c','d','e'].each_with_object("") { |i, a| a << i.upcase }
p letters2   # returns "ABCDE"
