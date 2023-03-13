package mk.ukim.finki.mis.guessableapi.service

import jakarta.transaction.Transactional
import mk.ukim.finki.mis.guessableapi.domain.Guess
import mk.ukim.finki.mis.guessableapi.repository.GuessRepository
import org.springframework.stereotype.Service

/**
 * A service for managing [Guess]
 *
 * @param[repository] [GuessRepository] for communicating with the database for the [Guess] entity
 * */
@Service
class GuessService(val repository: GuessRepository) {

    /**
     * A function for finding all guesses for a username
     *
     * @param[username] the username for the user
     * @return a list of [Guess] for the user
     * */
    fun findGuesses(username: String): List<Guess> = repository.findAllByGuessedByUsername(username)

    /**
     * A function for finding ids of guessed locations
     *
     * @param[username] the username for the user
     * @return a list of [Long] ids for guessed locations
     * */
    fun findGuessedLocationIds(username: String): List<Long> = repository.findAllGuessedLocationIds(username)

    /**
     * A function for saving a guess in the database
     *
     * @param[guess] a [Guess] to be saved in the database
     * @return the guess that was saved in the database
     * */
    @Transactional
    fun save(guess: Guess) = repository.save(guess)
}
