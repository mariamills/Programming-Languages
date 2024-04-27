package main

import (
	"bufio"
	"fmt"
	"os"
	"strings"
)

// Bank Struct - Go does not have classes, but you can define methods on types
type Bank struct {
	AccountNumber  int
	AccountHolder  string
	AccountBalance float64
}

// Transaction Struct to store the transaction history (withdrawal, deposit)
type Transaction struct {
	AccountNumber   int
	TransactionType string
	Amount          float64
}

// Deposit method for Bank
func (b *Bank) Deposit(amount float64) float64 { // *Bank is the receiver type & we use a pointer to access the value instead of a copy
	b.AccountBalance += amount
	return b.AccountBalance
}

// Withdraw method for Bank
func (b *Bank) Withdraw(amount float64) float64 { // *Bank is the receiver type & we use a pointer to access the value instead of a copy
	b.AccountBalance -= amount
	return b.AccountBalance
}

// showMenu function to display the menu
func showMenu() string {
	return "\n1. Create Account\n2. Deposit\n3. Withdraw\n4. Check Balance\n5. Show Transaction History\n6. Exit"
}

// askForInput function to get the user's choice with error handling
func askForInput() int {
	fmt.Println(showMenu())
	fmt.Println("What would you like to do?")
	var choice int
	_, err := fmt.Scanln(&choice) // _ is used to ignore the return value of fmt.Scanln similar to python's _ variable, Go doesn't like unused variables
	if err != nil {
		return 0
	}
	return choice
}

// findAccount function to find an account in the slice (dynamic array) of Bank objects
func findAccount(accounts []Bank, accountNumber int) *Bank {
	for i := range accounts {
		if accounts[i].AccountNumber == accountNumber {
			return &accounts[i]
		}
	}
	return nil
}

// main function
func main() {
	bankAccounts := []Bank{}              // create an empty slice (dynamic array) of Bank objects
	transactionHistory := []Transaction{} // create an empty slice (dynamic array) of Transaction objects

	reader := bufio.NewReader(os.Stdin) // create a reader object (bufio is like BufferedReader in Java)

	accountNumber := 0 // start the account number from 0

	fmt.Println("Hello! Welcome to Go Bank")

	// infinite loop to keep the program running until the user chooses to exit (6)
	for {
		choice := askForInput() // get the user's choice

		// Exit the program - to avoid repeating the switch case & showMenu() call
		if choice == 6 {
			fmt.Println("Thank you for using Go Bank!")
			break
		}

		switch choice {
		case 1: // create account
			fmt.Println("Enter the account holder's name:")
			accountHolder, _ := reader.ReadString('\n')      // read the input until a newline character is encountered
			accountHolder = strings.TrimSpace(accountHolder) // remove leading and trailing whitespaces

			newAccount := Bank{AccountNumber: accountNumber, AccountHolder: accountHolder, AccountBalance: 0}
			fmt.Printf("Account created successfully!\n-Account Number: %d \n-Account Holder: %s \n-Account Balance: %.2f", newAccount.AccountNumber, newAccount.AccountHolder, newAccount.AccountBalance)

			bankAccounts = append(bankAccounts, newAccount) // append the new account to the slice
			accountNumber++                                 // increment the account number
		case 2: // deposit
			fmt.Println("Enter the account number:")
			var num int
			_, err := fmt.Scanln(&num)
			if err != nil {
				continue
			}

			account := findAccount(bankAccounts, num)
			if account == nil {
				fmt.Println("Account not found!")
				continue
			}

			fmt.Println("Enter the deposit amount:")
			var depositAmount float64
			fmt.Scanln(&depositAmount)
			account.Deposit(depositAmount)

			fmt.Println("\nDeposit successful!")
			fmt.Println("Account Number:", account.AccountNumber)
			fmt.Println("Account Balance:", account.AccountBalance)

			// append the transaction to the transaction history
			transactionHistory = append(transactionHistory, Transaction{AccountNumber: account.AccountNumber, TransactionType: "Deposit", Amount: depositAmount})
		case 3: // withdraw
			fmt.Println("Enter the account number:")
			var num int
			_, err := fmt.Scanln(&num)
			if err != nil {
				continue
			}

			account := findAccount(bankAccounts, num)
			if account == nil {
				fmt.Println("Account not found!")
				continue
			}

			fmt.Println("Enter the withdrawal amount:")
			var withdrawalAmount float64
			fmt.Scanln(&withdrawalAmount)
			account.Withdraw(withdrawalAmount)

			fmt.Println("\nWithdrawal successful!")
			fmt.Println("Account Number:", account.AccountNumber)
			fmt.Println("Account Balance:", account.AccountBalance)

			// append the transaction to the transaction history
			transactionHistory = append(transactionHistory, Transaction{AccountNumber: account.AccountNumber, TransactionType: "Withdrawal", Amount: withdrawalAmount})
		case 4: // check balance
			fmt.Println("Enter the account number:")
			var num int
			_, err := fmt.Scanln(&num)
			if err != nil {
				fmt.Println("Please enter a valid number!")
				continue
			}

			account := findAccount(bankAccounts, num)
			if account == nil {
				continue
			}

			fmt.Println("\nHi", account.AccountHolder)
			fmt.Println("Account Number:", account.AccountNumber)
			fmt.Println("Account Balance:", account.AccountBalance)
		case 5: // show transaction history
			fmt.Println("Enter the account number:")
			var num int
			_, err := fmt.Scanln(&num)
			if err != nil {
				continue
			}

			// filter the transaction history based on the account number
			var filteredTransactions []Transaction // create an empty slice (dynamic array) of Transaction objects
			for i := range transactionHistory {
				if transactionHistory[i].AccountNumber == num {
					filteredTransactions = append(filteredTransactions, transactionHistory[i])
				}
			}

			// no transactions found, so continue to the next iteration and show the menu again
			if len(filteredTransactions) == 0 {
				fmt.Println("No transactions found for this account!")
				continue
			}

			fmt.Println("\nTransaction History:")
			for i := range filteredTransactions {
				fmt.Println("Transaction Type:", filteredTransactions[i].TransactionType)
				fmt.Println("Amount:", filteredTransactions[i].Amount)
				fmt.Println()
			}
		default:
			fmt.Println("Invalid choice! Please enter a number between 1 and 6.")
		}
	}
}
