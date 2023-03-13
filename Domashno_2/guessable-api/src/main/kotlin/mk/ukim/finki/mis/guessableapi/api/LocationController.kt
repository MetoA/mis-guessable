package mk.ukim.finki.mis.guessableapi.api

import mk.ukim.finki.mis.guessableapi.domain.Location
import mk.ukim.finki.mis.guessableapi.requests.CreateLocationRequest
import mk.ukim.finki.mis.guessableapi.service.GuessService
import mk.ukim.finki.mis.guessableapi.service.LocationService
import org.springframework.core.io.InputStreamResource
import org.springframework.http.MediaType
import org.springframework.http.ResponseEntity
import org.springframework.security.core.Authentication
import org.springframework.web.bind.annotation.*
import java.io.ByteArrayInputStream

/**
 * A rest controller that handles API endpoints related to the guessable locations
 * @param[service] service for guessable locations that interact with the repository and do geolocation calculations
 * @param[guessService] service for guesses that interact with the repository
 *
 * @see[LocationService]
 * @see[GuessService]
 * */
@RestController
@RequestMapping("/api/location")
class LocationController(
    private val service: LocationService,
    private val guessService: GuessService,
) {

    /**
     * A rest endpoint that gets a random guessable [Location] that has not been guessed yet
     *
     * @param[authentication] authentication information of the user doing the request
     * @return [Location] or null if none exist
     * */
    @GetMapping("/random")
    fun getRandomLocation(authentication: Authentication): Location? {
        val guessedLocationIds = guessService.findGuessedLocationIds(authentication.name)
        return service.getRandomLocation(guessedLocationIds.ifEmpty { listOf(0L) })
    }

    /**
     * A rest endpoint that handles creating a guessable [Location]
     *
     * @param[request] [CreateLocationRequest] that models the body of the HTTP request that is needed for this request
     * @param[authentication] authentication information of the user doing the request
     *
     * @return[Location] the created location
     * */
    @PostMapping
    fun createLocation(@RequestBody request: CreateLocationRequest, authentication: Authentication): Location =
        with(request) {
            service.createLocation(latitude, longitude, image, authentication.name)
        }

    /**
     * A rest endpoint that gets the image for a specific location
     *
     * @param[id] the id of the guessable [Location]
     * @return[InputStreamResource] byte array of the image
     * */
    @GetMapping("{id}/image")
    fun getImage(@PathVariable id: Long): ResponseEntity<InputStreamResource> =
        service.findById(id)?.let {
            ResponseEntity.ok()
                .contentType(MediaType.IMAGE_JPEG)
                .body(InputStreamResource(ByteArrayInputStream(it.image)))
        } ?: ResponseEntity.notFound().build()
}
