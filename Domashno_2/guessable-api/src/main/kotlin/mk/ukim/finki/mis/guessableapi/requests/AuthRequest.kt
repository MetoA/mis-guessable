package mk.ukim.finki.mis.guessableapi.requests

import jakarta.validation.constraints.NotBlank

data class AuthRequest(
    @get:NotBlank
    val username: String,
    @get:NotBlank
    val password: String
)
