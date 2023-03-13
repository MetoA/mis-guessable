package mk.ukim.finki.mis.guessableapi.service

import mk.ukim.finki.mis.guessableapi.domain.GuessableUser
import mk.ukim.finki.mis.guessableapi.repository.UserRepository
import org.springframework.security.authentication.AuthenticationManager
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken
import org.springframework.security.core.Authentication
import org.springframework.security.core.context.SecurityContextHolder
import org.springframework.security.crypto.password.PasswordEncoder
import org.springframework.stereotype.Service

/**
 * Service for handling authentication
 *
 * @param[repository] [UserRepository] for communication with the database for [GuessableUser] entity
 * @param[authenticationManager] [AuthenticationManager] for managing the authentication of the user
 * @param[passwordEncoder] [PasswordEncoder] for encoding the password to securely store it in the database
 * */
@Service
class AuthService(
    val repository: UserRepository,
    val authenticationManager: AuthenticationManager,
    val passwordEncoder: PasswordEncoder
) {

    /**
     * A function for logging the user in
     *
     * @param[username] the username of the user being logged in
     * @param[password] the unencrypted password of the user being logged in
     * @return[Authentication]
     * */
    fun login(username: String, password: String): Authentication =
        authenticationManager.authenticate(UsernamePasswordAuthenticationToken(username, password)).also {
            SecurityContextHolder.getContext().authentication = it
        }

    /**
     * A function for registering a user
     *
     * @param[username] the username of the user being logged
     * @param[password] the unencrypted password of the user being registered
     * */
    fun register(username: String, password: String) {
        repository.save(GuessableUser(0, username, passwordEncoder.encode(password)))
    }
}
