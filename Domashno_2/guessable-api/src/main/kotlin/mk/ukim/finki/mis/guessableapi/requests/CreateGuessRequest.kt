package mk.ukim.finki.mis.guessableapi.requests

data class CreateGuessRequest(
    val locationId: Long,
    val latitude: Double,
    val longitude: Double
)
