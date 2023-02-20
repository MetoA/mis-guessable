package mk.ukim.finki.mis.guessableapi.domain

import jakarta.persistence.*

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
