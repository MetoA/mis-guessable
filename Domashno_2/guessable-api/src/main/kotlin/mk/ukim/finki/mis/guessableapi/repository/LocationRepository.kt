package mk.ukim.finki.mis.guessableapi.repository

import mk.ukim.finki.mis.guessableapi.domain.Location
import org.springframework.data.jpa.repository.JpaRepository
import org.springframework.data.jpa.repository.Query
import org.springframework.stereotype.Repository

/**
 * A repository that communicates with the database for the [Location] entity
 * */
@Repository
interface LocationRepository : JpaRepository<Location, Long> {

    /**
     * A function that returns a random [Location] to be guessed
     *
     * @param[guessedIds] a list of [Long] ids of guessed ids to know not to return a [Location] that has already been guessed
     * @return [Location] or null if none are left to be guessed
     * */
    @Query("select * from locations where id not in (:guessedIds) limit 1", nativeQuery = true)
    fun getRandomLocation(guessedIds: List<Long>): Location?
}
