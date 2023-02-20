package mk.ukim.finki.mis.guessableapi.security

import io.jsonwebtoken.Jwts
import io.jsonwebtoken.security.Keys
import org.springframework.security.core.Authentication

//private val KEY = Keys.secretKeyFor(SignatureAlgorithm.HS256)
private val KEY = Keys.hmacShaKeyFor("this-is-an-extremely-super-duper-secure-key".toByteArray())

fun generateJwtToken(authentication: Authentication): String =
    Jwts.builder().setSubject(authentication.name).signWith(KEY).compact()

fun getUsernameFromJwtToken(token: String): String =
    Jwts.parserBuilder().setSigningKey(KEY).build().parseClaimsJws(token).body.subject

fun isValidJwtToken(token: String) =
    try {
        Jwts.parserBuilder().setSigningKey(KEY).build().parseClaimsJws(token)
        true
    } catch (e: Exception) {
        false
    }
