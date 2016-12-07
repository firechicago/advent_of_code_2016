raw_data = File.readlines(ARGV[0])

# looks for ABBA pattern (not counting AAAA)
abba_regex = /(\w)(?!\1)(\w)\2\1/
# looks for ABBA pattern within brackets
abba_in_brackets = /\[[^\]]*(\w)(?!\1)(\w)\2\1.*\]/

count = 0
raw_data.map do |str|
  if str.match(abba_regex) && !str.match(abba_in_brackets)
    count += 1
  end
end
puts count
