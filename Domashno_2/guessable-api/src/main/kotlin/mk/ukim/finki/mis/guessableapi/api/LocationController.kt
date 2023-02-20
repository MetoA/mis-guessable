package mk.ukim.finki.mis.guessableapi.api

import mk.ukim.finki.mis.guessableapi.domain.Location
import mk.ukim.finki.mis.guessableapi.requests.CreateLocationRequest
import mk.ukim.finki.mis.guessableapi.service.LocationService
import org.springframework.core.io.InputStreamResource
import org.springframework.http.MediaType
import org.springframework.http.ResponseEntity
import org.springframework.security.core.Authentication
import org.springframework.web.bind.annotation.*
import java.io.ByteArrayInputStream

@RestController
@RequestMapping("/api/location")
class LocationController(val service: LocationService) {

    @GetMapping
    fun getRandomLocation(): Location = service.getRandomLocation()

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
