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

@RestController
@RequestMapping("/api/location")
class LocationController(
    private val service: LocationService,
    private val guessService: GuessService,
) {

    @GetMapping("/random")
    fun getRandomLocation(authentication: Authentication): LocationResponse? {
        val guessedLocationIds = guessService.findGuessedLocationIds(authentication.name)
        // Weird thing where if the guessed locations is empty it will always return null
        val location = service.getRandomLocation(guessedLocationIds.ifEmpty { listOf(0L) })
        return location?.let {
            LocationResponse(it.id, it.latitude, it.longitude, it.image.joinToString(",") { byte -> byte.toString() })
        }
    }

    // Dumb hack so I can get the image to render on flutter...
    data class LocationResponse(val id: Long, val latitude: Double, val longitude: Double, val image: String)

    @PostMapping
    fun createLocation(@RequestBody request: CreateLocationRequest, authentication: Authentication): Location =
        with(request) {
            service.createLocation(latitude, longitude, image, authentication.name)
        }

    @GetMapping("{id}/image")
    fun getImage(@PathVariable id: Long): ResponseEntity<InputStreamResource> =
        service.getImage(id)?.let {
            ResponseEntity.ok()
                .contentType(MediaType.IMAGE_JPEG)
                .body(InputStreamResource(ByteArrayInputStream(it.image)))
        } ?: ResponseEntity.notFound().build()
}
