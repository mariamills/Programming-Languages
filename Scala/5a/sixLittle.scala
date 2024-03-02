import scala.collection.mutable.ArrayBuffer
import scala.io.StdIn.readLine
import scala.util.Random

class SixLittle {
    // mutable arrays
    val words = ArrayBuffer[String]()
    val hints = ArrayBuffer[String]()
    val tokens = ArrayBuffer[String]()

    // Ask method
    def ask(): Unit = {
    // Asking 6 times
        for (_ <- 0 until 6) {
            var word = ""
            // while word is less than 4 characters... ask for a word again
            while (word.length < 4) {
                print("Enter a word: ")
                word = readLine()
                if (word.length < 4) {
                    println("Word must be at least 4 characters long.")
                }
            }
            words += word

            // Ask for a hint
            print("Enter a hint: ")
            val hint = readLine()
            hints += hint
        }
    }


    // prepare method
    def prepare(): Unit = {
        words.foreach { word =>
            // Split word in half and convert to upper case
            val half = (word.length + 1) / 2
            // add first half to tokens
            tokens += word.substring(0, half).toUpperCase()
            // Add second half to tokens
            tokens += word.substring(half).toUpperCase()
        }

        // Shuffle tokens array
        Random.shuffle(tokens)
    }

    // display method
    def display(): Unit = {
        println("Six Little Words (Scala)\n")
        println("Partial Words/Tokens:")
        // Group tokens by 4
        tokens.grouped(4).foreach { group =>
            // Print each group separated by a space
            println(group.mkString(" "))
        }

        println("\nHints:")
        // for each hint, print it
        hints.foreach { hint =>
            println(hint)
        }

        println("\nAnswer Key:")
        // Group words by 3
        words.grouped(3).foreach { group =>
            // Print each group separated by a space
            println(group.mkString(" "))
        }
    }

    // Run method
    def run(): Unit = {
        ask()
        prepare()
        display()
    }
}

// Main object
object SixLittle {
  def main(args: Array[String]): Unit = {
    val game = new SixLittle()
    game.run()
  }
}
