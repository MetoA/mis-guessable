package mk.ukim.finki.mis.guessableapi.domain

import com.fasterxml.jackson.annotation.JsonIgnore
import jakarta.persistence.*

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

    @Column(name = "image")
    val image: ByteArray,

    @ManyToOne
    @JsonIgnore
    @JoinColumn(name = "created_by")
    val createdBy: GuessableUser,
)
