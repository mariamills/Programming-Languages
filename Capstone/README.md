# Capstone Project - Golang!

## Project title - Go

## Project team members:

- Maria Mills
- Jae Kim

## Development Environment

Go is a statically typed, compiled programming language created by developers at Google. Go is syntactically similar to C, but with memory safety, garbage collection, structural typing, and CSP-style concurrency.

Running a Go program is simple, just type `go run <filename>.go` in the terminal. Go is a compiled language, so you can also compile the program using `go build <filename>.go` and then run the compiled program.

- I (Maria) worked in `GoLand`
- Jae worked in Visual Studio Code

## Issues encountered

- Really no huge issues were encountered. Go is great, it really is simple and easy to use. Any issues we did run into were a simple google search away.

Just to name a few little things we ran into:

- When creating the CLI Bank, when using `Scan`, you couldn't enter a First and Last name with a space in between. We had to use `bufio` to fix this issue. Which was simple a 'How to get multiple words from a user in Go' google search away.

- Again, with the CLI Bank, when trying to deposit or withdraw money, the value would always be 0. We later discovered that Go is **pass by value**, so we had to pass the pointer. Which actually also taught us about pointers in general, having to never use them before.

- Finding a way to parse HTML documents in Go was a bit of a challenge. We happened to stumble upon `goquery`, which is a package that allows you to parse HTML documents (thank you google).
