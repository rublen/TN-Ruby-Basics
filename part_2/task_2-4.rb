puts "\n--- Task 2 ---"
p (10..100).step(5).to_a

puts "\n--- Task 3 ---"
fibo = [1, 1]
i = 1

loop do
  i += 1
  fibo[i] = fibo[i - 2] + fibo[i - 1]
  break if fibo[i] + fibo[i - 1] > 100
end

p fibo

puts "\n--- Task 4 ---"
alphabet = ('a'..'z').to_a
eng_vowels = { 'a' => alphabet.index('a') + 1,
               'e' => alphabet.index('e') + 1,
               'i' => alphabet.index('i') + 1,
               'o' => alphabet.index('o') + 1,
               'u' => alphabet.index('u') + 1,
               'y' => alphabet.index('y') + 1 }
puts eng_vowels
