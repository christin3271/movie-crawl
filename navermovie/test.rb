h = Hash.new
h[1] = 10
h[2] = 20
h[3] = 30
h["hello"] = 4
h["world"] = 8

@word = "hello"
word2 = "world"
# s = h.sort_by {|key, value| value}.reverse.to_h
#
# puts s.each { |key, value| puts value}
# puts s.each { |key, value| puts key}

# h.delete_if{ |k,v| v <= 25}

for i in 1..2
  if h.include?(@word + i)
    puts h[@word + i]
  end
end
