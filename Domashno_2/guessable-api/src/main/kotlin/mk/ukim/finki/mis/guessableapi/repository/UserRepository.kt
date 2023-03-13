package mk.ukim.finki.mis.guessableapi.repository

import mk.ukim.finki.mis.guessableapi.domain.GuessableUser
import org.springframework.data.jpa.repository.JpaRepository
import org.springframework.stereotype.Repository

/**
 * A repository that communicates with the database for the [GuessableUser] entity
 * */
@Repository
interface UserRepository : JpaRepository<GuessableUser, Long> {

    /**
     * A function that gets the [GuessableUser] entity by a username
     *
     * @param[username] the username of the [GuessableUser]
     * @return [GuessableUser] or null if a user does not exist by the provided username
     * */
    fun findByUsername(username: String?): GuessableUser?
}
