package mk.ukim.finki.mis.guessableapi.api

import mk.ukim.finki.mis.guessableapi.domain.Guess
import mk.ukim.finki.mis.guessableapi.requests.CreateGuessRequest
import mk.ukim.finki.mis.guessableapi.service.GuessService
import mk.ukim.finki.mis.guessableapi.service.LocationService
import mk.ukim.finki.mis.guessableapi.service.UserService
import org.springframework.security.core.Authentication
import org.springframework.web.bind.annotation.GetMapping
import org.springframework.web.bind.annotation.PostMapping
import org.springframework.web.bind.annotation.RequestBody
import org.springframework.web.bind.annotation.RequestMapping
import org.springframework.web.bind.annotation.RestController
import java.lang.RuntimeException

@RestController
@RequestMapping("/api/guess")
class GuessController(
    private val service: GuessService,
    private val userService: UserService,
    private val locationService: LocationService
) {

    @GetMapping("/my_guesses")
    fun userGuesses(authentication: Authentication): List<Guess> = service.findGuesses(authentication.name)

    @PostMapping
    fun createGuess(
        @RequestBody request: CreateGuessRequest,
        authentication: Authentication
    ): Guess = with(request) {
        val user = userService.findByUsername(authentication.name)
            ?: throw RuntimeException("Username [${authentication.name}] not found")

        val location = locationService.findById(locationId)
            ?: throw RuntimeException("Location with id [$locationId] not found")

        val guess = Guess(
            id = 0L,
            location = location,
            guessedBy = user,
            guessedLatitude = latitude,
            guessedLongitude = longitude,
            distance = locationService.distance(latitude, longitude, location.latitude, location.longitude)
        )

        return service.save(guess)
    }
}
