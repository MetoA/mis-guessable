package mk.ukim.finki.mis.guessableapi.service

import mk.ukim.finki.mis.guessableapi.repository.UserRepository
import org.springframework.security.core.authority.SimpleGrantedAuthority
import org.springframework.security.core.userdetails.User
import org.springframework.security.core.userdetails.UserDetails
import org.springframework.security.core.userdetails.UserDetailsService
import org.springframework.security.core.userdetails.UsernameNotFoundException
import org.springframework.stereotype.Service

@Service
class UserService(val repository: UserRepository) : UserDetailsService {

    override fun loadUserByUsername(username: String?): UserDetails =
        repository.findByUsername(username)?.let {
            User(
                it.username,
                it.password,
                listOf(SimpleGrantedAuthority("user"))
            )
        } ?: throw UsernameNotFoundException("User with username [$username] not found")

    fun findByUsername(username: String) = repository.findByUsername(username)
}
