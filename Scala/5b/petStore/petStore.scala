// PetStore Simulation
// Author: Maria Mills 03/09/2024
// References: See 'Resources' in Scala/5b/README.md

import scala.collection.mutable.ArrayBuffer
import scala.util.Random

// Animal Trait - base trait for all animals
trait Animal {
  val name: String
  def sleep(): Unit = println(s"$name is sleeping.")
  def eat(): Unit
  def play(): Unit
  def makeNoise(): Unit
}

// Class Feline
class Feline(override val name: String) extends Animal {
  override def eat(): Unit = println(s"$name the Cat is eating")
  override def play(): Unit = println(s"$name the Cat is playing")
  override def makeNoise(): Unit = println(s"$name the Cat is making noise")
}

// Class Canine
class Canine(override val name: String) extends Animal {
  override def eat(): Unit = println(s"$name the Dog is eating")
  override def play(): Unit = println(s"$name the Dog is playing")
  override def makeNoise(): Unit = println(s"$name the Dog is making noise")
}


// Class Staff - abstract class 
abstract class Staff(val name: String) {
  def arrive(): Unit
  def lunch(): Unit
  def leave(): Unit
}

class Manager(name: String) extends Staff(name) {
  override def arrive(): Unit = println(s"Manager $name has arrived.")
  override def lunch(): Unit = println(s"Manager $name is taking lunch.")
  override def leave(): Unit = println(s"Manager $name has left.")

  def openStore(animals: ArrayBuffer[Animal]): Unit = {
    println(s"Manager $name is opening the store.")
    // Make all animals make noise
    animals.foreach(_.makeNoise())
  }

  def closeStore(animals: ArrayBuffer[Animal]): Unit = {
    println(s"Manager $name is closing the store.")
    // All animals go to sleep
    animals.foreach(_.sleep())
  }
}

class Clerk(name: String) extends Staff(name) {
  override def arrive(): Unit = println(s"Clerk $name has arrived.")
  override def lunch(): Unit = println(s"Clerk $name is taking lunch.")
  override def leave(): Unit = println(s"Clerk $name has left.")

  def feedAnimals(animals: ArrayBuffer[Animal]): Unit = {
    println(s"Clerk $name is feeding the animals.")
    // Each animal eats
    animals.foreach(_.eat())
  }

  def playAnimals(animals: ArrayBuffer[Animal]): Unit = {
    println(s"Clerk $name is playing with the animals.")
    // Each animal plays
    animals.foreach(_.play())
  }

  def sellAnimals(animals: ArrayBuffer[Animal], animalNames: List[String]): Unit = {
    // for each animal...
    animals.indices.foreach { i =>
    // ...there is a 20% chance of selling it
      if (Random.nextDouble() < 0.2) {
        val soldAnimal = animals(i)
        println(s"Clerk $name sold ${soldAnimal.name}.")
        // Replace the sold animal with a new one with a random name from the list
        val newName = animalNames(Random.nextInt(animalNames.length))

        // Create a new animal of the same type as the one being sold
        val newAnimal = soldAnimal match {
          case _: Feline => new Feline(newName)
          case _: Canine => new Canine(newName)
        }
        // Replace the sold animal with the new one
        animals.update(i, newAnimal)
        println(s"New animal added to the store: ${newAnimal.name}")
      }
    }
  }
}

object Clock {
  var day = 1
  // Simulate a day in the pet store
  def simulateDay(manager: Manager, clerk: Clerk, animals: ArrayBuffer[Animal], animalNames: List[String]): Unit = {
    val hours = List(8, 9, 11, 12, 13, 16, 17, 18)
    hours.foreach {
      case 8 =>
        println(s"Day ${day} - Store Time: 8:00 AM")
        manager.arrive()
        manager.openStore(animals)
      case 9 =>
      println(s"Day ${day} - Store Time: 9:00 AM")
        clerk.arrive()
        clerk.feedAnimals(animals)
      case 11 =>
      println(s"Day ${day} - Store Time: 11:00 AM")
        clerk.playAnimals(animals)
      case 12 =>
      println(s"Day ${day} - Store Time: 12:00 AM")
        manager.lunch()
      case 13 =>
        println(s"Day ${day} - Store Time: 13:00 PM")
        clerk.lunch()
      case 16 =>
        println(s"Day ${day} - Store Time: 16:00 PM")
        clerk.sellAnimals(animals, animalNames)
      case 17 =>
        println(s"Day ${day} - Store Time: 17:00 PM")
        clerk.leave()
      case 18 =>
        println(s"Day ${day} - Store Time: 18:00 PM")
        manager.closeStore(animals)
        manager.leave()
        day += 1
    }
  }
}

object PetStoreSimulation extends App {
  val animalNames = List("Muffin", "Nikki", "Jerry", "Bear", "Fido", "Rover", "Spot", "Buddy", "Rocket", "Sassy", "Moxie", "Whiskers", "Tiger", "Smokey", "Socks", "Paws", "Fluffy", "Mittens", "Shadow", "Simba")
  val animals = ArrayBuffer[Animal](
    new Feline("Meowz"),
    new Feline("Sockz"),
    new Feline("Vader"),
    new Canine("Rex"),
    new Canine("Buddy"),
    new Canine("Scout")
  )
  
  val manager = new Manager("John")
  val clerk = new Clerk("Jane")

  // Simulate the store running for three days (1 to 3)
  (1 to 3).foreach { day =>
    println(s"--- Day $day ---")
    Clock.simulateDay(manager, clerk, animals, animalNames)
  }
}
