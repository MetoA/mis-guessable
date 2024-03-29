package mk.ukim.finki.mis.guessableapi

import org.springframework.boot.autoconfigure.SpringBootApplication
import org.springframework.boot.runApplication

@SpringBootApplication
class GuessableApiApplication

/**
 * The main entrypoint for the [GuessableApiApplication]
 * */
fun main(args: Array<String>) {
    runApplication<GuessableApiApplication>(*args)
}
