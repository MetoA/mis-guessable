package mk.ukim.finki.mis.guessableapi.repository

import mk.ukim.finki.mis.guessableapi.domain.Location
import org.springframework.data.jpa.repository.JpaRepository
import org.springframework.data.jpa.repository.Query
import org.springframework.stereotype.Repository

@Repository
interface LocationRepository : JpaRepository<Location, Long> {

    @Query("select * from locations where id not in (:guessedIds) limit 1", nativeQuery = true)
    fun getRandomLocation(guessedIds: List<Long>): Location?
}
