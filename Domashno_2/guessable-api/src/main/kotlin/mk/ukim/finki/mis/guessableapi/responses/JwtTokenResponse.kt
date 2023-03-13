package mk.ukim.finki.mis.guessableapi.responses

/**
 * Represents a JWT token response when logging in
 *
 * @property[token] the generated token for maintaining a connection
 * @property[username] the username that the token is created for
 * */
data class JwtTokenResponse(val token: String, val username: String)
