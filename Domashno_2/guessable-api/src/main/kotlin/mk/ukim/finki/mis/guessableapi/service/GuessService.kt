package mk.ukim.finki.mis.guessableapi.service

import mk.ukim.finki.mis.guessableapi.domain.Guess
import mk.ukim.finki.mis.guessableapi.repository.GuessRepository
import org.springframework.stereotype.Service

@Service
class GuessService(val repository: GuessRepository) {

    fun findGuessesByUsername(username: String): List<Guess> = repository.findAllByGuessedByUsername(username)
}
