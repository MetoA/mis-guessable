package mk.ukim.finki.mis.guessableapi.service

import mk.ukim.finki.mis.guessableapi.domain.GuessableUser
import mk.ukim.finki.mis.guessableapi.repository.UserRepository
import org.springframework.security.authentication.AuthenticationManager
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken
import org.springframework.security.core.Authentication
import org.springframework.security.core.context.SecurityContextHolder
import org.springframework.security.crypto.password.PasswordEncoder
import org.springframework.stereotype.Service

@Service
class AuthService(
    val repository: UserRepository,
    val authenticationManager: AuthenticationManager,
    val passwordEncoder: PasswordEncoder
) {
    fun login(username: String, password: String): Authentication =
        authenticationManager.authenticate(UsernamePasswordAuthenticationToken(username, password)).also {
            SecurityContextHolder.getContext().authentication = it
        }

    fun register(username: String, password: String) {
        repository.save(GuessableUser(0, username, passwordEncoder.encode(password)))
    }
}
