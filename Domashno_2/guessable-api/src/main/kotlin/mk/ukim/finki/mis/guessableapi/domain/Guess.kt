package mk.ukim.finki.mis.guessableapi.domain

import jakarta.persistence.*

@Entity
@Table(name = "guesses")
data class Guess(
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    val id: Long,

    @ManyToOne
    @JoinColumn(name = "location")
    val location: Location,

    @ManyToOne
    @JoinColumn(name = "guessed_by")
    val guessedBy: GuessableUser,

    @Column(name = "guessed_latitude")
    val guessedLatitude: Double,

    @Column(name = "guessed_longitude")
    val guessedLongitude: Double,

    @Column(name = "distance")
    val distance: Double,
)
