package mk.ukim.finki.mis.guessableapi.service

import jakarta.transaction.Transactional
import mk.ukim.finki.mis.guessableapi.domain.Location
import mk.ukim.finki.mis.guessableapi.repository.LocationRepository
import mk.ukim.finki.mis.guessableapi.requests.CreateLocationRequest
import org.springframework.core.io.InputStreamResource
import org.springframework.data.repository.findByIdOrNull
import org.springframework.stereotype.Service
import kotlin.math.acos
import kotlin.math.cos
import kotlin.math.sin

/**
 * A service for managing [Location] in the database and calculations
 *
 * @param[repository] [LocationRepository] for managing [Location] in the database
 * @paramp[userService] [UserService] for managing users in the database
 * */
@Service
class LocationService(val repository: LocationRepository, val userService: UserService) {

    /**
     * A function that gets a random guessable [Location] that has not been guessed yet
     *
     * @param[guessedIds] a list of [Long] ids of guessed ids to know not to return a [Location] that has already been guessed
     * @return [Location] or null if none exist
     * */
    fun getRandomLocation(guessedIds: List<Long>) = repository.getRandomLocation(guessedIds)

    /**
     * A function that returns a [Location] from an id
     *
     * @param[locationId] an id of the [Location]
     * @return [Location] or null
     * */
    fun findById(locationId: Long) = repository.findByIdOrNull(locationId)

    /**
     * A function that handles creating a guessable [Location]
     *
     * @param[latitude] the map latitude of the location
     * @param[longitude] the map longitude of the location
     * @param[image] [ByteArray] of the image of the location
     * @param[username] the username of who created the location
     * @return[Location] the created location
     * */
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

    /**
     * A function that calculates the distance in kilometers from 2 geolocations
     *
     * @param[lat1] latitude of the first location
     * @param[lat2] latitude of the second location
     * @param[lon1] longitude of the first location
     * @param[lon2] longitude of the first location
     * @return [Double] distance in kilometers
     * */
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
