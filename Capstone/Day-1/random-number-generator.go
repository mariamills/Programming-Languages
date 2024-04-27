package main

import (
	"fmt"
	"math/rand/v2"
)

func main() {
	var guess int
	randomNumber := rand.IntN(10) + 1 // generate a random number between 1 and 10 (its exclusive, so +1)

	fmt.Print("Guess a number between 1 and 10: ")
	fmt.Scan(&guess)

	for guess != randomNumber {
		if guess < randomNumber {
			fmt.Println("Too low! Try again.")
		} else {
			fmt.Println("Too high! Try again.")
		}
		fmt.Scan(&guess)
	}
	fmt.Println("You guessed the correct number!")
}
