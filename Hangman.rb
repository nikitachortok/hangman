names_filename = "./names.txt"


def load_words(names_filename)
  dictionary = File.open(names_filename) {|f| f.readlines}
  dictionary.map!{ |word| word.upcase.strip }
  dictionary.select! {|word| word.length >= 5 && word.length <= 12}
  dictionary
end

def select_random(arr)
  arr.sample
end

def display_secret_word(word_array)
  word_array.each {|c| print c + " "}
end

def create_secret_word(word)
  Array.new(word.length) { "_" }
end

def check_user_guess(word, secret_array, guess, num_of_guesses)
  match_found = false
  word_array = word.split("")
  word_array.each_with_index do |letter, index|

    if letter == guess && secret_array[index] != (letter)
      secret_array[index] = letter
      match_found = true
    elsif secret_array[index] == letter
    end
  end
  match_found
end

def get_user_guess
  print(" Enter your guess: ")
  gets.chomp.upcase
end

def check_winning(word, secret_word_array)
  word.split("") == secret_word_array
end

def end_game(word, secret_word_array)
  if check_winning(word, secret_word_array)
    puts "YOU WIN"
  else
    print " You want to see the word ? "
    choice = gets.chomp
    puts choice == "y" ? word : "Goodbye!"
  end
end

num_of_guesses = 12
num_of_tries = 0
names = load_words(names_filename)
word = select_random(names)
secret_word_array = create_secret_word(word)

while (num_of_guesses > 0)
  guess = get_user_guess
  if guess == "SS"
    db = {num_of_guesses: num_of_guesses, num_of_tries: num_of_tries, word: word, secret_word_array: secret_word_array}
  elsif check_user_guess(word, secret_word_array, guess, num_of_guesses)
    puts " [✓] You found #{secret_word_array.count(guess)} matches!"
    display_secret_word(secret_word_array)
  else
    num_of_guesses -= 1
    puts " [X] No match for '#{guess}'. You have #{num_of_guesses} guesses left!"
  end

  if check_winning(word, secret_word_array)
    puts "", " [!] YOU WIN!"
    puts " [!] You guessed the word in #{num_of_tries} tries!"
    break
  end
  num_of_tries += 1
end

end_game(word, secret_word_array)
