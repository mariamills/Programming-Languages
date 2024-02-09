# TwoDimensionalList transposed (matrix flip-flopped)
# Author: Maria Mills 02/02/2024
# References: See 'Resources' under 'Step 3' in Io/2a/README.md


# (X)Seed-based RNG initialization
randomX := Date now asNumber % 1

# RNG method (linear congruential generator). Returns a random number between 1 and x (inclusive) then multiples it by x and floors it
generateRandomNumber := method(x,
    randomX = (randomX * 2 + 4) % 15  # (2 (multiplier), 4 (increment), 15 (modulus)
    randomNumber := (randomX / 15) * x floor + 1
    return randomNumber floor
)

# TwoDimensionalList prototype
TwoDimensionalList := Object clone

# dim method - initializes the dimensions of the list (x columns, y rows)
TwoDimensionalList dim := method(x, y,
    list = List clone
    # y is rows, -1 to account for 0-based indexing
    for(i, 0, y - 1,
        # Each row is a list of x elements
        row := List clone
        # x is columns, -1 to account for 0-based indexing
        for(j, 0, x - 1,
        # Fill the row with 0s (initializing them all to 0)
            row append(0)
        )
        # Append the row to the list
        list append(row)
    )
)

# set method - sets the value at the specified coordinates ([y][x])
TwoDimensionalList set := method(x, y, value,
    # Set the value at [y][x]
    list at(y) atPut(x, value)
)

# get method - gets the value at the specified coordinates ([y][x])
TwoDimensionalList get := method(x, y,
    list at(y) at(x)
)

# transpose method - flips the matrix
TwoDimensionalList transpose := method(
    # Clone the original list
    transposedList := TwoDimensionalList clone

    # Get the size of the list (number of rows)
    ySize := list size

    # Get the size of the first row (number of columns)
    xSize := list at(0) size
    
    # Initialize the transposed list with the sizes swapped
    transposedList dim(ySize, xSize)
    
    for(x, 0, xSize - 1,
        for(y, 0, ySize - 1,
            # Swap x and y 
            value := self get(x, y)

            # Set the value at the transposed(swap) coordinates
            transposedList set(y, x, value)
        )
    )
    return transposedList
)

# Create a TwoDimensionalList prototype instance
matrix := TwoDimensionalList clone

# Initialize the instance with the dimensions
matrix dim(4, 3)  # 4 columns, 3 rows

# Fill the matrix with random non-zero integers
for(y, 0, 2, 
    for(x, 0, 3,
        randomNumber := generateRandomNumber(10) # 1-10
        matrix set(x, y, randomNumber)
        #"Setting #{y} #{x} to #{randomNumber}" interpolate println # Debugging
    )
)

# Display the original matrix
"Original matrix:" println
for(y, 0, 2,
    for(x, 0, 3,
        write(matrix get(x, y) .. " ")
    )
    " " println
)

# Display the transposed matrix
transposedMatrix := matrix transpose
"Transposed matrix:" println
for(y, 0, 3,
    for(x, 0, 2,
        write(transposedMatrix get(x, y) .. " ")
    )
    " " println
)