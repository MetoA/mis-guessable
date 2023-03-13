package mk.ukim.finki.mis.guessableapi.requests

/**
 * Represents the request body meant for creating a location
 *
 * @property[latitude] the map latitude of the guessable location
 * @property[longitude] the map longitude of the guessable location
 * @property[image] the [ByteArray] of the image of the location
 * */
data class CreateLocationRequest(
    val latitude: Double,
    val longitude: Double,
    val image: ByteArray,
)
