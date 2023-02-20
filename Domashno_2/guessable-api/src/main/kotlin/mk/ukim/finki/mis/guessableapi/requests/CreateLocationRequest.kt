package mk.ukim.finki.mis.guessableapi.requests

data class CreateLocationRequest(
    val latitude: Double,
    val longitude: Double,
    val image: ByteArray,
)
