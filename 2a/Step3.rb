# Number Guessing Game
# Author: Maria Mills 01/22/2024
# References: See 'Step 3' in 2a/README.md

# Generate a random number between 1 and 20 using rand(1..20) and store in variable
random_number = rand(1..20)

# Ask user for a number between 1 and 20
puts "Guess a number between 1 and 20:"

# Get user input using gets.chomp.to_i (which '.to_i' converts input to integer) and store in variable
number = gets.chomp.to_i

# Keep going until the user's guess is equal to the random number
while number != random_number
  # If user's guess is less than the random number, print "Too low"
  if number < random_number
    puts "Too low"
  # If user's guess is greater than the random number, print "Too high"
  elsif number > random_number
    puts "Too high"
  end

  # Then ask the user to guess another number between 1 and 20
  puts "Guess another number between 1 and 20:"

  # Get the user's input again using gets.chomp.to_i and store in variable
  number = gets.chomp.to_i
end

# If user's guess is equal to the random number, print "You got it!"
puts "You got it!"
