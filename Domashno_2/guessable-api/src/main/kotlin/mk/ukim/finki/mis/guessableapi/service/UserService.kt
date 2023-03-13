package mk.ukim.finki.mis.guessableapi.service

import mk.ukim.finki.mis.guessableapi.domain.GuessableUser
import mk.ukim.finki.mis.guessableapi.repository.UserRepository
import org.springframework.security.core.authority.SimpleGrantedAuthority
import org.springframework.security.core.userdetails.User
import org.springframework.security.core.userdetails.UserDetails
import org.springframework.security.core.userdetails.UserDetailsService
import org.springframework.security.core.userdetails.UsernameNotFoundException
import org.springframework.stereotype.Service

/**
 * A service for managing users
 *
 * @param[repository] [UserRepository] for managing users in the database
 * */
@Service
class UserService(val repository: UserRepository) : UserDetailsService {


    /**
     * A function for getting [UserDetails] for a specific username
     *
     * @return[UserDetails]
     * @throws[UsernameNotFoundException] if the username does not exist in the database
     * */
    override fun loadUserByUsername(username: String?): UserDetails =
        repository.findByUsername(username)?.let {
            User(
                it.username,
                it.password,
                listOf(SimpleGrantedAuthority("user"))
            )
        } ?: throw UsernameNotFoundException("User with username [$username] not found")

    /**
     * A function for returning the [GuessableUser] for a username
     *
     * @param[username] the username of the user
     * @return [GuessableUser] or null
     * */
    fun findByUsername(username: String): GuessableUser? = repository.findByUsername(username)
}
