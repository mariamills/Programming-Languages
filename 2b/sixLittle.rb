class SixLittle
  # Constructor that initializes the instance variables to empty arrays
  def initialize
    @words = []
    @hints = []
    @tokens = []
  end

  def ask
    6.times do
      puts "Enter a word (at least 4 characters):"
      word = gets.chomp
      # Keep asking for a word UNTIL the word is at least 4 characters
      until word.length >= 4
        puts "Word too short. Enter a word (at least 4 letters):"
        word = gets.chomp
      end
      # Word was at least 4 characters, so ask for a hint for that word now
      puts "Enter a hint for this word:"
      hint = gets.chomp

      # Add the word and hint to the appropriate arrays (instance variables)
      @words << word.upcase
      @hints << hint.capitalize
    end
  end

  def prepare
    # for EACH word in the words array, do...
    @words.each do |word|
      # Split the word in half (rounding up if odd number of characters), always rounding up to be consistent
      mid = (word.length / 2.0).ceil
      # Uppercase the first half and the second half of the word and add them to the tokens array
      @tokens << word[0...mid].upcase
      @tokens << word[mid..-1].upcase
    end
    # Shuffle the tokens array
    @tokens = @tokens.shuffle
  end

  def display
    puts "Six Little Words (Ruby)"
    # Slice the tokens array into groups of 4, then for each group/slice, join the 4 tokens with a space and join the slices with a newline
    puts "Tokens:\n " + @tokens.each_slice(4).map { |slice| slice.join(' ') }.join("\n")

    puts "\nHints:"
    # For each hint in the hints array, print the hint
    @hints.each { |hint| puts hint }

    puts "\nAnswer Key:"
    # Slice the words array into groups of 3, then for each group/slice, join the 3 words with a space and join the slices with a newline
    puts @words.each_slice(3).map { |slice| slice.join(' ') }.join("\n")
  end

  def run
    # Call the methods, weird parenthesis aren't needed even with no arguments...
    ask
    prepare
    display
  end
end

# Create an new SixLittle object and call the run method of that object to start the program
six_little = SixLittle.new
six_little.run
