package mk.ukim.finki.mis.guessableapi.repository

import mk.ukim.finki.mis.guessableapi.domain.Guess
import org.springframework.data.jpa.repository.JpaRepository
import org.springframework.data.jpa.repository.Query
import org.springframework.stereotype.Repository

@Repository
interface GuessRepository : JpaRepository<Guess, Long> {

    fun findAllByGuessedByUsername(username: String): List<Guess>

    @Query("select g.location.id from Guess g where g.guessedBy.username = :username")
    fun findAllGuessedLocationIds(username: String): List<Long>

}
