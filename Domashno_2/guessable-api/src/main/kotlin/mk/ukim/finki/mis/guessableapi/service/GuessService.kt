package mk.ukim.finki.mis.guessableapi.service

import jakarta.transaction.Transactional
import mk.ukim.finki.mis.guessableapi.domain.Guess
import mk.ukim.finki.mis.guessableapi.repository.GuessRepository
import org.springframework.stereotype.Service

@Service
class GuessService(val repository: GuessRepository) {

    fun findGuesses(username: String): List<Guess> = repository.findAllByGuessedByUsername(username)

    fun findGuessedLocationIds(username: String): List<Long> = repository.findAllGuessedLocationIds(username)

    @Transactional
    fun save(guess: Guess) = repository.save(guess)
}
