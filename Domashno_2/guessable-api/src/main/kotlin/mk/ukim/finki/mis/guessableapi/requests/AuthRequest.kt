package mk.ukim.finki.mis.guessableapi.requests

import jakarta.validation.constraints.NotBlank

/**
 * Represents the request body needed for authentication requests
 *
 * @property[username] the username of the user when registering or logging in
 * @property[password] the password of the user when registering or logging in
 * */
data class AuthRequest(
    @get:NotBlank
    val username: String,
    @get:NotBlank
    val password: String
)
