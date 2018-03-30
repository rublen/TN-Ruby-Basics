puts "--- Task 2 ---"
p (10..100).step(5).to_a

puts "--- Task 3 ---"
fibo = [1, 1]
i = 1

while fibo[i] < 100 - fibo[i-1]
  fibo[i+1] = fibo[i] + fibo[i-1]
  i += 1
end

p fibo

puts "--- Task 4 ---"
alphabet = ('a'..'z').to_a
eng_vowels = {'a' => alphabet.index('a') + 1,
              'e' => alphabet.index('e') + 1,
              'i' => alphabet.index('i') + 1,
              'o' => alphabet.index('o') + 1,
              'u' => alphabet.index('u') + 1,
              'y' => alphabet.index('y') + 1
            }
puts eng_vowels
