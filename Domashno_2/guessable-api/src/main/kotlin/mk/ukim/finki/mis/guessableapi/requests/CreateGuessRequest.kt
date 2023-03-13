package mk.ukim.finki.mis.guessableapi.requests

/**
 * Represents the request body for creating a guess
 *
 * @property[locationId] the id of the location that this guess is meant for
 * @property[latitude] the map latitude of the guess
 * @property[longitude] the map longitude of the guess
 * */
data class CreateGuessRequest(
    val locationId: Long,
    val latitude: Double,
    val longitude: Double
)
