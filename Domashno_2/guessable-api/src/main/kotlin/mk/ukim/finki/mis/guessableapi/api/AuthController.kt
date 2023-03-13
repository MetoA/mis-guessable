package mk.ukim.finki.mis.guessableapi.api

import mk.ukim.finki.mis.guessableapi.requests.AuthRequest
import mk.ukim.finki.mis.guessableapi.responses.JwtTokenResponse
import mk.ukim.finki.mis.guessableapi.security.generateJwtToken
import mk.ukim.finki.mis.guessableapi.service.AuthService
import org.springframework.web.bind.annotation.PostMapping
import org.springframework.web.bind.annotation.RequestBody
import org.springframework.web.bind.annotation.RequestMapping
import org.springframework.web.bind.annotation.RestController

/**
 * A rest controller that handles API endpoints related to authentication in the application
 *
 * @param[service] authentication service that interacts with the repository
 * @see[AuthService]
 * */

@RestController
@RequestMapping("/api/auth")
class AuthController(val service: AuthService) {

    /**
     * A rest endpoint that handles logging into the application
     *
     * @param[request] class that models the request that needs to be sent to this endpoint to successfully login
     * @return[JwtTokenResponse] class that models the response of a JWT token and username of the logged in user
     * @see[AuthRequest]
     * */
    @PostMapping("/login")
    fun login(@RequestBody request: AuthRequest) = with(request) {
        val authentication = service.login(username, password)
        JwtTokenResponse(generateJwtToken(authentication), authentication.name)
    }

    /**
     * A rest endpoint that handles registering an account into the application
     *
     * @param[request] class that models the request that needs to be sent to this endpoint to successfully register
     * @see[AuthRequest]
     * */
    @PostMapping("/register")
    fun register(@RequestBody request: AuthRequest) = with(request) {
        service.register(username, password)
    }
}
