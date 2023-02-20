package mk.ukim.finki.mis.guessableapi.repository

import mk.ukim.finki.mis.guessableapi.domain.Location
import org.springframework.data.jpa.repository.JpaRepository
import org.springframework.data.jpa.repository.Query
import org.springframework.stereotype.Repository

@Repository
interface LocationRepository : JpaRepository<Location, Long> {

    @Query(value = "select * from locations limit 1 offset :randomNum", nativeQuery = true)
    fun getRandomLocation(randomNum: Long): Location
}
