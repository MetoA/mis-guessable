package mk.ukim.finki.mis.guessableapi.domain

import jakarta.persistence.*

/**
 * Represents a user for the application
 *
 * @property[id] unique identifier for the user
 * @property[username] unique username that identifies the user and is used for logging in
 * @property[password] encrypted password that is used for logging into the application securely
 * */
@Entity
@Table(name = "users")
data class GuessableUser(
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    val id: Long,

    @Column(name = "username")
    val username: String,

    @Column(name = "password")
    val password: String
)
