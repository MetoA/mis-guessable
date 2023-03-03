package mk.ukim.finki.mis.guessableapi.service

import jakarta.transaction.Transactional
import mk.ukim.finki.mis.guessableapi.domain.Location
import mk.ukim.finki.mis.guessableapi.repository.LocationRepository
import org.springframework.data.repository.findByIdOrNull
import org.springframework.stereotype.Service
import kotlin.math.acos
import kotlin.math.cos
import kotlin.math.sin

@Service
class LocationService(val repository: LocationRepository, val userService: UserService) {

    fun getRandomLocation(guessedIds: List<Long>) = repository.getRandomLocation(guessedIds)

    fun findById(locationId: Long) = repository.findByIdOrNull(locationId)

    @Transactional
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

    fun distance(lat1: Double, lon1: Double, lat2: Double, lon2: Double): Double {
        return if (lat1 == lat2 && lon1 == lon2) {
            0.0
        } else {
            val theta = lon1 - lon2
            Math.toDegrees(
                acos(
                    sin(Math.toRadians(lat1)) * sin(Math.toRadians(lat2)) +
                            cos(Math.toRadians(lat1)) * cos(Math.toRadians(lat2)) * cos(Math.toRadians(theta))
                )
            ) * 60 * 1.1515 * 1.609344
        }
    }
}
