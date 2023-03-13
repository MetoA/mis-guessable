package mk.ukim.finki.mis.guessableapi.repository

import mk.ukim.finki.mis.guessableapi.domain.Guess
import org.springframework.data.jpa.repository.JpaRepository
import org.springframework.data.jpa.repository.Query
import org.springframework.stereotype.Repository

/**
 * A repository that communicates with the database for the [Guess] entity
 * */
@Repository
interface GuessRepository : JpaRepository<Guess, Long> {

    /**
     * A function that gets all guesses for a specific username
     *
     * @param[username] the username to find all guesses
     * @return a list of [Guess]
     * */
    fun findAllByGuessedByUsername(username: String): List<Guess>

    /**
     * A function that gets all ids of guessed locations by a specific username
     *
     * @param[username] the username to find all guesses
     * @return a list of [Long] of guessed locations ids
     * */
    @Query("select g.location.id from Guess g where g.guessedBy.username = :username")
    fun findAllGuessedLocationIds(username: String): List<Long>

}
