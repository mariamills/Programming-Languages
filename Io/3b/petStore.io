# PetStore Simulation
# Author: Maria Mills 02/07/2024
# References: See 'Resources' in Io/2b/README.md

# (X)Seed-based RNG initialization
randomX := Date now asNumber % 1

# RNG method (linear congruential generator). Returns a random number between 1 and x (inclusive) then multiples it by x and floors it
generateRandomNumber := method(x,
    randomX = (randomX * 2 + 4) % 15  # (2 (multiplier), 4 (increment), 15 (modulus)
    randomNumber := (randomX / 15) * x floor + 1
    return randomNumber floor
)

# random animal name list - 20 names
animalNames := list("Muffin", "Nikki", "Jerry", "Bear", "Fido", "Rover", "Spot", "Buddy", "Rocket", "Sassy", "Moxie", "Whiskers", "Tiger", "Smokey", "Socks", "Paws", "Fluffy", "Mittens", "Shadow", "Simba")

# Animal object => Object object
Animal := Object clone do(
    # new slot - default value is "unnamed"
    name ::= "unnamed"

    # sleep method - prints the name of the animal and that their sleeping
    sleep := method(
        "#{name} is sleeping" interpolate println
    )
)

# Feline object => Animal object
Feline := Animal clone do(
    # eat method - prints the name of the feline eating
    eat := method(
        "#{name} the cat is eating." interpolate println
    )

    # play method - prints the name of the feline playing
    play := method(
        "#{name} the Cat plays and chases their tail." interpolate println
    )

    # makesNoise method - prints the name of the feline meowing
    makeNoise := method(
        "#{name} the Cat is meowing." interpolate println
    )
)

# Canine object => Animal object
Canine := Animal clone do(
    # eat method - prints the name of the canine eating
    eat := method(
        "#{name} the Dog is eating." interpolate println
    )

    # play method - prints the name of the canine playing
    play := method(
        "#{name} the Dog plays and chases their tail." interpolate println
    )

    # makesNoise method - prints the name of the canine barking
    makeNoise := method(
        "#{name} the Dog is barking." interpolate println
    )
)

#Staff object => Object object
Staff := Object clone do(
    # arrive method - prints the name of the staff member arriving
    arrive := method(
        "#{name} has arrived at work." interpolate println
    )

    # lunch method - prints the name of the staff member going to lunch
    lunch := method(
        "#{name} is going to lunch." interpolate println
    )

    # leave method - prints the name of the staff member leaving
    leave := method(
        "#{name} is leaving work." interpolate println
    )
)
# Manager object => Staff object
Manager := Staff clone do(
    # openStore method - prints the name of the manager opening the store
    openStore := method(
        "Manager #{name} is opening the store." interpolate println
    )

    # closeStore method - prints the name of the manager closing the store
    closeStore := method(
        "Manager #{name} is closing the store." interpolate println
        # all animals go to sleep when the store closes
        allAnimals foreach(animal, animal sleep)
    )
)

# Clerk object => Staff object
Clerk := Staff clone do(
    # feedAnimals method - prints the name of the clerk feeding the animals
    feedAnimals := method(
        "Clerk #{name} is feeding the animals." interpolate println
        allAnimals foreach(animal, animal eat)
    )

    # playAnimals method - prints the name of the clerk playing with the animals
    playAnimals := method(
        "Clerk #{name} is playing with the animals." interpolate println
        allAnimals foreach(animal, animal play)
    )

    #sellAnimals method - prints the name of the clerk selling the animals
    sellAnimals := method(
        allAnimals foreach(animal, 
        # 20% chance of selling the animal - out of 100
            randomNumber := generateRandomNumber(100)
            #"Random Number: #{randomNumber}" interpolate println # debugging
            if (randomNumber <= 20,
                "Clerk #{name} sold #{animal name}" interpolate println
                allAnimals remove(animal)
                # replace the animal with a new one
                if (animal type == "Feline",
                    newAnimal := Feline clone
                    # give the new animal a random name from 0-19 (because 0 indexed)
                    newAnimal name := animalNames at(randomNumber - 1)
                    allAnimals append(newAnimal)
                    "New cat: #{newAnimal name}" interpolate println
                )
                if (animal type == "Canine",
                    newAnimal := Canine clone
                    newAnimal name := animalNames at(randomNumber - 1)
                    allAnimals append(newAnimal)
                    "New dog: #{newAnimal name}" interpolate println
                )
                #allAnimals foreach(animal, animal name println) # debugging
            )
        )
    )
)

# cats list
cats := List clone

# cat1 instance of Feline
cat1 := Feline clone
cat1 name = "Meowmixin"
# append to cats list
cats append(cat1)

# cat2 instance of Feline
cat2 := Feline clone
cat2 name = "Vader"
# append to cats list
cats append(cat2)

# cat3 instance of Feline
cat3 := Feline clone
cat3 name = "Lady"
# append to cats list
cats append(cat3)

# dogs list
dogs := List clone

# dog1 instance of Canine
dog1 := Canine clone
dog1 name = "Sheriff"
# append to dogs list
dogs append(dog1)

# dog2 instance of Canine
dog2 := Canine clone
dog2 name = "Sherlock"
# append to dogs list
dogs append(dog2)

# dog3 instance of Canine
dog3 := Canine clone
dog3 name = "Lucky"
# append to dogs list
dogs append(dog3)

# create an all animals list
allAnimals := List clone
cats foreach(cat, allAnimals append(cat))
dogs foreach(dog, allAnimals append(dog))

# staff list
allStaff := List clone

# manager instance
manager := Manager clone
manager name := "Maria"
allStaff append(manager)

# clerk instance
clerk := Clerk clone
clerk name := "Clem"
allStaff append(clerk)

Clock := Object clone do(
    times := list("0800", "0900", "1000", "1100", "1200", "1300", "1400", "1500", "1600", "1700", "1800")
    day := 1
    hour := 0
    incrTime := method(
        # there are 10 times in the list, so if the hour is 9, reset to 0, otherwise increment by 1
        if(hour > 9, hour = 0, hour = hour + 1)
    )

    tellTime := method(
        times at(hour)
    )

    runClock := method(
        yield
        incrTime
    )

    announceHour := method(
        "[Day #{Clock day}, Store Time: #{Clock tellTime}]: " interpolate println
        if (Clock tellTime == "0800", manager arrive; manager openStore)
        if (Clock tellTime == "0900", clerk arrive; clerk feedAnimals)
        if (Clock tellTime == "1100", clerk playAnimals)
        if (Clock tellTime == "1200", manager @@lunch)
        // make all staff go to lunch except the manager because they already went
        if (Clock tellTime == "1300", allStaff foreach(staff, if (staff type != "Manager", staff lunch)))
        if (Clock tellTime == "1600", clerk sellAnimals)
        if (Clock tellTime == "1700", clerk leave)
        if (Clock tellTime == "1800", manager closeStore; manager leave; writeln("Day ", Clock day, " over.") Clock day = Clock day + 1; writeln("\n"))
        yield
    )
)

while(Clock day <= 3,
Clock @@announceHour; Clock @@runClock; wait(2)
)
Coroutine currentCoroutine pause



