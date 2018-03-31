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
eng_vowels = {}
('a'..'z').each_with_index do |char, ind|
  eng_vowels[char] = ind + 1 if ['a', 'e', 'i', 'o', 'u', 'y'].include?(char)
end
puts eng_vowels
