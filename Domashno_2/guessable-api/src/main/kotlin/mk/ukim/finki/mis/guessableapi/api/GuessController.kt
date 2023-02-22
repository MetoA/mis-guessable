package mk.ukim.finki.mis.guessableapi.api

import mk.ukim.finki.mis.guessableapi.domain.Guess
import mk.ukim.finki.mis.guessableapi.service.GuessService
import org.springframework.security.core.Authentication
import org.springframework.web.bind.annotation.GetMapping
import org.springframework.web.bind.annotation.RequestMapping
import org.springframework.web.bind.annotation.RestController

@RestController
@RequestMapping("/api/guess")
class GuessController(
    val service: GuessService
) {

    @GetMapping("my_guesses")
    fun userGuesses(authentication: Authentication): List<Guess> = service.findGuessesByUsername(authentication.name)

    // TODO create guess
}
