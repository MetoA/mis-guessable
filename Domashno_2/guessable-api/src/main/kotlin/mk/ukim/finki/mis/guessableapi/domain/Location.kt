package mk.ukim.finki.mis.guessableapi.domain

import com.fasterxml.jackson.annotation.JsonIgnore
import jakarta.persistence.*

/**
 * Represents a guessable location
 *
 * @property[id] unique identifier for the location
 * @property[latitude] the map latitude of the location
 * @property[longitude] the map longitude of the location
 * @property[image] [ByteArray] of the taken image for the location
 * @property[createdBy] the user that created the guessable location
 * */
@Entity
@Table(name = "locations")
data class Location(
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    val id: Long,

    @Column(name = "latitude")
    val latitude: Double,

    @Column(name = "longitude")
    val longitude: Double,

    @JsonIgnore
    @Column(name = "image")
    val image: ByteArray,

    @ManyToOne
    @JoinColumn(name = "created_by")
    val createdBy: GuessableUser,
)
