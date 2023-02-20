package mk.ukim.finki.mis.guessableapi.service

import mk.ukim.finki.mis.guessableapi.domain.Location
import mk.ukim.finki.mis.guessableapi.repository.LocationRepository
import org.springframework.data.repository.findByIdOrNull
import org.springframework.stereotype.Service
import kotlin.random.Random

@Service
class LocationService(val repository: LocationRepository, val userService: UserService) {

    fun getRandomLocation() = repository.getRandomLocation(Random.nextLong(0L, repository.count()))

    fun createLocation(latitude: Double, longitude: Double, image: ByteArray, username: String): Location {
        val user = userService.findByUsername(username)!!
        return repository.save(
            Location(
                id = 0L,
                latitude = latitude,
                longitude = longitude,
                image = image,
                createdBy = user
            )
        )
    }

    fun getImage(id: Long) = repository.findByIdOrNull(id)
}
