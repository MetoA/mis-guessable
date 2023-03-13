package mk.ukim.finki.mis.guessableapi.domain

import jakarta.persistence.*


/**
 * Represents a guess for an existing [Location]
 *
 * @property[id] unique identifier for the guess
 * @property[location] the [Location] to which this guess is meant for
 * @property[guessedBy] the user that created the guess
 * @property[guessedLatitude] the map latitude of the guess
 * @property[guessedLongitude] the map longitude of the guess
 * @property[distance] the distance from the guess to the actual location in kilometers
 * */
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
