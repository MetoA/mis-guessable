package mk.ukim.finki.mis.guessableapi.repository

import mk.ukim.finki.mis.guessableapi.domain.GuessableUser
import org.springframework.data.jpa.repository.JpaRepository
import org.springframework.stereotype.Repository

@Repository
interface UserRepository : JpaRepository<GuessableUser, Long> {

    fun findByUsername(username: String?): GuessableUser?
}
