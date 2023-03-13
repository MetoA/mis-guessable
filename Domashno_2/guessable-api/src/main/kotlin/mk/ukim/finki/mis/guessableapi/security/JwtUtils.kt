package mk.ukim.finki.mis.guessableapi.security

import io.jsonwebtoken.Jwts
import io.jsonwebtoken.security.Keys
import org.springframework.security.core.Authentication

/**
 * Secret key used for generating and parsing JWT tokens
 * */
private val KEY = Keys.hmacShaKeyFor("this-is-an-extremely-super-duper-secure-key".toByteArray())

/**
 * A function that generates a JWT token
 *
 * @param[authentication] the [Authentication] of the user
 * @return JWT token
 * */
fun generateJwtToken(authentication: Authentication): String =
    Jwts.builder().setSubject(authentication.name).signWith(KEY).compact()


/**
 * A function that gets the username for a specific token
 *
 * @param[token] the JWT token
 * @return the username from the token
 * */
fun getUsernameFromJwtToken(token: String): String =
    Jwts.parserBuilder().setSigningKey(KEY).build().parseClaimsJws(token).body.subject

/**
 * A function that validates a JWT token
 *
 * @param[token] the JWT token
 * @return[Boolean] the validity of the JWT token
 * */
fun isValidJwtToken(token: String) =
    try {
        Jwts.parserBuilder().setSigningKey(KEY).build().parseClaimsJws(token)
        true
    } catch (e: Exception) {
        false
    }
