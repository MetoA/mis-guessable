package mk.ukim.finki.mis.guessableapi.api

import mk.ukim.finki.mis.guessableapi.domain.Guess
import mk.ukim.finki.mis.guessableapi.requests.CreateGuessRequest
import mk.ukim.finki.mis.guessableapi.service.GuessService
import mk.ukim.finki.mis.guessableapi.service.LocationService
import mk.ukim.finki.mis.guessableapi.service.UserService
import org.springframework.security.core.Authentication
import org.springframework.web.bind.annotation.*


/**
 * A rest controller that handles API endpoints related to the geolocation guesses
 *
 * @param[service] service for guesses that interact with the repository
 * @param[userService] service for users that interact with the repository
 * @param[locationService] service for guessable locations that interact with the repository and do geolocation calculations
 *
 * @see[GuessService]
 * @see[UserService]
 * @see[LocationService]
 * */
@RestController
@RequestMapping("/api/guess")
class GuessController(
    private val service: GuessService,
    private val userService: UserService,
    private val locationService: LocationService,
) {

    /**
     * A rest endpoint that gets the guesses of the user that is logged in
     *
     * @param[authentication] authentication information of the user doing the request
     * @return a list of [Guess]
     * */
    @GetMapping("/my_guesses")
    fun userGuesses(authentication: Authentication): List<Guess> = service.findGuesses(authentication.name)

    /**
     * A rest endpoint that gets the guesses of the user that is logged in
     *
     * @param[request] [CreateGuessRequest] that models the information needed to be sent to this endpoint to create a guess for a guessable location
     * @param[authentication] authentication information of the user doing the request
     * @throws[RuntimeException] if a user with the username of the authentication does not exist
     * @throws[RuntimeException] if a guessable location with the id provided in the [CreateGuessRequest] does not exist
     * @return the created [Guess]
     * */
    @PostMapping
    fun createGuess(
        @RequestBody request: CreateGuessRequest,
        authentication: Authentication,
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
