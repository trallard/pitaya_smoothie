import scala.actors._

  object SeriousActor extends Actor {
    def act() { 
      for (i <- 1 to 5) {
        println("To be or not to be.")
        Thread.sleep(1000)
      }
    }
  }
scala> import scala.actors.Actor._

  scala> val seriousActor2 = actor {
       |    for (i <- 1 to 5)
       |      println("That is the question.")
       |    Thread.sleep(1000)
       | }

  scala> That is the question.
  That is the question.
  That is the question.
  That is the question.
  That is the question.