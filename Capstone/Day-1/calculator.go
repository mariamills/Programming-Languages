package main

import (
	"fmt"
)

// function to add two numbers
func add(a, b int) int {
	return a + b
}

// function to subtract two numbers
func subtract(a, b int) int {
	return a - b
}

// function to multiply two numbers
func multiply(a, b int) int {
	return a * b
}

// function to divide two numbers
func divide(a, b int) int {
	return a / b
}

// main function
func main() {
	fmt.Print("Enter the first number: ")
	var a int
	fmt.Scan(&a) // read the input from the user (& is used to get the address of the variable, required by Scan, will be covered in Day 2)

	fmt.Print("Enter the second number: ")
	var b int
	fmt.Scan(&b) // user input again, note we are not handling errors here (will be covered in Day 2 as well)

	fmt.Println("What operation would you like to perform? (+, -, *, /)")
	var operation string
	fmt.Scan(&operation)

	// switch case - break is not required as it is implicit
	switch operation {
	case "+":
		fmt.Println(add(a, b))
	case "-":
		fmt.Println(subtract(a, b))
	case "*":
		fmt.Println(multiply(a, b))
	case "/":
		fmt.Println(divide(a, b))
	default:
		fmt.Println("Invalid operation")
	}
}
