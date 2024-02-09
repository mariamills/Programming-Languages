# Number Guessing Game
# Author: Maria Mills 01/30/2024
# References: See 'Resources' under 'Step 2' in Io/2a/README.md

# Random number generator based on the current time, thank you for the gift!
generateRandomNumber := method(
    d := Date clone
    # Get the current time as a number, multiply by 19, floor it, and add 1 so 0 is not included
    randomNumber := ((d now asNumber - d now asNumber floor) * 19) floor + 1 # 1-20
    return randomNumber
)

# Generate a random number between 1 and 20
randomNumber := generateRandomNumber()

# Get the user's guess, initialize to 0
guess := 0
# Keep asking for a number until user guesses right
while(guess != randomNumber,
    guess := File standardInput readLine("Guess a number between 1 and 20: ") asNumber
    #"Random number is: #{randomNumber}" interpolate println # Uncomment to see the random number
    if (guess < randomNumber, "Too low!" println)
    if (guess > randomNumber, "Too high!" println)
    if (guess == randomNumber, "Correct! The number was #{randomNumber}" interpolate println)
)

