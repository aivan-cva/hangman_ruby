contents = File.readlines('google_10000.txt')
words = []

contents.each do |word|
  words << word if word.length >= 5 and word.length <= 12
end


words.each do |word|
  File.write("words_5_12.txt", word, mode: "a")
end
