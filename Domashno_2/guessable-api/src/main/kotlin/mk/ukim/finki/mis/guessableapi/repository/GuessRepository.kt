package mk.ukim.finki.mis.guessableapi.repository

import mk.ukim.finki.mis.guessableapi.domain.Guess
import org.springframework.data.jpa.repository.JpaRepository
import org.springframework.stereotype.Repository

@Repository
interface GuessRepository : JpaRepository<Guess, Long> {

    fun findAllByGuessedByUsername(username: String): List<Guess>
}
